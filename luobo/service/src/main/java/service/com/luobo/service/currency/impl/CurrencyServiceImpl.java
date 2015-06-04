package com.luobo.service.currency.impl;

import com.ebiz.base.util.Assert;
import com.luobo.common.entity.currency.Currency;
import com.luobo.common.exception.LuoboException;
import com.luobo.mapper.currency.CurrencyMapper;
import com.luobo.service.currency.CurrencyService;
import com.pandawork.core.dao.CommonDao;
import com.pandawork.core.exception.SSException;
import com.pandawork.core.log.LogClerk;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

/**
 * @Author:liaom
 * @Time: 2015/5/29 10:48.
 */
@Service("currencyService")
public class CurrencyServiceImpl implements CurrencyService {

    @Autowired
    @Qualifier("commonDao")
    private CommonDao commonDao;

    @Autowired
    private CurrencyMapper currencyMapper;

    @Override
    public Currency newCurrency(Currency currency) throws SSException {
        if (Assert.isNull(currency)||Assert.isNull(currency.getName())) {
            return null;
        }
        if(this.queryNameIsExist(currency.getName())){
            throw SSException.get(LuoboException.CurrencyIsExist);
        }
        try {
           currency = commonDao.insert(currency);
        } catch (Exception e) {
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.NewCurrencyFailed);
        }
        return currency;
    }

    @Override
    public void updateCurrency(Currency currency) throws SSException {
        if (Assert.isNull(currency) || Assert.isNull(currency.getId())) {
            return;
        }
        if(this.queryNameIsExist(currency.getName())){
            throw SSException.get(LuoboException.CurrencyIsExist);
        }
        try {
            commonDao.update(currency);
        } catch (Exception e) {
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.UpdateCurrencyFailed);
        }
    }

    @Override
    public List<Currency> listCurrency() throws SSException {
        List<Currency> currencyList = Collections.<Currency>emptyList();
        try {
            currencyList = currencyMapper.listCurrency();
        } catch (Exception e) {
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.ListCurrencyFailed);
        }
        return currencyList;
    }

    @Override
    public Currency queryCurrencyById(int id) throws SSException {
        if (Assert.lessOrEqualZero(id)) {
            return null;
        }
        Currency currency = null;
        try {
            currency = currencyMapper.queryCurrencyById(id);
        } catch (Exception e) {
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.QueryCurrencyFailed);
        }
        return currency;
    }

    @Override
    public void delCurrencyById(int id) throws SSException {
        if(Assert.lessOrEqualZero(id)){
            return;
        }
        try{
            commonDao.deleteById(Currency.class,id);
        }catch (Exception e){
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.NewCurrencyFailed);
        }
    }

    @Override
    public Currency queryCurrencyByName(String name) throws SSException {
        if (Assert.isNull(name)) {
            return null;
        }
        Currency currency = null;
        try {
            currency = currencyMapper.queryCurrencyByName(name);
        } catch (Exception e) {
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.QueryCurrencyFailed);
        }
        return currency;
    }

    @Override
    public boolean queryNameIsExist(String name) throws SSException {
        if(Assert.isNull(name)){
            return false;
        }
        Currency currency = this.queryCurrencyByName(name);
        if(Assert.isNull(currency)){
            return false;
        }else {
            return true;
        }
    }
}
