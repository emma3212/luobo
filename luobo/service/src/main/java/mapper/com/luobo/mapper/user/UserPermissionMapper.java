package com.luobo.mapper.user;

import com.luobo.common.entity.user.UserPermission;

import java.util.List;

/**
 * 用户、组关联表mapper
 * <p/>
 * Created by lionel on 2014/5/28
 */
public interface UserPermissionMapper {

    /**
     * 按照loginName查询权限列表
     *
     * @param loginName
     * @return
     * @throws Exception
     */
    public List<UserPermission> queryPermissionByLoginName(String loginName) throws Exception;

    /**
     * 按照userId查询权限列表
     *
     * @param userId
     * @return
     * @throws Exception
     */
    public List<UserPermission> queryPermissionByUserId(int userId) throws Exception;

}
