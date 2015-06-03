package com.luobo.mapper.user;

import com.luobo.common.entity.user.User;
import org.apache.ibatis.annotations.Param;

/**
 * 用户登录mapper
 *
 * Created by yusheng on 2014/12/18.
 */
public interface UserMapper {

    /**
     * 根据登录名查找用户
     *
     * @param loginName
     * @return
     * @throws Exception
     */
    public User queryUserByLoginName(@Param("loginName") String loginName) throws Exception;

    /**
     * 计算登录用户的数量
     *
     * @param loginName
     * @return
     * @throws Exception
     */
    public int countLoginName(@Param("loginName") String loginName) throws Exception;

    /**
     * 更新密码
     *
     * @param pwd
     * @throws Exception
     */
    public void updatePwdById(@Param("id") int id, @Param("pwd") String pwd) throws Exception;

}
