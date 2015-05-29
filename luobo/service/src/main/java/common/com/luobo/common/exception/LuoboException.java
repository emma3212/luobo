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
