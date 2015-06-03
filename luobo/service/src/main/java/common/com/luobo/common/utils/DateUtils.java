package com.luobo.common.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

/**
 * 日期时间工具类
 * 时间格式：年-月-日 时:分
 *
 * @author: yusheng
 * @time: 2014-10-13 16:36
 */
public class DateUtils {

    private static final SimpleDateFormat DEFAULT_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    private static final SimpleDateFormat SIMPLE_DATE_FORMAT = new SimpleDateFormat("yyyy年MM月dd日");
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    /**
     * 获得当前时间
     *
     * @return
     */
    public static Date now() {
        return new Date();
    }

    public static Calendar calendar() {
        Calendar cal = GregorianCalendar.getInstance(Locale.CHINESE);
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        return cal;
    }

    /**
     * 格式化日期时间
     * 日期时间格式yyy-MM-dd HH:mm
     *
     * @return
     */
    public static String formatDatetime(Date date) {
        return DEFAULT_FORMAT.format(date);
    }
    /**
     * 格式化日期时间
     * 日期时间格式yyy-MM-dd HH:mm
     *
     * @return
     */
    public static String formatDate(Date date) {
        return DATE_FORMAT.format(date);
    }

    /**
     * 获取当前日期
     * 日期时间格式yyyy.MM.dd
     *
     * @return
     */
    public static String simpleDateFormat() {
        return SIMPLE_DATE_FORMAT.format(new Date());
    }

    /**
     * 计算时间差
     *
     * @param beginTime
     * @param endTime
     * @return
     */
    public static String calculateDiffTime(Date beginTime, Date endTime) {
        long between = 0;
        long hour = 0;
        long min = 0;
        try {
            between = (endTime.getTime() - beginTime.getTime());// 得到两者的毫秒数
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        hour = (between / (60 * 60 * 1000));
        min = ((between / (60 * 1000)) - hour * 60);
        return (hour + ":" + min);
    }

    public static Long calDaysBetween(Date beginTime, Date endTime) {
        long between = 0;
        between = endTime.getTime() - beginTime.getTime();
        between = between / (60 * 60 * 1000 * 24);

        return between;
    }
}
