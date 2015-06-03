package com.luobo.web.controller;

import com.luobo.common.annotation.IgnoreAuthorization;
import com.luobo.common.annotation.IgnoreLogin;
import com.luobo.web.spring.AbstractController;
import com.pandawork.core.exception.SSException;
import com.pandawork.core.log.LogClerk;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @Author:liaom
 * @Time: 2015/6/2 16:29.
 */
@Controller
@IgnoreLogin
@IgnoreAuthorization
@RequestMapping(value = "")
public class LoginController extends AbstractController {

   /* @RequestMapping(value = "",method = RequestMethod.POST)
    public String login(String name, String pwd,Model model){
        boolean flag=false;
        try {
            loginService.validLogin(name,pwd);
        }catch (SSException e){
            LogClerk.errLog.error(e);
            sendErrMsgAndErrCode(e);
            return "redirect:index";
        }
        return "redirect:admin/index";
    }*/
   @RequestMapping(value = "login",method = RequestMethod.GET)
   public String toLogin(){
        return "other/login";
    }
    @RequestMapping(value = "login",method = RequestMethod.POST)
    public String validlogin(String name, String pwd){
        try {
            // 验证过程
            Subject subject = userService.validLogin(name, pwd);
            // 生成t票表示
            loginManageService.generatTGT(subject.getSession().getId().toString(), getRequest(), getResponse());
        } catch (SSException e) {
            LogClerk.errLog.error(e);
            sendErrMsgAndErrCode(e);
        }
        return "redirect:admin/index";
    }
    /**
     * 注销登录
     *
     * @return
     */
    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public String logout() {
        try {
            loginManageService.logOut(getRequest());
        } catch (SSException e) {
            LogClerk.errLog.error(e);
        }
        return "redirect:/login";
    }
}
