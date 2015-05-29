package com.luobo.mapper;

import com.luobo.common.entity.Currency;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 币种mapper
 * @Author:liaom
 * @Time: 2015/5/29 10:55.
 */
public interface CurrencyMapper {


    /**
     * 根据id获取币种
     * @param id
     * @return
     */
    public Currency queryCurrencyById(@Param("id") int id) throws Exception;

    /**
     * 获取币种list
     * @return
     */
    public List<Currency> listCurrency() throws Exception;
    /**
     * 根据name获取币种
     * @param name
     * @return
     */
    public Currency queryCurrencyByName(String name) throws Exception;
}