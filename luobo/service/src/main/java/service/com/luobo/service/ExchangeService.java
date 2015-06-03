package com.luobo.service;

import com.pandawork.core.exception.SSException;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 货币兑换service
 * @Author:liaom
 * @Time: 2015/5/29 14:33.
 */
public interface ExchangeService {
    /**
     * 选择币种，输入日期和金额 得到兑换结果
     * @param fromCurrencyId
     * @param toCurrencyId
     * @param date
     * @param money
     * @return
     * @throws SSException
     */
    public BigDecimal getResult(Integer fromCurrencyId,Integer toCurrencyId,
                                Date date, BigDecimal money) throws SSException;
}
