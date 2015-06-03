package com.luobo.service.login.impl;

import com.ebiz.base.util.Assert;

import com.luobo.common.entity.user.User;
import com.luobo.common.enums.EnabledEnums;
import com.luobo.service.login.LoginManageService;
import com.luobo.service.login.SubjectStore;
import com.luobo.service.user.UserService;
import com.pandawork.core.exception.SSException;
import com.pandawork.core.log.LogClerk;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.mgt.DefaultSecurityManager;
import org.apache.shiro.session.ExpiredSessionException;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ThreadContext;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;

@Service("loginManageService")
public class LoginManageServiceImpl implements LoginManageService {
    // 登录用户的cooki标识符
    private final static String LoggedCookieUserIdName = "uid";

    @Autowired
    @Qualifier("securityManager")
    private DefaultSecurityManager securityManager;

    @Autowired
    @Qualifier("sessionIdCookie")
    private SimpleCookie simpleCookie;

    //用户登录Service
    @Autowired
    @Qualifier("userService")
    private UserService userService;

    // TGT票的存储
    @Autowired(required = false)
    private SubjectStore subjectStore = new SujectStorDefaultImpl();

    @PostConstruct
    public void init() {
        SecurityUtils.setSecurityManager(securityManager);
    }

    @Override
    public Subject isLogined(HttpServletRequest request) throws SSException {
        String uidCookie = this.queryCookieValue(request, LoggedCookieUserIdName);
        if (Assert.isNull(uidCookie)) {
            // 用户ID为空，则说明用户没登录过。
            return null;
        }

        Subject subject = this.querySubject(request);
        if (Assert.isNull(subject)) {
            // 按照TGT去找，没有找到用户对象
            return null;
        }

        if (!subject.isAuthenticated()) {
            return null;
        }

        String loginName = "";
        try {
            loginName = (String) subject.getPrincipal();
        } catch (UnknownSessionException e) {
            LogClerk.errLog.error(e);

            // 删除subject
            this.delSubject(request);
            return null;
        } catch (ExpiredSessionException e) {
            LogClerk.errLog.error(e);

            // 删除subject
            this.delSubject(request);
            return null;
        }
        User user = null;
        //这里如果用户不存在，或者已经被禁用。则得到一个null user
        try {
            user = userService.queryUerByLoginName(loginName);
        } catch (Exception e) {
            LogClerk.errLog.error(e);
        }
        if (Assert.isNull(user)) {

            return null;
        }

        //  如果两个不一直，则识别为空,或者用户被封禁
        if (user.getId() == null || !user.getId().toString().equals(uidCookie)
                || user.getEnabled() == null
                || user.getEnabled().equals(EnabledEnums.Disabled.getId())) {
            return null;
        }

        // 绑定到当前的现成中
        ThreadContext.bind(subject);
        return subject;
    }

    @Override
    public void logOut(HttpServletRequest request) throws SSException {
        String uidCookie = this.queryCookieValue(request, LoggedCookieUserIdName);
        if (Assert.isNull(uidCookie)) {
            // 用户ID为空，则说明用户没登录过。
            return;
        }

        Subject subject = this.querySubject(request);
        if (Assert.isNull(subject)) {
            // 按照TGT去找，没有找到用户对象
            return;
        }

        subject.logout();
    }

    @Override
    public void addSubject(Subject subject) throws SSException {
        subjectStore.addTGT(subject.getSession().getId().toString(), subject);
        ThreadContext.bind(subject);
    }

    @Override
    public void generatTGT(String sessionId, HttpServletRequest request, HttpServletResponse response) throws SSException {
        Subject subject = subjectStore.querySubject(sessionId);
        if (Assert.isNull(subject)) {
            // 如果已经不存在，则不需要进行再次生成。
            return;
        }

        // 保存到客户端中
        storeSessionId(subject.getSession().getId(), request, response);
        // 和当前现成绑定
        ThreadContext.bind(subject);

        // 按照用户名获取用户ID
        String loginName = (String) subject.getPrincipal();
        User user = userService.queryUerByLoginName(loginName);
        if (Assert.isNull(user)) {
            return;
        }
        // 保存用户端额ID
        storeUidCookie(user.getId(), request, response);
    }

    @Override
    public Subject querySubject(HttpServletRequest request) throws SSException {

        // 获取到cookie，
        String subjectCookie = this.queryCookieValue(request, simpleCookie.getName());
        if (Assert.isNull(subjectCookie)) {
            // tgt为空，则说明用户没登录过
            return null;
        }

        Subject subject = subjectStore.querySubject(subjectCookie);
        if (Assert.isNull(subject)) {
            // 按照TGT去找，没有找到用户对象
            return null;
        }

        return subject;
    }

    @Override
    public Subject delSubject(HttpServletRequest request) throws SSException {

        // 获取到cookie，
        String subjectCookie = this.queryCookieValue(request, simpleCookie.getName());
        if (Assert.isNull(subjectCookie)) {
            // tgt为空，则说明用户没登录过
            return null;
        }

        Subject subject = subjectStore.delTGT(subjectCookie);
        if (Assert.isNull(subject)) {
            // 按照TGT去找，没有找到用户对象
            return null;
        }

        return subject;
    }

    /////////////////////////// private method ///////////////////////////

    private void storeSessionId(Serializable currentId, HttpServletRequest request, HttpServletResponse response) {
        if (currentId == null) {
            String msg = "sessionId cannot be null when persisting for subsequent requests.";
            throw new IllegalArgumentException(msg);
        }
        org.apache.shiro.web.servlet.Cookie template = simpleCookie;
        org.apache.shiro.web.servlet.Cookie cookie = new SimpleCookie(template);
        String idString = currentId.toString();
        cookie.setValue(idString);
        cookie.saveTo(request, response);
    }

    private void storeUidCookie(Serializable currentId, HttpServletRequest request, HttpServletResponse response) {
        org.apache.shiro.web.servlet.Cookie template = simpleCookie;
        org.apache.shiro.web.servlet.Cookie cookie = new SimpleCookie(template);
        String idString = currentId.toString();
        cookie.setName(LoggedCookieUserIdName);
        cookie.setValue(idString);
        cookie.saveTo(request, response);
    }

    private String queryCookieValue(HttpServletRequest request, String cookieName) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(cookieName)) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
}
