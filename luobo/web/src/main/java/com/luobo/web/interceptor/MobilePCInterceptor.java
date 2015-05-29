package com.luobo.web.interceptor;

import com.luobo.common.utils.WebConstants;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 判断是移动端浏览器还是PC端浏览器。
 * Created by lionel on 2014/10/21.
 */
public class MobilePCInterceptor extends HandlerInterceptorAdapter {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        if (!(handler instanceof HandlerMethod)) {
            // 如果不是方法请求地址，则不拦截。
            return true;
        }

        String userAgent = request.getHeader("User-Agent");
        System.out.println("user-agent:" + userAgent);
        if(userAgent.indexOf("Mobile") > 0) {
            // 手机端接入
            request.setAttribute(WebConstants.MOBILE_PC_BROWSER, true);
        } else {
            // 移动端接入
            request.setAttribute(WebConstants.MOBILE_PC_BROWSER, false);
        }

        return true;
    }
}
