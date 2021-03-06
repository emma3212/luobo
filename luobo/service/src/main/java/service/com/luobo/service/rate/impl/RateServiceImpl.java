package com.luobo.service.rate.impl;

import com.ebiz.base.util.Assert;
import com.luobo.common.entity.rate.Rate;
import com.luobo.common.exception.LuoboException;
import com.luobo.common.utils.DateUtils;
import com.luobo.mapper.rate.RateMapper;
import com.luobo.service.rate.RateService;
import com.pandawork.core.dao.CommonDao;
import com.pandawork.core.excel.DataType;
import com.pandawork.core.exception.SSException;
import com.pandawork.core.log.LogClerk;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
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
        if(Assert.isNull(fromCurrencyId) ||
                Assert.isNull(toCurrencyId)|| Assert.lessOrEqualZero(fromCurrencyId) ||
                Assert.lessOrEqualZero(toCurrencyId)){
            return null;
        }
        Rate rate = new Rate();
        try {
            rate = rateMapper.queryRateBySearch(fromCurrencyId,toCurrencyId,date);
        }catch (Exception e){
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.QueryRateFailed);
        }

        return rate;
    }

    @Override
    public Rate queryRateByCondition(Integer fromCurrencyId, Integer toCurrencyId, Date date) throws SSException {
        if(Assert.isNull(fromCurrencyId) ||
                Assert.isNull(toCurrencyId)|| Assert.lessOrEqualZero(fromCurrencyId) ||
                Assert.lessOrEqualZero(toCurrencyId)){
            return null;
        }
        Rate rate = new Rate();
        if(fromCurrencyId==1){
            rate = this.queryRateBySearch(toCurrencyId,fromCurrencyId,date);
            String a = rate.getToCurrency();
            String b = rate.getFromCurrency();
            Integer x = rate.getFromCurrencyId();
            Integer y = rate.getToCurrencyId();
            rate.setFromCurrencyId(y);
            rate.setToCurrencyId(x);
            rate.setToCurrency(b);
            rate.setFromCurrency(a);
            rate.setDateString(DateUtils.formatDate(rate.getDate()));
        }else {
            rate = this.queryRateBySearch(fromCurrencyId, toCurrencyId, date);
            Rate rate1 = new Rate();
            Rate rate2 = new Rate();
            if(rate!=null){
                rate.setDateString(DateUtils.formatDate(rate.getDate()));
            }else{
                try{
                    rate1 = this.queryRateBySearch(fromCurrencyId, 1, date);
                    rate2 = this.queryRateBySearch(toCurrencyId, 1, date);
                }catch (SSException e){
                    LogClerk.errLog.error(e);
                    throw SSException.get(LuoboException.RateNotExist);
                }
                if(rate1!=null && rate2!=null){
                    rate = new Rate();
                    rate.setFromCurrency(rate1.getFromCurrency());
                    rate.setFromCurrencyId(rate1.getFromCurrencyId());
                    rate.setToCurrency(rate2.getFromCurrency());
                    rate.setToCurrencyId(rate2.getFromCurrencyId());
                    rate.setRate(rate1.getRate().divide(rate2.getRate(),4,BigDecimal.ROUND_HALF_UP));
                    rate.setDate(date);
                    rate.setDateString(DateUtils.formatDate(rate1.getDate()));
                }
            }
        }
        return rate;
    }

    @Override
    public List<Rate> listRate(Integer fromCurrencyId,Integer toCurrencyId,Date date,int curPage,int pageSize) throws SSException {
        List<Rate> rateList = Collections.<Rate>emptyList();
        int offset = (curPage-1)*pageSize;
        if(Assert.lessZero(offset)){
            return rateList;
        }
        try {
            rateList = rateMapper.listRate(fromCurrencyId,toCurrencyId,date,offset,pageSize);
        } catch (Exception e) {
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.ListRateFailed);
        }
        return rateList;
    }

    @Override
    public int countRate(Integer fromCurrencyId,Integer toCurrencyId,Date date) throws SSException {
        int count = 0;
        try{
            count = rateMapper.countRate(fromCurrencyId,toCurrencyId,date);
        }catch (Exception e){
            LogClerk.errLog.error(e);
            throw SSException.get(LuoboException.QueryRateFailed);
        }
        return count;
    }

    private DataType[] dataTypes = {
            new DataType("id", 0), new DataType("fromCurrency", 1),
            new DataType("toCurrency", 2), new DataType("rate", 3),
            new DataType("dateString", 4)
    };
    public void exportRateToExcel(Integer fromCurrencyId,Integer toCurrencyId,Date date, HttpServletResponse response) throws SSException{
       /* OutputStream os = null;
        // 实体字段与excel中列的对应信息

        try {

            // 从数据库中获取数据
            List<MemberDTO> memberDTOList = this.listMemberDTO(item, key, status, startTime, endTime);
            for (MemberDTO memberDTO : memberDTOList) {
                memberDTO.setCreatedTime(DateUtils.formatDatetime(memberDTO.getCreatedDateTime()));
                EntityUtil.setNullFieldDefault(memberDTO);
            }

            // 设置输出流
            // 设置excel文件名和sheetName
            String filename = "";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/ddHH:mm");
            if (status == 0) {
                filename = "已激活会员" + sdf.format(new Date());
            } else {
                filename = "停用会员" + sdf.format(new Date());
            }
            String contentType = "application/octet-stream";
            response.setContentType(contentType);
            response.setHeader("Content-disposition",
                    "attachment; filename=" + new String(filename.getBytes("gbk"), "ISO8859-1") + ".xls");
            os = response.getOutputStream();

            if (status == 0) {
                excelExportService.exportToExcel(ExcelExportTemplateEnums.ActiveMember, memberDTOList, os,
                        dataTypes);
            } else {
                excelExportService.exportToExcel(ExcelExportTemplateEnums.SuspendMember, memberDTOList, os,
                        dataTypes);
            }

        } catch (Exception e) {
            LogClerk.errLog.error(e);
            response.setContentType("text/html");
            response.setHeader("Content-Type", "text/html");
            response.setHeader("Content-disposition", "");
            response.setCharacterEncoding("UTF-8");
            try {
                response.getOutputStream().write(new String("系统内部异常，请联系管理员！" + e.getMessage()).getBytes());
                os.close();
            } catch (IOException e1) {
                LogClerk.errLog.error(e1);
            }
            throw SSException.get(BomanException.SystemException, e);

        } finally {
            if (os != null) {
                try {
                    os.close();
                } catch (Exception e) {
                    LogClerk.errLog.error(e);
                    throw SSException.get(BomanException.SystemException, e);
                }
            }*/
    }

}
