package com.rwkj.jc.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminFilter implements Filter {

	public void destroy() {
		
	}

	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String servletPath = request.getServletPath();
        
        if (servletPath.equals("admin/login.jsp") || servletPath.endsWith("admin/login.jsp")) {
            chain.doFilter(req, res);
            return;
        }
        
        Object sessionObj = request.getSession().getAttribute("Admin");
        // 如果Session为空，则跳转到指定页面
        if (sessionObj == null) {
        	 String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/admin/login.jsp");
        } else {
            chain.doFilter(req, res);
        }
	}

	public void init(FilterConfig arg0) throws ServletException {
		
	}

}
