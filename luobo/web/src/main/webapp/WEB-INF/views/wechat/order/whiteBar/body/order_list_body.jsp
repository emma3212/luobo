<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="page">
    <a href="javascript:;" class="logo"></a>

    <h3 class="lighter-black">
        <i class="fa fa-bell-o"></i>
        <i class="fa fa-bell red-bell"></i>
        查询白条订单
    </h3>

    <div id="wrapper" class="list-holder J_listHolder">
        <div id="scroller">
            <div class="pullDown">
                <span class="pullDownIcon"></span>
                <span class="pullDownLabel">下拉刷新内容...</span>
            </div>
            <ul id="thelist" class="order-list J_listRender">
                <li>
                    <span class="first-col">订单编号</span>
                    <span>金额</span>
                    <span>状态</span>
                </li>
            </ul>
            <div class="pullUp">
                <span class="pullUpIcon"></span>
                <span class="pullUpLabel">上拉获取更多内容...</span>
            </div>
        </div>
    </div>
</div>