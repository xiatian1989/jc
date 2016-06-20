package com.rwkj.jc.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.service.AdminService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class AdminLoginController {
	
	@Resource
	private AdminService adminService;
	
	@RequestMapping("adminLogin")
	public String AdminLogin(HttpServletRequest req){
		
		ModelAndView modelAndView = new ModelAndView();
		String username = req.getParameter("txtName");
		String password = req.getParameter("txtcode");
		String code = req.getParameter("txtcode");
		
		HttpSession session = req.getSession(true);
		String sessionCode = (String)session.getAttribute("code");
		
		if(StringUtils.isNullOrEmpty(sessionCode)){
			modelAndView.setViewName("admin/index/Login");
			modelAndView.addObject("message","验证码已经过期，请刷新页面以后登录！");
		}
		if(!sessionCode.equals(code)) {
			modelAndView.setViewName("admin/index/Login");
			modelAndView.addObject("message","验证码错误！");
		}
		
		Admin admin = adminService.getAdminByUserName(username);
		
		if(!CommonUtils.getMD5Pssword(password).equals(admin.getPassword())) {
			modelAndView.setViewName("admin/index/Login");
			modelAndView.addObject("message","密码或者验证码错误！");
		}else {
			session.setAttribute("Admin", admin);
		}
		
		return "admin/index/index";
	}
}
	