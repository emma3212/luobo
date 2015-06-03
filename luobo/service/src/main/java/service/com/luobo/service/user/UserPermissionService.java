package com.luobo.service.user;

import com.luobo.common.entity.user.UserPermission;
import com.pandawork.core.exception.SSException;

import java.util.List;

/**
 * 权限Service。负责对权限的管理，查询功能。
 *
 * Created by Lionel on 2014/5/28.
 */
public interface UserPermissionService {

	/**
	 * 按照用户ID查询权限列表
     *
	 * @param userId
	 * @throws com.pandawork.core.exception.SSException
	 */
	public List<UserPermission> queryPermissionByUserId(int userId) throws SSException;

    /**
     * 按照登录名查询权限列表
     *
     * @param loginName
     * @return
     * @throws com.pandawork.core.exception.SSException
     */
    public List<UserPermission> queryPermissionByLoginName(String loginName) throws SSException;

}
