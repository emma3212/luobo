package com.luobo.service.user;

import com.luobo.common.entity.user.User;
import com.pandawork.core.exception.SSException;
import org.apache.shiro.subject.Subject;

/**
 * 用户登录Service。
 *
 * Created by Lionel on 2014/12/18.
 */
public interface UserService {


    /**
     * 验证用户是否具有合法的身份进入。
     * @param loginName  登录时候使用的key值
     * @param pwd        登录密码
     * @return          null表示非法用户；如果返回非空值，则说明是验证通过。
     * @throws com.pandawork.core.exception.SSException
     */
    public Subject validLogin(String loginName, String pwd) throws SSException;

    /**
     * 按照ID查询安全用户的的那个路
     * @param id
     * @return
     * @throws com.pandawork.core.exception.SSException
     */
    public User queryById(int id) throws SSException;

    /**
     * 按照用户名获取安全用户
     * @param loginName
     * @return
     * @throws com.pandawork.core.exception.SSException
     */
    public User queryUerByLoginName(String loginName) throws SSException;

    /**
     * 按照ID更新密码，密码使用的是md5加密。
     * @param id
     * @param oldPwd
     * @param pwd
     * @param conformPwd  @throws SSException
     * */
    public void updatePwdById(int id, String oldPwd, String pwd, String conformPwd) throws SSException;

    /**
     * 根据id删除
     *
     * @param id
     * @throws com.pandawork.core.exception.SSException
     */
    public void del(int id) throws SSException;

    /**
     * 查询登录用户是否存在
     *
     * @param loginName
     * @throws com.pandawork.core.exception.SSException
     */
    public void queryLoginNameIsExist(String loginName) throws SSException;

    /**
     * 新建一个登录用户
     * @param login
     * @param conformPwd
     * @return
     * @throws com.pandawork.core.exception.SSException
     */
    public User add(User login, String conformPwd) throws  SSException;

}
