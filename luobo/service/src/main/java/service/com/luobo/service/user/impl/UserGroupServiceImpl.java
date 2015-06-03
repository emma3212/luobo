package com.luobo.service.user.impl;

import com.ebiz.base.util.Assert;
import com.luobo.common.entity.user.UserGroup;
import com.luobo.mapper.user.UserGroupMapper;
import com.luobo.service.user.UserGroupService;
import com.pandawork.core.exception.ExceptionMes;
import com.pandawork.core.exception.SSException;
import com.pandawork.core.log.LogClerk;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userGroupService")
public class UserGroupServiceImpl implements UserGroupService {

	@Autowired
	private UserGroupMapper userGroupMapper;

    @Override
    public UserGroup queryUserGroupByLoginName(String loginName) throws SSException {
        if (Assert.isNull(loginName)) {
            return null;
        }
        try {
            return userGroupMapper.queryUserGroupByLoginName(loginName);
        } catch (Exception e) {
            LogClerk.errLog.error(e);
            throw SSException.get(ExceptionMes.SYSEXCEPTION, e);
        }
    }

    @Override
    public UserGroup queryUserGroupByUserId(int userId) throws SSException {
        if (Assert.lessOrEqualZero(userId)) {
            return null;
        }
        try {
            return userGroupMapper.queryUserGroupByUserId(userId);
        } catch (Exception e) {
            LogClerk.errLog.error(e);
            throw SSException.get(ExceptionMes.SYSEXCEPTION, e);
        }
    }
}
