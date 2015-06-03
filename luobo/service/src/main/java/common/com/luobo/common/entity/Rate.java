package com.luobo.common.entity;

import com.pandawork.core.entity.AbstractEntity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 汇率表
 * @Author:liaom
 * @Time: 2015/5/29 13:42.
 */
@Entity
@Table(name = "t_rate")
public class Rate extends AbstractEntity{
    //id
    @Id
    private Integer id;

    //原始货币
    @Column(name = "from_currency_id")
    private Integer fromCurrencyId;

    //原始货币名称
    @Transient
    private transient String fromCurrency;

    //目标货币
    @Column(name = "to_currency_id")
    private Integer toCurrencyId;

    //目标货币名称
    @Transient
    private transient String toCurrency;
    //汇率
    private BigDecimal rate;

    //日期
    private Date date;
    //日期
    @Transient
    private transient String  dateString;

    //创建时间
    @Column(name = "created_time")
    private Date createdTime;

    //最近修改时间
    @Column(name = "last_modified_time")
    private Date lastModifiedTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFromCurrencyId() {
        return fromCurrencyId;
    }

    public void setFromCurrencyId(Integer fromCurrencyId) {
        this.fromCurrencyId = fromCurrencyId;
    }

    public Integer getToCurrencyId() {
        return toCurrencyId;
    }

    public void setToCurrencyId(Integer toCurrencyId) {
        this.toCurrencyId = toCurrencyId;
    }

    public BigDecimal getRate() {
        return rate;
    }

    public void setRate(BigDecimal rate) {
        this.rate = rate;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public Date getLastModifiedTime() {
        return lastModifiedTime;
    }

    public void setLastModifiedTime(Date lastModifiedTime) {
        this.lastModifiedTime = lastModifiedTime;
    }

    public String getFromCurrency() {
        return fromCurrency;
    }

    public void setFromCurrency(String fromCurrency) {
        this.fromCurrency = fromCurrency;
    }

    public String getToCurrency() {
        return toCurrency;
    }

    public void setToCurrency(String toCurrency) {
        this.toCurrency = toCurrency;
    }

    public String getDateString() {
        return dateString;
    }

    public void setDateString(String dateString) {
        this.dateString = dateString;
    }
}
