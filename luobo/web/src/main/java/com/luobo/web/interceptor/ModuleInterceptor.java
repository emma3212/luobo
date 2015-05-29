package com.luobo.web.interceptor;

import com.luobo.common.annotation.Module;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ModuleInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (!(handler instanceof HandlerMethod)) {
            // 如果不是方法请求地址，则不拦截。
            return true;
        }

        // 获取类级别的权限
        Module classAnno = ((HandlerMethod) handler).getBean().getClass().getAnnotation(Module.class);
        if(classAnno != null) {
            request.setAttribute("PWModule", classAnno.value().getName());
        }
        // 获取方法级别的权限
        Module methodAnno = ((HandlerMethod) handler).getMethod().getAnnotation(Module.class);
        if(methodAnno != null) {
            request.setAttribute("MethodModule", methodAnno.value().getName());
        }

        return true;
    }
}