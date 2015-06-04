package com.luobo.web.controller.admin;

import com.luobo.common.annotation.Module;
import com.luobo.common.entity.currency.Currency;
import com.luobo.common.enums.ModuleEnums;
import com.luobo.web.spring.AbstractController;
import com.pandawork.core.exception.SSException;
import com.pandawork.core.log.LogClerk;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * 币种controller
 * @Author:liaom
 * @Time: 2015/5/29 14:53.
 */
@Controller
@Module(value = ModuleEnums.AdminCurrency)
@RequestMapping(value = "admin/currency")
public class CurrencyController extends AbstractController {
    /**
     * 到列表页面
     * @param model
     * @return
     */
    @Module(value = ModuleEnums.AdminCurrency)
    @RequestMapping(value = {"list",""},method = RequestMethod.GET)
    public String toList(Model model){
        List<Currency> currencyList = new ArrayList<Currency>();
        try {
            currencyList = currencyService.listCurrency();
        }catch (SSException e){
            LogClerk.errLog.error(e);
            model.addAttribute("errMsg",e.getMessage());
            return ADMIN_NOT_FOUND_PAGE;
        }
        model.addAttribute("list",currencyList);
        return "admin/currency/currency_home";
    }

    /**
     *修改
     * @return
     */
    @RequestMapping(value = "ajax/update/{id}",method = RequestMethod.PUT)
    public
    @ResponseBody
    JSONObject  updateCurrency(Currency currency,Model model){
        try {
            currencyService.updateCurrency(currency);
        }catch (SSException e){
            LogClerk.errLog.error(e);
            model.addAttribute("currency",currency);
            sendErrMsgAndErrCode(e);
        }
        return sendJsonObject(AJAX_SUCCESS_CODE);
    }

    /**
     * 新增币种
     *
     * @param currency
     * @return
     * @throws com.pandawork.core.exception.SSException
     */
    @RequestMapping(value = "ajax/new", method = RequestMethod.POST)
    public
    @ResponseBody
    JSONObject ajaxNewMemberType(Currency currency) {
        try {
            Currency member = currencyService.newCurrency(currency);
            JSONObject j = new JSONObject();
            j.put("id", member.getId());
            return sendJsonObject(j, AJAX_SUCCESS_CODE);
        } catch (SSException e) {
            LogClerk.errLog.error(e);
            return sendErrMsgAndErrCode(e);
        }
    }

    /**
     *删除
     * @return
     */
    @RequestMapping(value = "ajax/del/{id}",method = RequestMethod.PUT)
    public
    @ResponseBody
    JSONObject  delCurrency(@PathVariable("id") int id){
        try {
            currencyService.delCurrencyById(id);
        }catch (SSException e){
            LogClerk.errLog.error(e);
            sendErrMsgAndErrCode(e);
        }
        return sendJsonObject(AJAX_SUCCESS_CODE);
    }
}
