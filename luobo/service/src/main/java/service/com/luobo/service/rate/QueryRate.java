package com.luobo.service.rate;


import net.sf.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import net.sf.json.JSONObject;
/**
 * @Author:liaom
 * @Time:2015/6/11 18:00
 */
public class QueryRate {
    public static void main(String[] args) {
        String city = "suzhou";//参数
        String url = "http://op.juhe.cn/onebox/exchange/currency?";//url为请求的api接口地址
        String from = "JPY";
        String to = "BHD";
        String key= "8b8901dd0240680466765e05f9875793";//申请的对应key
        String urlAll = new StringBuffer(url).
                append("&key=").append(key).append("&type=json").
                append("&from=").append(from).append("&to=").append(to).toString();
        String charset ="UTF-8";
        String jsonResult = get(urlAll, charset);//得到JSON字符串
        JSONObject object = JSONObject.fromObject(jsonResult);//转化为JSON类
        String code = object.getString("error_code");//得到错误码
        //错误码判断
        if(code.equals("0")){
            //根据需要取得数据
            JSONObject jsonObject =  (JSONObject)object.getJSONArray("result").get(0);
            System.out.println(jsonObject);
       //     System.out.println(jsonObject.getJSONObject("citynow").get("AQI"));
        }else{
            System.out.println("error_code:"+code+",reason:"+object.getString("reason"));
        }
    }
    /**
     *
     * @param urlAll:请求接口
     * @param charset:字符编码
     * @return 返回json结果
     */
    public static String get(String urlAll,String charset){
        BufferedReader reader = null;
        String result = null;
        StringBuffer sbf = new StringBuffer();
        String userAgent = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36";//模拟浏览器
        try {
            URL url = new URL(urlAll);
            HttpURLConnection connection = (HttpURLConnection)url.openConnection();
            connection.setRequestMethod("GET");
            connection.setReadTimeout(30000);
            connection.setConnectTimeout(30000);
            connection.setRequestProperty("User-agent",userAgent);
            connection.connect();
            InputStream is = connection.getInputStream();
            reader = new BufferedReader(new InputStreamReader(
                    is, charset));
            String strRead = null;
            while ((strRead = reader.readLine()) != null) {
                sbf.append(strRead);
                sbf.append("\r\n");
            }
            reader.close();
            result = sbf.toString();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}