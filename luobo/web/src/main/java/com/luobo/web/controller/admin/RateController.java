package com.luobo.web.controller.admin;

import com.luobo.common.annotation.Module;
import com.luobo.common.entity.currency.Currency;
import com.luobo.common.entity.rate.Rate;
import com.luobo.common.enums.ModuleEnums;
import com.luobo.common.utils.DateUtils;
import com.luobo.web.spring.AbstractController;
import com.pandawork.core.exception.SSException;
import com.pandawork.core.log.LogClerk;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * 汇率controller
 *
 * @Author:liaom
 * @Time: 2015/1/20 10:51.
 */
@Controller
@Module(value = ModuleEnums.AdminRate)
@RequestMapping(value = "admin/rate")
public class RateController extends AbstractController {

    /**
     * 到汇率列表页面
     *
     * @return
     */
    @Module(value = ModuleEnums.AdminRateList)
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String toListProduct(Model model) {
        List<Currency> currencyList = new ArrayList<Currency>();
        Rate rate = new Rate();
        try {
            currencyList = currencyService.listCurrency();
        } catch (SSException e) {
            LogClerk.errLog.error(e);
            return ADMIN_SYS_ERR_PAGE;
        }

        model.addAttribute("currencyList", currencyList);
        return "admin/rate/rate_search_home";
    }

    @RequestMapping(value = "ajax/list/{curPage}", method = RequestMethod.GET)
    public
    @ResponseBody
    JSONObject ajaxListProduct(@PathVariable("curPage") int curPage,
                               @RequestParam(value = "fromCurrencyId", required = false) Integer fromCurrencyId,
                               @RequestParam(value = "toCurrencyId", required = false) Integer toCurrencyId,
                               @RequestParam(value = "date", required = false) Date date) {
        List<Rate> rateList = Collections.emptyList();
        int count = 0;
        try {
            count = rateService.countRate(fromCurrencyId,toCurrencyId,date);
            rateList = rateService.listRate(fromCurrencyId,toCurrencyId,date,curPage, DEFAULT_PAGE_SIZE);
        } catch (SSException e) {
            LogClerk.errLog.error(e);
            return sendErrMsgAndErrCode(e);
        }

        JSONArray array = new JSONArray();

        for (Rate rate : rateList) {
            JSONObject object = new JSONObject();

            object.put("id", rate.getId());
            object.put("fromCurrency", rate.getFromCurrency());
            object.put("toCurrency", rate.getToCurrency());
            object.put("date", DateUtils.formatDate(rate.getDate()));
            object.put("rate", rate.getRate());
            object.put("editUrl", getWebsite() + "admin/rate/update/" + rate.getId());

            array.add(object);
        }

        return sendJsonArray(array, count);
    }

    /**
     * 去添加汇率页面
     *
     * @param model
     * @return
     */
    @Module(value = ModuleEnums.AdminRateAdd)
    @RequestMapping(value = "new", method = RequestMethod.GET)
    public String toNewRate(Model model) {
        List<Currency> currencyList = new ArrayList<Currency>();
        Rate rate = new Rate();
        try {
            currencyList = currencyService.listCurrency();
        } catch (SSException e) {
            LogClerk.errLog.error(e);
            return ADMIN_SYS_ERR_PAGE;
        }

        model.addAttribute("currencyList", currencyList);
        model.addAttribute("rate", null);


        return "admin/rate/rate_new_home";
    }

    /**
     * 保存汇率
     *
     * @param
     * @param model
     * @return
     */
    @RequestMapping(value = "new", method = RequestMethod.POST)
    @Module(value = ModuleEnums.AdminRateAdd)
    public String NewProduct(Rate rate,Model model) {
        List<Currency> currencyList = new ArrayList<Currency>();
        try {
            rateService.newRate(rate);
        } catch (SSException e) {
            LogClerk.errLog.error(e);
            sendErrMsg(e.getMessage());

            String url = this.toNewRate(model);
            //子分类列表获取
            try {
                currencyList = currencyService.listCurrency();
            } catch (SSException e1) {
                LogClerk.errLog.error(e);
            }
            model.addAttribute("errorMsg", e.getMessage());
            model.addAttribute("currencyList", currencyList);
            model.addAttribute("rate", rate);

            return url;
        }
        model.addAttribute("errorMsg", "保存成功,点击确定按钮可继续添加!");
        return toNewRate(model);
    }

    /**
     * 去更新汇率页面
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "update/{id}", method = RequestMethod.GET)
    public String toUpdateProduct(@PathVariable("id") int id, Model model) {
        Rate rate = new Rate();
        List<Currency> currencyList = new ArrayList<Currency>();



        try {
            currencyList = currencyService.listCurrency();
            rate = rateService.queryRateById(id);
        } catch (SSException e) {
            LogClerk.errLog.error(e);
            sendErrMsg(e.getMessage());
            return ADMIN_SYS_ERR_PAGE;
        }

        model.addAttribute("currencyList", currencyList);
        model.addAttribute("rate", rate);
        return "admin/rate/rate_update_home";
    }

    /**
     * 修改汇率
     *
     * @param
     * @param model
     * @return
     */
    @RequestMapping(value = "update", method = RequestMethod.PUT)
    public String updateProduct(Rate rate,
                                Model model) {
        List<Currency> currencyList = new ArrayList<Currency>();
        try {
            rateService.updateRate(rate);
        } catch (SSException e) {
            LogClerk.errLog.error(e);
            String url = toUpdateProduct(rate.getId(), model);
            //子分类列表获取
            try {
                currencyList = currencyService.listCurrency();
            } catch (SSException e1) {
                sendErrMsg(e.getMessage());
                LogClerk.errLog.error(e);
            }
            model.addAttribute("currencyList", currencyList);
            model.addAttribute("rate", rate);
            model.addAttribute("errorMsg", e.getMessage());

            return url;
        }
        return "redirect:list";
    }

    /**
     * 导出excel列表
     *
     */
    @RequestMapping(value = "/export/excel", method = RequestMethod.GET)
    public void exportRateToExcel(@RequestParam(value = "fromCurrencyId", required = false) Integer fromCurrencyId,
                               @RequestParam(value = "toCurrencyId", required = false)  Integer toCurrencyId,
                               @RequestParam(value = "date", required = false) Date date) {
        try {
            rateService.exportRateToExcel(fromCurrencyId,toCurrencyId,date, getResponse());
        } catch (SSException e) {
            LogClerk.errLog.error(e);
            sendErrMsg(e.getMessage());
        }
    }

}
