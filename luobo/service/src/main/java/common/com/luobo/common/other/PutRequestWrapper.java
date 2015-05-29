package com.luobo.common.other;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.util.Collections;
import java.util.Enumeration;
import java.util.Map;

public class PutRequestWrapper extends HttpServletRequestWrapper {


    //自定义解析完成后的参数，放入request中的key

    public final static String CUSTOMER_ATTR_KEY = "customer.attribute.parameter";

    private Map<String, String[]> reqParams;

    public PutRequestWrapper(HttpServletRequest request) {
        super(request);
        reqParams = (Map<String, String[]>) request.getAttribute(CUSTOMER_ATTR_KEY);

    }

    @Override
    public Map getParameterMap() {
        return reqParams;
    }

    @Override
    public Enumeration getParameterNames() {
        return Collections.enumeration(reqParams.keySet());
    }


    @Override
    public String[] getParameterValues(String name) {
        return reqParams.get(name);
    }

}