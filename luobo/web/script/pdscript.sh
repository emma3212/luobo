#!/bin/bash
#Program:
#1、发布脚本。
#   发布脚本分为两部分：1.1 更新静态文件脚本； 1.2 更新发布程序脚本。
#   可以一次性更新两个操作。
#2、使用nginx构建静态域名
#3、使用nginx对动态webserver进行发布。
#History:2012/08、01 lijx First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/maven/bin:~/bin
export PATH

#定义静态文件夹的位置以及项目发布程序的位置
staticLocation=/leave/deploy/static
baseStaticLocation=/leave/deploy/static/resources/
libStaticLocation=/leave/deploy/static/
pageStaticLocation=/leave/deploy/static/

webLocation=/leave/my-app/code

svnStaticLocation=/leave/staticsvn/main/*
basesvnStaticLocation=/leave/staticsvn/base/*
libsvnStaticLocation=/leave/staticsvn/lib/*
pagesvnStaticLocation=/leave/staticsvn/page/*
#文件锁
lockFile=/leave/lock.txt
#日志地址
pdlog="./pdlog.log"

#定义svn相关地址变量
#svnStatic=http://as3xls.googlecode.com/svn/trunk/src/tests
#svnWeb="http://as3xls.googlecode.com/svn/trunk/src/tests"
tomcat=/opt/apache-tomcat

#加锁
if [ -f $lockFile ]; then
   echo "当前有别的用户正在执行该操作，请您稍后重试哦..."; exit 0
else
   touch $lockFile
fi
             
#输入操作名称
while [ "$operate" != "static" -a "$operate" != "web" -a "$operate" != "all" -a "$operate" != "q" ]
do
    read -p "请你输入操作名称(static、web、all、q): " operate
done
#更新静态文件函数
function static(){
    echo -e  "开始更新静态文件..."
	
	rm -rf $staticLocation/*
	
    svn update $svnStaticLocation && echo -e "静态文件更新成功！\n"
    cp -ra $svnStaticLocation $staticLocation
	
	svn update $basesvnStaticLocation && echo -e "base静态文件更新成功！\n"
    cp -ra $basesvnStaticLocation $baseStaticLocation/js/
	
	svn update $libsvnStaticLocation && echo -e "base静态文件更新成功！\n"
    cp -ra $libsvnStaticLocation $libStaticLocation
	
	svn update $pagesvnStaticLocation && echo -e "base静态文件更新成功！\n"
    cp -ra $pagesvnStaticLocation $pageStaticLocation
	
	release
}
#更新发布程序函数
function web(){
    #read -p "请输入发布程序的svn地址 如果只是想update请输入"update": " svnWeb
    echo -e  "\n开始更新发布程序...\n"
    #if [ "$svnWeb" != "update" ]; then
    #    svn co $svnWeb $webLocation | tee -a $pdlog            #从svn上下载文件
    #else
    svn update $webLocation && echo -e "发布程序更新完毕！\n" || release
    #fi
    
    echo -e "\n开始打包发布程序...\n"
        cd $webLocation
        mvn clean && echo "mvn clean 成功" || release
        mvn package && echo "mvn package 成功" || release
    echo -e "\n发布程序打包完成，开始重启服务并重新发布程序...\n"
        cp target/*.war $tomcat/webapps/pdapp.war && echo "拷贝war成功" || release
        cd $tomcat/webapps
        rm -rf pdapp                            #删除掉原来的发布项目 
        cd $tomcat/bin
        #./shutdown.sh -s | tee -a $pdlog
        killall java && echo "关闭Tomcat成功！" || release
        ./startup.sh && echo "Tomcat 重启完成！项目成功重部！" || release
    #echo "如果上面没有错误，就结束了哦！"
}
#同时更新静态文件和发布程序脚本
function all(){
    static
    web
}

#解锁 并且退出程序
function release(){
    rm -rf $lockFile
    exit 0
}
#根据输入的操作调用对应的函数
case $operate in
   "static")
        static
    ;;
    "web")
        web
    ;;
    "all")
        all
    ;;
    "q")
        release
    ;;
esac

release
