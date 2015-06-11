package com.luobo.web.controller.pub;

import com.luobo.common.annotation.IgnoreAuthorization;
import com.luobo.common.annotation.IgnoreLogin;
import com.luobo.common.entity.currency.Currency;
import com.luobo.common.entity.rate.Rate;
import com.luobo.common.utils.DateUtils;
import com.luobo.web.spring.AbstractController;
import com.pandawork.core.exception.SSException;
import com.pandawork.core.log.LogClerk;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author:liaom
 * @Time: 2015/6/1 17:42.
 */
@Controller
@IgnoreLogin
@IgnoreAuthorization
@RequestMapping(value = "index")
public class IndexController extends AbstractController {
    @RequestMapping(value = "")
    public String Index(@RequestParam(value = "fromCurrencyId",required = false) Integer fromCurrencyId,
                         @RequestParam(value = "toCurrencyId",required = false) Integer toCurrencyId,
                         @RequestParam(value = "date",required = false) Date date,
                         @RequestParam(value = "money",required = false) BigDecimal money,Model model){
        List<Currency> currencyList = new ArrayList<Currency>();
        BigDecimal result = null;
        Rate rate = new Rate();

        Date date1 = new Date();
        if(date==null){
           date=date1;
        }
        try{
            currencyList = currencyService.listCurrency();
            result =   exchangeService.getResult(fromCurrencyId,toCurrencyId,date,money);
            rate = rateService.queryRateByCondition(fromCurrencyId,toCurrencyId,date);
        }catch (SSException e){
            LogClerk.errLog.error(e);
            model.addAttribute("errMsg",e.getMessage());
            return "other/index";
        }


        model.addAttribute("money",money);
        model.addAttribute("currencyList",currencyList);
        model.addAttribute("result",result);
        model.addAttribute("rate",rate);
        return "other/index";
    }
}
