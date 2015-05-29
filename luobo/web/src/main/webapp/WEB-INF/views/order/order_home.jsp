<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!doctype html>
<html>
<head>

</head>
<body>
   <form id="J_createSecurityGroup" class="form common-form-blue" action="${website}pay/order/pay"
           method="get" autocomplete="off">
          <div class="control-group">
               <label class="control-label">
                    会员号
                    <span class="required">*</span>
               </label>

               <div class="controls">
                    <input type="text" class="w200" name="partyId" value="2">
               </div>
          </div>

          <div class="control-group">
               <label class="control-label">
                    订单号
                    <span class="required">*</span>
               </label>

               <div class="controls">
                    <input type="text" class="w200" name="orderId">
               </div>
          </div>
           <input type="hidden" class="w200" name="currencyId" value="1">
           <input type="hidden" class="w200" name="accountPayMoney" value="0">

          <div class="control-group">
               <label class="control-label">
                    需要支付
                    <span class="required">*</span>
               </label>

               <div class="controls">
                    <input type="text" class="w200" name="needToPay">
               </div>
          </div>
          <div class="form-footer">
               <button type="submit" id="J_createSecuritySubmit" class="btn btn-blue btn-ok"
                       data-loading-text="正在提交，请稍后" data-btn-type="loading" data-tip-direct="down-up">保存
               </button>
          </div>
     </form>

   <%--<form id="alipaysubmit" name="alipaysubmit" action="https://mapi.alipay.com/gateway.do?_input_charset=utf-8" method="get">
       <input type="hidden" name="seller_email" value="pub@pandawork.net"/>
       <input type="hidden" name="_input_charset" value="utf-8"/>
       <input type="hidden" name="extra_common_param" value="14"/>
       <input type="hidden" name="subject" value="订单14交易"/>
       <input type="hidden" name="sign" value="34f04e216e79502af6ffec515a458ffc"/>
       <input type="hidden" name="body" value="请登录www.wl.cn查看您的订单状态"/>
       <input type="hidden" name="notify_url" value="http://pay.pandawork.net/paycallback/alipay/notify"/>
       <input type="hidden" name="payment_type" value="1"/>
       <input type="hidden" name="out_trade_no" value="1412847"/>
       <input type="hidden" name="partner" value="2088711519959782"/>
       <input type="hidden" name="service" value="create_direct_pay_by_user"/>
       <input type="hidden" name="total_fee" value="0.1"/>
       <input type="hidden" name="return_url" value="http://pay.pandawork.net/paycallback/alipay/return"/>
       <input type="hidden" name="sign_type" value="MD5"/>
       <input type="hidden" name="show_url" value="http://www.wl.cn"/>
       <input type="submit" value="确定" style="display:none;">
   </form>
   <script>document.forms['alipaysubmit'].submit();</script>--%>
  <%-- <form id="alipaysubmit" name="alipaysubmit" action="https://mapi.alipay.com/gateway.do?_input_charset=utf-8" method="get"><input type="hidden" name="seller_email" value="pub@pandawork.net"/><input type="hidden" name="_input_charset" value="utf-8"/><input type="hidden" name="extra_common_param" value="15"/><input type="hidden" name="subject" value="订单15交易"/><input type="hidden" name="sign" value="265529b874445d4ef8cf353f532ab050"/><input type="hidden" name="body" value="请登录www.wl.cn查看您的订单状态"/><input type="hidden" name="notify_url" value="http://pay.pandawork.net/paycallback/alipay/notify"/><input type="hidden" name="payment_type" value="1"/><input type="hidden" name="out_trade_no" value="15523489"/><input type="hidden" name="partner" value="2088711519959782"/><input type="hidden" name="service" value="create_direct_pay_by_user"/><input type="hidden" name="total_fee" value="0.01"/><input type="hidden" name="return_url" value="http://pay.pandawork.net/paycallback/alipay/return"/><input type="hidden" name="sign_type" value="MD5"/><input type="hidden" name="show_url" value="http://www.wl.cn"/><input type="submit" value="确定" style="display:none;"></form><script>document.forms['alipaysubmit'].submit();</script>
--%>
</body>
</html>