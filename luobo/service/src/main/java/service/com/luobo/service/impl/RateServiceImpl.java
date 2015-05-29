package com.luobo.service.impl;

import com.ebiz.base.util.Assert;
import com.luobo.common.entity.Rate;
import com.luobo.common.exception.LuoboException;
import com.luobo.mapper.RateMapper;
import com.luobo.service.RateService;
import com.pandawork.core.dao.CommonDao;
import com.pandawork.core.exception.SSException;
import com.pandawork.core.log.LogClerk;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * @Author:liaom
 * @Time: 2015/5/29 13:56.
 */
@Service("rateService")
public class RateServiceImpl implements RateService {
    @Autowired
    @Qualifier("commonDao")
    private CommonDao commonDao;

    @Autowired
    private RateMapper rateMapper;

    @Override
    public void newRate(Rate rate) throws SSException {
        if(Assert.isNull(rate) ||
                Assert.isNull(rate.getFromCurrencyId())||
                Assert.isNull(rate.getToCurrencyId())||
                rate.getRate().compareTo(new BigDecimal(0))<=0){
            return;
        }
        try {
            commonDao.insert(rate);
        }catch (Exception e){
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.NewRateFailed);
        }
    }

    @Override
    public Rate queryRateById(int id) throws SSException {
        if(Assert.lessOrEqualZero(id)){
            return null;
        }
        Rate rate = null;
        try {
            rate = rateMapper.queryRateById(id);
        }catch (Exception e){
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.QueryRateFailed);
        }
        return rate;
    }

    @Override
    public void updateRate(Rate rate) throws SSException {
        if(Assert.isNull(rate) || Assert.isNull(rate.getId()) ||
                Assert.isNull(rate.getFromCurrencyId())||
                Assert.isNull(rate.getToCurrencyId())||
                rate.getRate().compareTo(new BigDecimal(0))<=0){
            return;
        }
        try {
            commonDao.update(rate);
        }catch (Exception e){
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.NewRateFailed);
        }
    }

    @Override
    public Rate queryRateBySearch(Integer fromCurrencyId, Integer toCurrencyId, Date date) throws SSException {
        if(Assert.lessOrEqualZero(fromCurrencyId) ||
                Assert.lessOrEqualZero(toCurrencyId)){
            return null;
        }
        Rate rate = null;
        try {
            rate = rateMapper.queryRateBySearch(fromCurrencyId,toCurrencyId,date);
        }catch (Exception e){
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.QueryRateFailed);
        }
        return rate;
    }

    @Override
    public List<Rate> listRate() throws SSException {
        List<Rate> rateList = Collections.<Rate>emptyList();
        try {
            rateList = rateMapper.listRate();
        } catch (Exception e) {
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.ListRateFailed);
        }
        return rateList;
    }
}
