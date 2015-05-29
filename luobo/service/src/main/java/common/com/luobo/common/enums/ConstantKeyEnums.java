package com.luobo.common.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * 常量枚举类
 *
 * @Author: yux
 * @Time: 2015/1/20 20:17
 */
public enum ConstantKeyEnums {
    SensitiveCodeKey("SENSITIVE_CODE"),//敏感密码
    MonthlyInterestRate("MONTHLY_INTEREST_RATE"),//月利率
    DayInterestRate("DAY_INTEREST_RATE"),//日利率
    WeChatMenuRegMsg("WECHAT_MENU_REG_MSG"), // 微信注册回复消息
    WeChatMenuRegedMsg("WECHAT_MENU_REGED_MSG"), // 微信已注册回复消息
    WeChatMenuBindMsg("WECHAT_MENU_BIND_MSG"), // 微信绑定回复消息
    WeChatMenuBindedMsg("WECHAT_MENU_BINDED_MSG"), // 微信已绑定回复消息
    WeChatMenuUnBindMsg("WECHAT_MENU_UNBIND_MSG"), // 微信未绑定回复消息
    WeChatMenuViewProductOrderMsg("WECHAT_MENU_VIEW_PRODUCT_ORDER_MSG"), // 查看产品订单回复消息
    WeChatMenuViewWhiteBarOrderMsg("WECHAT_MENU_VIEW_WHITE_BAR_ORDER_MSG"), // 查看白条订单回复消息
    WeChatMenuViewAnyRepayOrderMsg("WECHAT_MENU_VIEW_ANY_REPAY_ORDER_MSG"), // 查看随意还订单回复消息
    EELoginName("EE_LOGIN_NAME"),  //第翼短信平台登录名
    EELoginPwd("EE_LOGIN_PWD"),    //第翼短息平台登录密码
    ;//全站统计代码

    ConstantKeyEnums(String key) {
        this.key = key;
    }

    private String key;

    public String getKey() {
        return key;
    }




    private static Map<String, ConstantKeyEnums> keyMap = new HashMap<String, ConstantKeyEnums>();

    static {
        for (ConstantKeyEnums enums : ConstantKeyEnums.values()) {
            keyMap.put(enums.getKey(), enums);
        }
    }
    public static Map<String, ConstantKeyEnums> getKeyMap() {
        return keyMap;
    }

    public static ConstantKeyEnums valueOfByKey(String key){
        return keyMap.get(key);
    }
}
