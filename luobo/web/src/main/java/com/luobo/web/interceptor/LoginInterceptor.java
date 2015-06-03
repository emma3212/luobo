package com.luobo.web.interceptor;

import com.luobo.common.annotation.IgnoreLogin;
import com.luobo.common.entity.user.User;
import com.luobo.common.enums.CookieNameEnums;
import com.luobo.common.utils.CookieUtil;
import com.luobo.common.utils.WebConstants;
import com.luobo.service.login.LoginManageService;
import com.luobo.service.user.UserService;
import com.pandawork.core.log.LogClerk;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	@Qualifier("loginManageService")
	private LoginManageService loginManageService;

    @Autowired
    @Qualifier("userService")
    private UserService userService;

    @Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String ssoServerURL = (String) request.getAttribute("website");
		if (!(handler instanceof HandlerMethod)) {
			// 如果不是方法请求地址，则不拦截。
			return true;
		}

		// 判断类中是否有忽略注解，如果有，则直接放过。
		IgnoreLogin classAnno = ((HandlerMethod) handler).getBean().getClass().getAnnotation(IgnoreLogin.class);
		LogClerk.sysout.debug("class ignoreInteceptor annotation is not null! means this class need interceptor");

		// 判断方法是否有忽略登录拦截，如果有，则直接放过。
		IgnoreLogin methodAnno = ((HandlerMethod) handler).getMethod().getAnnotation(IgnoreLogin.class);

		LogClerk.sysout.debug("method" + ((HandlerMethod) handler).getMethod().getName() + " ignoreInteceptor annotation is null or it's required == false means method can't ignore inteceptor ! ");

		String serviceURL = this.getBasepath(request);

		Subject subject = loginManageService.isLogined(request);

		if (subject != null) {
			// 说明已经登录过，不需要进行验证登录
            User user = userService.queryUerByLoginName((String) subject.getPrincipal());

            // 将当前登录用户的loginName、id、放入cookie中
			CookieUtil.setCookie(response, CookieNameEnums.WebUserId, String.valueOf(user.getId()));
			CookieUtil.setCookie(response, CookieNameEnums.WebLoginName, user.getLoginName());

			request.setAttribute(WebConstants.WebUserId, user.getId());
			request.setAttribute(WebConstants.WebUserName, user.getName());
            request.setAttribute(WebConstants.WebLoginName, user.getLoginName());
			request.setAttribute(WebConstants.WEB_ADMIN_USER_CENTER_KEY, user.getGroupId());

            return true;
		}

        if (classAnno != null) {
            return true;
        }

        if (methodAnno != null) {
            return true;   //如果方法中有忽略拦截的注解
        }

		// 执行到这里，则说明该用户没有记性登录。
		if (((HandlerMethod) handler).getMethod().getAnnotation(ResponseBody.class) != null) {
			// TODO 如果是返回内容对象的方法，则直接返回固定代码。
			response.getWriter().append("0");   // TODO 有待确认最后的代码情况。
			response.getWriter().flush();
			return false;
		}

		// 如果不是ResponseBody，则需要继续后面的跳转。
		String rURL = serviceURL + request.getServletPath();
		RequestMethod[] rm = ((HandlerMethod) handler).getMethod().getAnnotation(RequestMapping.class).method();
		boolean found = false;
		for (RequestMethod r : rm) {
			if (r.equals(RequestMethod.GET)) {
				found = true;
				break;
			}
		}
		if (!found) {   //当不是Get请求的时候
			rURL = "";
		} else {
			Enumeration paramsEnum = request.getParameterNames();
			StringBuffer sb = new StringBuffer();
			while (paramsEnum.hasMoreElements()) {
				String paramName = (String) paramsEnum.nextElement();
				String[] values = request.getParameterValues(paramName);
				for (int i = 0; i < values.length; i++) {
					sb.append("&" + paramName + "=" + values[i]);
				}
			}
			 /* if(paramsEnum != null paramsEnum.){
            	  
              }*/
			if (sb.length() > 0) {
				String params = "?" + sb.toString().substring(1);
				rURL += params;
			}
		}
		String redirectURL = constructedSsoLoginUrl(ssoServerURL, rURL);
		response.sendRedirect(redirectURL);
		return false;
	}

	private String constructedSsoLoginUrl(String sURL, String returnUrl) {
		sURL = sURL + "login?&returnURL=" + returnUrl;
		LogClerk.sysout.debug("sURL for logout is " + sURL);
		return sURL;
	}

	private String getBasepath(HttpServletRequest request) {
		String forReturn = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
		return forReturn;
	}

}