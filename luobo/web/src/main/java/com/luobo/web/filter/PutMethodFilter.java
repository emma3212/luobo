package com.luobo.web.filter;

import com.luobo.common.other.PutRequestWrapper;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

/**
 * 对put方法增加属性支持。
 *
 * User: gaoyang
 * Date: 13-9-24
 * Time: 下午4:49
 */
public class PutMethodFilter implements Filter {


    /**
     * Default constructor.
     */
    public PutMethodFilter() {
    }


    /**
     * @seeFilter#destroy()
     */
    public void destroy() {
    }

    /**
     * @seeFilter#doFilter(ServletRequest,ServletResponse, FilterChain)
     */
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        // PUT请求不能通过request.getparameter()得到参数
        if ("PUT".equalsIgnoreCase(req.getMethod())) {
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    request.getInputStream()));
            String org_req_content;
            StringBuilder content = new StringBuilder();
            while ((org_req_content = in.readLine()) != null) {
                    content.append(URLDecoder.decode(org_req_content, "UTF-8"));
            }
            Map<String, String[]> map = parseRequestParameter(content.toString());
            request.setAttribute(PutRequestWrapper.CUSTOMER_ATTR_KEY, map);
            //包装成自定义的请求
            request = new PutRequestWrapper(req);
        }
        chain.doFilter(request, response);
    }

    /**
     * 自定义参数解析
     * <p/>
     * 注：此方法暂时没有考虑具有相同名称的一组提交值的情况，如需要，请自己更改下面的代码
     *
     * @return
     * @paramcontent
     */
    public Map<String, String[]> parseRequestParameter(String content) {
        Map<String, String[]> params = new HashMap<String, String[]>();
        if (content == null || "".equals(content.trim())) {
            return params;
        }
        try {
            String[] tmp = content.split("&");
            for (int i = 0; i < tmp.length; i++) {
                String[] keyValue = tmp[i].split("=");
                if(keyValue.length > 1 && keyValue[1] != null && !"".equals(keyValue[1])){
                    params.put(keyValue[0], new String[]{keyValue[1]});
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return params;
    }

    /**
     * @seeFilter#init(FilterConfig)
     */

    public void init(FilterConfig fConfig) throws ServletException {
    }


}