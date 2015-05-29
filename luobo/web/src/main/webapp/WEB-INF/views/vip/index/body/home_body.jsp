<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<div class="holder">
    <div class="content">
        <h1>会员中心控制面板</h1>
        <div class="crumb" id="crumb">
            <button class="btn btn-red time">
                <i class="fa fa-calendar"></i>
                <span>${web_date}</span>
            </button>
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a>会员中心</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>控制面板</a>
                </li>
            </ul>
        </div>
        <div class="container">
            <div class="row-fluid">
                <div class="col span32">
                    <div class="dashboard-stat blue">
                        <div class="visual">
                            <i class="fa fa-check-square-o"></i>
                        </div>
                        <div class="details">
                            <div class="number">
                                ${productRepayOrder}单
                            </div>
                            <div class="desc">
                                还款中订单
                            </div>
                        </div>
                        <a class="more" href="${website}vip/product/order">
                            查看商品订单 <i class="m-icon-swapright m-icon-white"></i>
                        </a>
                    </div>
                </div>
                <div class="col span32 offset2">
                    <div class="dashboard-stat purple">
                        <div class="visual">
                            <i class="fa fa-bookmark-o"></i>
                        </div>
                        <div class="details">
                            <div class="number">
                                ${whiteBarRepayOrder}单
                            </div>
                            <div class="desc">
                                还款中订单
                            </div>
                        </div>
                        <a class="more" href="${website}vip/white/bar/order">
                            查看白条订单 <i class="m-icon-swapright m-icon-white"></i>
                        </a>
                    </div>
                </div>
                <div class="col span32 offset2">
                    <div class="dashboard-stat yellow">
                        <div class="visual">
                            <i class="fa fa-bullhorn"></i>
                        </div>
                        <div class="details">
                            <div class="number">
                                ${anyRepayOrder}单
                            </div>
                            <div class="desc">
                                还款中订单
                            </div>
                        </div>
                        <a class="more" href="${website}vip/any/repay/list">
                            查看随意还订单 <i class="m-icon-swapright m-icon-white"></i>
                        </a>
                    </div>
                </div>
                <div class="col span32">
                    <div class="news-feeds">
                        <div class="top-news">
                            <a href="${website}vip/white/bar/order/new" class="new-tips red">
                                <span>申请白条订单</span>
                                <em><i class="fa fa-tags"></i>信用额度${memberAmountDto.whiteBarLine == null ? 0 : memberAmountDto.whiteBarLine}元</em>
                                <em><i class="fa fa-tags"></i>可用额度${memberAmountDto.whiteBar== null ? 0 : memberAmountDto.whiteBar}元</em>
                                <i class="fa fa-briefcase top-news-icon"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col span32 offset2">
                    <div class="news-feeds">
                        <div class="top-news">
                            <a href="${website}vip/any/repay" class="new-tips blue">
                                <span>申请随意还</span>
                                <em><i class="fa fa-tags"></i>信用额度${memberAmountDto.anyRepayLine == null ? 0 : memberAmountDto.anyRepayLine}元</em>
                                <em><i class="fa fa-tags"></i>可用额度${memberAmountDto.anyRepay == null ? 0 : memberAmountDto.anyRepay}元</em>
                                <i class="fa fa-book top-news-icon"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col span32 offset2">
                    <div class="news-feeds">
                        <div class="top-news">
                            <a href="${website}vip/info" class="new-tips green">
                                <span>查看会员身份</span>
                                <c:if test="${memberInfo.status==1}">
                                <em>恭喜您，已成为我们的正式会员！</em>
                                </c:if>
                                <c:if test="${memberInfo.status==2}}">
                                <em>您的信息正在审核中！</em>
                                </c:if>
                                <c:if test="${memberAmountDto.memberTypeId == 0 or memberAmountDto.memberTypeId == null}">
                                 <em>恭喜您，已成为我们的注册会员！</em>
                                </c:if>
                                <i class="fa fa-user top-news-icon"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
