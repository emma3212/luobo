package com.luobo.service.user;

import com.luobo.common.entity.user.UserGroup;
import com.pandawork.core.exception.SSException;

/**
 * 用户安全组Service定义
 *
 * Created by Lionel on 2014/5/28.
 */
public interface UserGroupService {


    /**
     * 根据loginName获取用户安全组
     *
     * @param loginName
     * @return
     * @throws com.pandawork.core.exception.SSException
     */
    public UserGroup queryUserGroupByLoginName(String loginName) throws SSException;

    /**
     * 根据userId获取用户安全组
     *
     * @param userId
     * @return
     * @throws com.pandawork.core.exception.SSException
     */
    public UserGroup queryUserGroupByUserId(int userId) throws SSException;

}
