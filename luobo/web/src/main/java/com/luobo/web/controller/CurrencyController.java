package com.luobo.web.controller;

import com.luobo.common.entity.Currency;
import com.luobo.web.spring.AbstractController;
import com.pandawork.core.exception.SSException;
import com.pandawork.core.log.LogClerk;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author:liaom
 * @Time: 2015/5/29 14:53.
 */
@Controller
@RequestMapping(value = "currency")
public class CurrencyController extends AbstractController {
    /**
     *到增加页面
     * @return
     */
    @RequestMapping(value = "new",method = RequestMethod.GET)
    public String toNewCurrency(){
        return "";
    }
    /**
     *到增加页面
     * @return
     */
    @RequestMapping(value = "new",method = RequestMethod.POST)
    public String newCurrency(){
        return "";
    }
    /**
     * 到列表页面
     * @param model
     * @return
     */
    @RequestMapping(value = "list")
    public String toList(Model model){
        List<Currency> currencyList = new ArrayList<Currency>();
        try {
            currencyList = currencyService.listCurrency();
        }catch (SSException e){
            LogClerk.errLog.error(e);
            model.addAttribute("errMsg",e.getMessage());
            return ADMIN_NOT_FOUND_PAGE;
        }
        return "";
    }
    /**
     *到增加页面
     * @return
     */
    @RequestMapping(value = "update/{id}",method = RequestMethod.GET)
    public String toUpdateCurrency(@PathVariable("id") int id,Model model){
        Currency currency = new Currency();
        try {
            currency = currencyService.queryCurrencyById(id);
        }catch (SSException e){
            LogClerk.errLog.error(e);
            model.addAttribute("errMsg",e.getMessage());
            return ADMIN_NOT_FOUND_PAGE;
        }
        return "";
    }

    /**
     *修改
     * @return
     */
    @RequestMapping(value = "update",method = RequestMethod.PUT)
    public String updateCurrency(Currency currency,Model model){
        try {
            currencyService.updateCurrency(currency);
        }catch (SSException e){
            LogClerk.errLog.error(e);
            model.addAttribute("currency",currency);
            return ADMIN_NOT_FOUND_PAGE;
        }
        return "";
    }
}
