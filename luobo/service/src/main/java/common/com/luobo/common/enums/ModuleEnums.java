package com.luobo.common.enums;

/**
 * 模块枚举
 * Created by Lionel on 2014/6/5.
 */
public enum ModuleEnums {
    Null(""), // 空模块

    //公共页
    PublicIndex("Public:Index"),
    PublicProduct("Public:Product"),
    PublicProductList("Public:Product:List"),

    Home("Home"),

    //************************************ ADMIN START ************************************//
    Admin("Admin"),
    //后台会员
    AdminMember("Admin:Member"),
    AdminMemberList("Admin:Member:List"),
    AdminMemberUpdate("Admin:Member:Update"),
    //后台站点商品
    AdminSiteProduct("Admin:Site:Product"),
    AdminMemberInfo("Admin:Member:Info"),
    //后台会员类型
    AdminMemberType("Admin:Member:Type"),
    //后台会员可用额度
    AdminMemberAmount("Admin:Member:Amount"),
    //后台内容管理
    AdminContent("Admin:Content"),
    //后台管理员管理
    AdminAdministrator("Admin:Administrator"),
    //管理员档案编辑管理
    AdminUserProfile("Admin:User:Profile"),
    //产品分类管理
    AdminProductCategory("Admin:Product:Category"),
    //产品管理
    AdminProduct("Admin:Product"),
    //产品管理
    AdminProductList("Admin:Product:List"),
    //产品管理
    AdminProductNew("Admin:Product:New"),
    AdminProductEdit("Admin:Product:Edit"),
    //产品品牌管理
    AdminProductBrand("Admin:Product:Brand"),
    //白条订单管理
    AdminWhiteBarOrder("Admin:WhiteBar:Order"),
    //白条订单列表
    AdminWhiteBarOrderList("Admin:WhiteBar:Order:List"),
    //白条订单取消订单列表
    AdminWhiteBarOrderCancelList("Admin:WhiteBar:Order:CancelList"),
    //逾期白条订单
    AdminWhiteBarOverdueOrder("Admin:White:Bar:Overdue:Order"),
    //白条订单详情
    AdminWhiteBarOrderView("Admin:WhiteBar:Order:View"),
    //系统敏感密码管理
    AdminSystemSensitive("Admin:System:Sensitive"),
    //系统月利率管理
    AdminSystemRate("Admin:System:Rate"),
    //第翼短信平台登录名密码管理
    AdminEEMsg("Admin:System:EEMsg"),
    //区域管理
    AdminRegion("Admin:Region"),
    //学校管理
    AdminSchool("Admin:School"),
    // 商品订单
    AdminProductOrder("Admin:Product:Order"),
    AdminProductCanceledOrder("Admin:Product:Canceled:Order"),
    AdminProductOrderView("Admin:Product:Order:View"),
    //逾期商品订单
    AdminProductOverdueOrder("Admin:Product:Overdue:Order"),
    // 随意还订单
    AdminAnyRepayOrder("Admin:Any:Repay:Order"),
    AdminAnyRepayCanceledOrder("Admin:Any:Repay:Canceled:Order"),
    //************************************ ADMIN END ************************************//

    //************************************ User START ************************************//
    Vip("Vip"),
    VipMember("Vip:Member"),
    VipProductOrder("Vip:Product:Order"),
    VipUserProfile("Vip:User:Profile"),
    //会员中心白条订单管理
    VipWhiteBarOrder("Vip:WhiteBar:Order"),
    //会员中心白条订单列表
    VipWhiteBarOrderList("Vip:WhiteBar:Order:List"),
    //会员中心白条订单详情
    VipWhiteBarOrderView("Vip:WhiteBar:Order:View"),

    VipAnyRepay("Vip:Any:Repay"),
    //************************************ User END ************************************//
    //************************************ Common START ************************************//
    //************************************ Common END ************************************//


    ;

    ModuleEnums(String name) {
        this.name = name;
    }

    private String name;

    public String getName() {
        return name;
    }
}
