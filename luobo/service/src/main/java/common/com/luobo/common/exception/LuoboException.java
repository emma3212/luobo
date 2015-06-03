package com.luobo.common.exception;

import com.pandawork.core.exception.IBizExceptionMes;

/**
 * 异常枚举
 * <p/>
 * Created by yusheng on 2014/12/18.
 */
public enum LuoboException implements IBizExceptionMes {

    SystemException("系统内部异常", 1),
    //货币
    NewCurrencyFailed("添加货币失败",1001),
    UpdateCurrencyFailed("修改货币失败",1002),
    QueryCurrencyFailed("修改货币失败",1003),
    ListCurrencyFailed("修改货币失败",1004),
    CurrencyIsExist("货币已存在",1005),
    //汇率
    NewRateFailed("添加汇率失败",2001),
    UpdateRateFailed("修改汇率失败",2002),
    QueryRateFailed("查询汇率失败",2003),
    ListRateFailed("获取汇率列表失败",2004),
    RateNotExist("汇率不存在",2005),

    UserNameIsNull("用户名不能为空",3001),
    PwdIsNull("用户名不能为空",3002),
    QueryUserFailed("查询用户失败",3003),
    UserIsNotExist("用户不存在",3004),
    PwdNotRight("密码不正确",3005),

    // 安全中心
    SecurityTGTKeyNotnull("系统内部异常，TGT key不能为空！", 10001),   // 权限名称不能为空
    SecurityTGTValueNotnull("系统内部异常，TGT值不能为空！", 10002),   // 权限名称不能为空

    PwdIsEmpty("密码不能为空", 11001),     // 密码不能为空
    PwdNotEqualConformPwd("密码和确认密码不一致！", 11002), //   用户名和密码为不合法\
    ConformPwdIsEmpty("确认密码不能为空", 11003), //   用户名不能为空
    OldPwdIsEmpty("旧密码不能为空", 11004), //   用户名不能为空
    OldPwdNotCorrect("旧密码不正确", 11005),  // 旧密码不正确
    LoginNameIsEmpty("登录用户不能为空", 11006), //   用户PIN不能为空
    LoginNameIsExist("登录用户已经存在,请重新输入", 11007), //   登录用户名已经存在
    LoginNameIsForbid("用户被禁用或者不是网站管理员", 11008), //   账户被停用或者不是网站管理员
    LoginNameOrPwdIsNotCorrect("用户名或密码不正确！", 11009), //   用户名和密码为不合法

    ;
    private String msg;

    private int code;

    LuoboException(String msg, int code) {
        this.msg = msg;
        this.code = code;
    }

    @Override
    public String getMes() {
        return msg;
    }

    @Override
    public int getCode() {
        return code;
    }
}
