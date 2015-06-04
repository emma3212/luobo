package com.luo.pandawork.rate;

import com.luo.pandawork.AbstractTestCase;
import com.luobo.common.entity.rate.Rate;
import com.luobo.service.rate.RateService;
import com.pandawork.core.exception.SSException;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author:liaom
 * @Time: 2015/5/29 11:04.
 */
public class RateTest extends AbstractTestCase {
    @Autowired
    private RateService rateService;
    @Test
    public void add(){
        Rate rate = new Rate();
        rate.setFromCurrencyId(1);
        rate.setToCurrencyId(1);
        rate.setDate(new Date());
        rate.setRate(new BigDecimal(1));
        try {
            rateService.newRate(rate);
        } catch (SSException e) {
            e.printStackTrace();
        }
    }
    @Test
    public void update(){
        Rate rate = new Rate();

        try {
           rate = rateService.queryRateById(1);
            rate.setDate(new Date());
            rateService.updateRate(rate);
        } catch (SSException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void list(){
        List<Rate> currencyList = new ArrayList<Rate>();

      /*  try {
            currencyList = rateService.listRate();
            System.out.println(currencyList);
        } catch (SSException e) {
            e.printStackTrace();
        }*/
    }
}
