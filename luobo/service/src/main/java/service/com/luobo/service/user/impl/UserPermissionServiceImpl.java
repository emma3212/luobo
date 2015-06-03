package com.luobo.service.user.impl;

import com.ebiz.base.util.Assert;
import com.luobo.common.entity.user.UserPermission;
import com.luobo.mapper.user.UserPermissionMapper;
import com.luobo.service.user.UserPermissionService;
import com.pandawork.core.exception.ExceptionMes;
import com.pandawork.core.exception.SSException;
import com.pandawork.core.log.LogClerk;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service("userPermissionService")
public class UserPermissionServiceImpl implements UserPermissionService {

    @Autowired
    private UserPermissionMapper userPermissionMapper;

    @Override
    public List<UserPermission> queryPermissionByUserId(int userId) throws SSException{
        List<UserPermission> list = Collections.emptyList();
        if (Assert.lessOrEqualZero(userId)) {
            // 如果为空，则不需要返回
            return list;
        }

        try {
            list = userPermissionMapper.queryPermissionByUserId(userId);
        } catch (Exception e) {
            LogClerk.errLog.error(e);
            throw SSException.get(ExceptionMes.SYSEXCEPTION, e);
        }

        return list;
    }


    @Override
    public List<UserPermission> queryPermissionByLoginName(String loginName) throws SSException{
        List<UserPermission> list = Collections.emptyList();
        if(Assert.isNull(loginName)) {
            // 如果为空，则不需要返回
            return list;
        }

        try {
            list = userPermissionMapper.queryPermissionByLoginName(loginName);
        } catch (Exception e) {
            LogClerk.errLog.error(e);
            throw SSException.get(ExceptionMes.SYSEXCEPTION, e);
        }

        return list;
    }

}
