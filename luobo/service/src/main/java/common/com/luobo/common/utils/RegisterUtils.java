package com.luobo.common.utils;

import com.pandawork.core.log.LogClerk;
import net.sf.json.JSONObject;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

/**
 * 注册用户动态密码发送
 * @Author: wanglp
 * @Time: 2015/1/20.
 */
public class RegisterUtils {

    public static final String POST = "POST";

    private static TrustManager myX509TrustManager = new X509TrustManager() {
        @Override
        public void checkClientTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {

        }
        @Override
        public void checkServerTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {

        }
        @Override
        public X509Certificate[] getAcceptedIssuers() {
            return null;
        }
    };

    public static JSONObject sendRequest(String url, String requestMethod, String data) {
        String result = null;

        try {
            // 设置SSLContext
            SSLContext sslContext = SSLContext.getInstance("TLS");
            sslContext.init(null, new TrustManager[] { myX509TrustManager }, null);

            // 打开连接
            URL requestUrl = new URL(url);
            HttpsURLConnection httpsURLConnection = (HttpsURLConnection) requestUrl.openConnection();

            // 设置套接工厂
            httpsURLConnection.setSSLSocketFactory(sslContext.getSocketFactory());

            //设置请求头信息
            /*httpsURLConnection.setRequestProperty("Authorization","appKey=\"  \", token=\"  \"");
            httpsURLConnection.setRequestProperty("Accept","application/json");
            httpsURLConnection.setRequestProperty("Content-Type","application/json;charset=UTF-8");*/

            // 加入数据
            httpsURLConnection.setRequestMethod(requestMethod);
            // 如果是post请求，加入post数据
            if(POST.equalsIgnoreCase(requestMethod))  {
                httpsURLConnection.setDoOutput(true);
                OutputStream out = httpsURLConnection.getOutputStream();
                if(data != null) {
                    out.write(data.getBytes("UTF-8"));
                }
                out.flush();
                out.close();
            }

            // 获取输入流
            BufferedReader br = new BufferedReader(new InputStreamReader(httpsURLConnection.getInputStream(), "UTF-8"));
            int code = httpsURLConnection.getResponseCode();
            if(HttpsURLConnection.HTTP_OK == code) {
                // 连接成一个字符串
                String temp = null;
                while((temp = br.readLine()) != null) {
                    if(result != null) {
                        result += temp;
                    } else {
                        result = temp;
                    }
                }
            }
        } catch (KeyManagementException e) {
            LogClerk.errLog.error(e);
        } catch (NoSuchAlgorithmException e) {
            LogClerk.errLog.error(e);
        } catch (MalformedURLException e) {
            LogClerk.errLog.error(e);
        } catch (ProtocolException e) {
            LogClerk.errLog.error(e);
        } catch (IOException e) {
            LogClerk.errLog.error(e);
        }


        JSONObject jsonObject = JSONObject.fromObject(result);
        return jsonObject;
    }
}
