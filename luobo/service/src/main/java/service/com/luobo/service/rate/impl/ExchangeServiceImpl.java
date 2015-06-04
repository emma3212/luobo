package com.luobo.service.rate.impl;

import com.ebiz.base.util.Assert;
import com.luobo.common.entity.rate.Rate;
import com.luobo.common.exception.LuoboException;
import com.luobo.service.rate.ExchangeService;
import com.luobo.service.rate.RateService;
import com.pandawork.core.exception.SSException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 货币兑换service
 * @Author:liaom
 * @Time: 2015/5/29 14:33.
 */
@Service("exchangeService")
public class ExchangeServiceImpl implements ExchangeService {

    @Autowired
    @Qualifier("rateService")
    private RateService rateService;

    public BigDecimal getResult(Integer fromCurrencyId, Integer toCurrencyId,
                                Date date, BigDecimal money) throws SSException{
        if(Assert.isNull(fromCurrencyId)||Assert.isNull(toCurrencyId)||Assert.lessOrEqualZero(fromCurrencyId) ||
                Assert.lessOrEqualZero(toCurrencyId)){
            return null;
        }
        Rate rate = new Rate();
        BigDecimal r = new BigDecimal(1);
        rate = rateService.queryRateBySearch(fromCurrencyId,toCurrencyId,date);
        if(Assert.isNull(rate) && fromCurrencyId!=toCurrencyId){
            throw SSException.get(LuoboException.RateNotExist);
        }
        return rate.getRate().multiply(money);
    }
}
