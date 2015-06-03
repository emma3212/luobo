package com.luobo.service.login;

import com.pandawork.core.exception.SSException;
import org.apache.shiro.subject.Subject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录服务
 *
 * Created by Lionel on 2014/5/30.
 */
public interface LoginManageService {

    /**
     * 是否已经登录
     *
     * @param request 获取请求对象
     * @return
     * @throws com.pandawork.core.exception.SSException
     */
    public Subject isLogined(HttpServletRequest request) throws SSException;

    /**
     * 登出
     *
     * @param request
     * @throws com.pandawork.core.exception.SSException
     */
    public void logOut(HttpServletRequest request) throws SSException;

    /**
     * 添加subject到缓存中
     *
     * @param subject
     * @throws com.pandawork.core.exception.SSException
     */
    public void addSubject(Subject subject) throws SSException;

    /**
     * 生成TGT
     *
     * @param request
     * @param response
     * @return
     * @throws com.pandawork.core.exception.SSException
     */
    public void generatTGT(String sessionId, HttpServletRequest request, HttpServletResponse response) throws SSException;

    /**
     * 查询subject对象。
     *
     * @param request
     * @return
     * @throws com.pandawork.core.exception.SSException
     */
    public Subject querySubject(HttpServletRequest request) throws SSException;

    /**
     * 删除subject
     *
     * @param request
     * @return
     * @throws com.pandawork.core.exception.SSException
     */
    public Subject delSubject(HttpServletRequest request) throws SSException;
}
