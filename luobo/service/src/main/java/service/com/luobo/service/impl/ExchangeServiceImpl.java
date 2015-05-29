package com.luobo.service.impl;

import com.ebiz.base.util.Assert;
import com.luobo.common.entity.Rate;
import com.luobo.common.exception.LuoboException;
import com.luobo.service.ExchangeService;
import com.luobo.service.RateService;
import com.pandawork.core.exception.SSException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 货币兑换service
 * @Author:liaom
 * @Time: 2015/5/29 14:33.
 */
public class ExchangeServiceImpl implements ExchangeService {

    @Autowired
    @Qualifier("rateService")
    private RateService rateService;

    public BigDecimal getResult(int fromCurrencyId, int toCurrencyId,
                                Date date, BigDecimal money) throws SSException{
        if(Assert.lessOrEqualZero(fromCurrencyId) ||
                Assert.lessOrEqualZero(toCurrencyId)){
            return null;
        }
        Rate rate = new Rate();
        BigDecimal r = new BigDecimal(1);
        rate = rateService.queryRateBySearch(fromCurrencyId,toCurrencyId,date);
        if(Assert.isNull(rate) && fromCurrencyId!=toCurrencyId){
            throw SSException.get(LuoboException.RateNotExist);
        }
        return r.multiply(money);
    }
}