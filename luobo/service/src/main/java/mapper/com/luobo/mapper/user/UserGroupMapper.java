package com.luobo.mapper.user;

import com.luobo.common.entity.user.UserGroup;

/**
 * 用户、组关联表mapper
 *
 * Created by lionel on 2014/5/28
 */
public interface UserGroupMapper {

    /**
     * 根据loginName查询用户安全组
     *
     * @param loginName
     * @return
     * @throws Exception
     */
    public UserGroup queryUserGroupByLoginName(String loginName) throws Exception;

    /**
     * 根据userId查询用户安全组
     *
     * @param userId
     * @return
     * @throws Exception
     */
    public UserGroup queryUserGroupByUserId(int userId) throws Exception;
}
