package com.luobo.service;

import com.luobo.common.entity.Rate;
import com.pandawork.core.exception.SSException;

import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 * 汇率service
 * @Author:liaom
 * @Time: 2015/5/29 13:49.
 */
public interface RateService {
    /**
     * 添加汇率
     * @param rate
     * @throws SSException
     */
    public void newRate(Rate rate) throws SSException;

    /**
     * 根据id 查询汇率
     * @param id
     * @throws SSException
     */
    public Rate queryRateById(int id) throws SSException;

    /**
     * 修改汇率
     * @param rate
     * @throws SSException
     */
    public void updateRate(Rate rate) throws SSException;

    /**
     * 根据条件查询汇率
     * @param fromCurrencyId
     * @param toCurrencyId
     * @param date
     * @throws SSException
     */
    public Rate queryRateBySearch(Integer fromCurrencyId,
                                  Integer toCurrencyId,
                                  Date date) throws SSException;

    /**
     * 列表
     * @param fromCurrencyId
     * @param toCurrencyId
     * @param date
     * @param curPage
     * @param pageSize
     * @return
     * @throws SSException
     */
    public List<Rate> listRate(Integer fromCurrencyId,Integer toCurrencyId,Date date,int curPage,int pageSize) throws SSException;

    /**
     * 计算个数
     * @param fromCurrencyId
     * @param toCurrencyId
     * @param date
     * @return
     * @throws SSException
     */
    public int countRate(Integer fromCurrencyId,Integer toCurrencyId,Date date) throws SSException;
    public void exportRateToExcel(Integer fromCurrencyId,Integer toCurrencyId,Date date, HttpServletResponse response) throws SSException;
}
