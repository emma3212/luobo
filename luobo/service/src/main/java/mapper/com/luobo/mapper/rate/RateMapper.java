package com.luobo.mapper.rate;

import com.luobo.common.entity.rate.Rate;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * 汇率mapper
 * @Author:liaom
 * @Time: 2015/5/29 10:55.
 */
public interface RateMapper {

    /**
     * 根据条件查询汇率
     * @param fromCurrencyId
     * @param toCurrencyId
     * @param date
     * @return
     * @throws Exception
     */
   public Rate queryRateBySearch(@Param("fromCurrencyId") Integer fromCurrencyId,
                                 @Param("toCurrencyId") Integer toCurrencyId,
                                 @Param("date")  Date date)throws Exception;

    /**
     * 根据id查询汇率
     * @param id
     * @return
     * @throws Exception
     */
   public Rate queryRateById(int id) throws Exception;

    /**
     * 获取list
     * @return
     * @throws Exception
     */
    public List<Rate> listRate(@Param("fromCurrencyId") Integer fromCurrencyId,
                               @Param("toCurrencyId") Integer toCurrencyId,
                               @Param("date") Date date,
                               @Param("offset") int offset,
                               @Param("pageSize") int pageSize) throws Exception;

    public int countRate(@Param("fromCurrencyId") Integer fromCurrencyId,
                         @Param("toCurrencyId") Integer toCurrencyId,
                         @Param("date") Date date) throws Exception;
}