package com.luo.pandawork.currency;

import com.luo.pandawork.AbstractTestCase;
import com.luobo.common.entity.Currency;
import com.luobo.service.CurrencyService;
import com.pandawork.core.exception.SSException;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author:liaom
 * @Time: 2015/5/29 11:04.
 */
public class CurrencyTest extends AbstractTestCase {
    @Autowired
    private CurrencyService currencyService;
    @Test
    public void add(){
        Currency currency = new Currency();
        currency.setName("中国");
        try {
            currencyService.newCurrency(currency);
        } catch (SSException e) {
            e.printStackTrace();
        }
    }
    @Test
    public void update(){
        Currency currency = new Currency();

        try {
           currency = currencyService.queryCurrencyById(1);
            currency.setName("美国");
            currencyService.updateCurrency(currency);
        } catch (SSException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void list(){
        List<Currency> currencyList = new ArrayList<Currency>();

        try {
            currencyList = currencyService.listCurrency();
            System.out.println(currencyList);
        } catch (SSException e) {
            e.printStackTrace();
        }
    }
}
