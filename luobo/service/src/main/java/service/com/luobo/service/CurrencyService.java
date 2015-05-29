package com.luobo.service;

import com.luobo.common.entity.Currency;
import com.pandawork.core.exception.SSException;

import java.util.List;

/**
 * 货币service
 * @Author:liaom
 * @Time: 2015/5/29 10:44.
 */
public interface CurrencyService {
    /**
     * 添加一种货币
     * @param currency
     * @throws SSException
     */
    public void newCurrency(Currency currency) throws SSException;

    /**
     * 修改币种
     * @param currency
     * @throws SSException
     */
    public void updateCurrency(Currency currency) throws SSException;

    /**
     * 获取货币列表
     * @return
     * @throws SSException
     */
    public List<Currency> listCurrency() throws SSException;

    /**
     * 根据id获取货币
     * @param id
     * @return
     * @throws SSException
     */
    public Currency queryCurrencyById(int id) throws SSException;

    /**
     * 根据币种名称获取货币
     * @param name
     * @return
     * @throws SSException
     */
    public Currency queryCurrencyByName(String name) throws SSException;


    /**
     * 查询货币是否存在
     * @param name
     * @return
     * @throws SSException
     */
    public boolean queryNameIsExist(String name) throws SSException;
}
