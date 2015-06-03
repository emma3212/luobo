package com.luobo.common.utils;

import com.pandawork.core.log.LogClerk;
import com.pandawork.core.sytem.SystemInstance;

import java.io.UnsupportedEncodingException;

/**
 * 常量
 */
public class WebConstants {

    static  {
        // 读取属性文件中的值，设置初值
        SystemInstance systemInstance = SystemInstance.getIntance();
        String temp = "";
        staticWebsite = (String) systemInstance.getProperty("staticWebsite");
        uploadWebsite = (String) systemInstance.getProperty("uploadWebsite");

        temp = (String) systemInstance.getProperty("webTitle");
        try {
            webTitle = new String(temp.getBytes("ISO-8859-1"), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            LogClerk.errLog.error(e.getMessage());
            webTitle = "";
        }
        temp = (String) systemInstance.getProperty("webName");
        try {
            webName = new String(temp.getBytes("ISO-8859-1"), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            LogClerk.errLog.error(e.getMessage());
            webName = "";
        }
        temp = (String) systemInstance.getProperty("webFullName");
        try {
            webFullName = new String(temp.getBytes("ISO-8859-1"), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            LogClerk.errLog.error(e.getMessage());
            webFullName = "";
        }
    }

    //第一平台


    // 网站标题
    public static String webTitle;

    // 网站名称
    public static String webName;

    public static String webFullName;

    public final static String staticWebsite;

    // 文件上传服务器地址
    public static final String uploadWebsite;




    // 用户ID
    public static final String WebUserId = "web_user_id";

    // web端的常量姓名
    public static final String WebUserName = "web_user_name";

    // web端的常量登录名
    public static final String WebLoginName = "web_login_name";

    public static final String WEB_ADMIN_USER_CENTER_KEY = "web_admin_vip_key";

    public static final String FILE_SEPARATOR = "/";

    public static final String ID_CARD_PIC_FOLDER = "/idCardPic/";

    // 内容管理页面url地址(使用时要加上${website})
    public static final String CONTENT_LINK = "content";

    // 用于区分是手机端还是浏览器端，如果是手机端，在request中这个值是true。
    public static final String MOBILE_PC_BROWSER = "mobile_pc_browser_name";

    // 统计代码脚本
    public static final String STATISTICS_SCRIPT = "statistics_script";

    public static final Integer REPAY_DAY = 10;

    // 日期
    public static final String WEB_DATE = "web_date";

    // 逾期数量
    public static final String OVERDUE_NUM = "overdue_num";

    // 白条订单数量
    public static final String WHITE_BAR_REPAY_ORDER = "white_bar_repay_order";

    // 产品订单数量
    public static final String PRODUCT_REPAY_ORDER = "product_repay_order";

    // 随意还订单数量
    public static final String ANY_REPAY_ORDER = "any_repay_order";

    //未审核会员数量
    public static final String Not_Checked_Vip_Num = "not_checked_vip_num";
}
