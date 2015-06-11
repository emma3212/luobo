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
        if(fromCurrencyId==toCurrencyId){
            return money;
        }else{
            Rate rate = new Rate();
            BigDecimal r = new BigDecimal(1);
            rate = rateService.queryRateBySearch(fromCurrencyId,toCurrencyId,date);
            if(rate!=null)
            return rate.getRate().multiply(money);
            else {
                Rate rate1 = new Rate();
                rate1 = rateService.queryRateBySearch(fromCurrencyId,1,date);
                Rate rate2 = new Rate();
                rate2 = rateService.queryRateBySearch(toCurrencyId,1,date);
                if(rate1==null || rate2==null){
                    throw SSException.get(LuoboException.RateNotExist);
                }
                return rate1.getRate().subtract(rate2.getRate()).multiply(money);
            }
        }

    }
}
