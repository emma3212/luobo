package com.luobo.web.interceptor;

import com.luobo.common.annotation.IgnoreAuthorization;
import com.luobo.common.annotation.Module;
import com.luobo.common.enums.ModuleEnums;
import com.luobo.service.login.LoginManageService;
import com.pandawork.core.log.LogClerk;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 权限验证拦截器，
 * 对权限进行拦截，先以类级别作为最大的权限集合，然后再进行拦截。
 */
public class AuthorInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    @Qualifier("loginManageService")
    private LoginManageService loginManageService;

    @Override
    //TODO:等待登录系统添加到程序中
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (!(handler instanceof HandlerMethod)) {
            // 如果不是方法请求地址，则不拦截。
            return true;
        }

        // 获取到Subject。
        Subject subject = loginManageService.querySubject(request);
        if(subject == null) {
            // TODO 需要对其进行一些默认权限
            // 如果当前权限为空，则放行。
            return true;
        }

        // 验证是否有忽略的表示
        IgnoreAuthorization ignoreCla = ((HandlerMethod) handler).getBean().getClass().getAnnotation(IgnoreAuthorization.class);
        IgnoreAuthorization ignoreMethod = ((HandlerMethod) handler).getMethod().getAnnotation(IgnoreAuthorization.class);
        if(ignoreCla != null || ignoreMethod != null) {
            // 如果这两个不为空，则默认忽略掉授权，可以直接通过。
            return true;
        }

        // 获取类级别的权限
        Module classAnno = ((HandlerMethod) handler).getBean().getClass().getAnnotation(Module.class);
        // 获取方法级别的权限
        Module methodAnno = ((HandlerMethod) handler).getMethod().getAnnotation(Module.class);
        LogClerk.sysout.debug("class ignoreInteceptor annotation is not null! means this class need interceptor");
        boolean pass = false;
        if (classAnno == null && methodAnno == null) {
            forwardToFobidden(request, response);
            return false;
        }

        // 类界别的权限有限，其次为方法级别的权限
        // true表示通过，false表示为未能通过
        if(classAnno != null){
            ModuleEnums ms = classAnno.value();
            String[] claPermissions = {ms.getName()};
            try {
                subject.checkPermissions(claPermissions);
                pass = true;
            } catch (UnauthorizedException e) {
                LogClerk.errLog.error(e);
                // response.setStatus(403, "没有权限访问！");
                // forwardToFobidden(request, response);
                pass = false;
//                return false;
            }
        }

        if(methodAnno != null) {   // 如果方法注解不为空，并且类级别的权限未能通过，则继续判断方法界别的权限
            ModuleEnums ms = classAnno.value();
            String[] methodPermissions = {ms.getName()};
            try {
                subject.checkPermissions(methodPermissions);
                pass = true;
            } catch (UnauthorizedException e) {
                LogClerk.errLog.error(e);
                // 这里还未能验证通过，那就没找了。
                // response.setStatus(403, "没有权限访问！");
               //  forwardToFobidden(request, response);
                pass = false;
                return false;
            } catch(IllegalArgumentException e) {
                LogClerk.errLog.error(e);
                RequestDispatcher dispatcher  = request.getRequestDispatcher("/500");
                dispatcher.forward(request, response);

                return false;
            }
        }

        if(!pass) {
            forwardToFobidden(request, response);
            return false;
        }

        return true;
    }

    private void forwardToFobidden(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/403");
        dispatcher.forward(request, response);
    }
}