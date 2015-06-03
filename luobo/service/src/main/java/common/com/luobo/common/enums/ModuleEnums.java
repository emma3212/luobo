package com.luobo.common.enums;

/**
 * 模块枚举
 * Created by Lionel on 2014/6/5.
 */
public enum ModuleEnums {
    Null(""), // 空模块



    //************************************ ADMIN START ************************************//
    Admin("Admin"),
    AdminHome("Admin:Home"),
    //后台会员
    AdminRate("Admin:Rate"),
    AdminRateList("Admin:Rate:List"),
    AdminRateAdd("Admin:Rate:Add"),
    AdminCurrency("Admin:Currency"),

    ;

    ModuleEnums(String name) {
        this.name = name;
    }

    private String name;

    public String getName() {
        return name;
    }
}
