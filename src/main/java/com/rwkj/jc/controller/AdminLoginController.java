package com.rwkj.jc.controller;

import java.net.InetAddress;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.bean.SystemInfo;
import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.service.AdminService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class AdminLoginController {
	
	@Resource
	private AdminService adminService;
	
	@RequestMapping("adminLogin")
	public ModelAndView adminLogin(HttpServletRequest req){
		
		ModelAndView modelAndView = new ModelAndView();
		String username = req.getParameter("txtName");
		String password = req.getParameter("txtPwd");
		String code = req.getParameter("txtcode");
		
		HttpSession session = req.getSession(true);
		String sessionCode = (String)session.getAttribute("code");
		
		if(StringUtils.isNullOrEmpty(sessionCode)){
			modelAndView.setViewName("admin/login");
			modelAndView.addObject("message","验证码已经过期，请刷新页面以后登录！");
			return modelAndView;
		}
		if(!sessionCode.equalsIgnoreCase(code)) {
			modelAndView.setViewName("admin/login");
			modelAndView.addObject("message","验证码错误！");
			return modelAndView;
		}
		
		Admin admin = adminService.getAdminByUserName(username);
		
		if(admin==null){
			modelAndView.setViewName("admin/login");
			modelAndView.addObject("message","用户名不存在！");
		}else{
			if(!CommonUtils.getMD5Pssword(password).equals(admin.getPassword())) {
				modelAndView.setViewName("admin/login");
				modelAndView.addObject("message","用户名或者密码错误！");
			}else {
				if("0".equals(admin.getStatus())){
					modelAndView.setViewName("admin/login");
					modelAndView.addObject("message","处于禁用状态！");
				}else{
					session.setAttribute("Admin", admin);
					
					modelAndView.setViewName("admin/SystemManage/index");
					
					SystemInfo systemInfo = new SystemInfo();
					
					systemInfo.setoS(System.getenv("OS"));
					systemInfo.setServerName(System.getenv("COMPUTERNAME"));
					systemInfo.setJavaHome(System.getenv("JAVA_HOME"));
					systemInfo.setServerInfo(req.getServletContext().getServerInfo());
					systemInfo.setContextPath(req.getServletContext().getContextPath());
					
					String localIp = "";
					try{
						InetAddress ia = InetAddress.getLocalHost();
						localIp = ia.getHostAddress();
					}catch(Exception e) {
						e.printStackTrace();
					}
					systemInfo.setServerHostIP(localIp);
					systemInfo.setProtocol(req.getProtocol());
					systemInfo.setServerPort(req.getServerPort()+"");
					systemInfo.setServerTime(new Date(System.currentTimeMillis()).toString());
					
					session.setAttribute("systemInfo", systemInfo);
				}
			}
		}
		return modelAndView;
	}
	
	@RequestMapping("adminLogout")
	public ModelAndView adminLogout(HttpServletRequest req){
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = req.getSession(true);
		session.setAttribute("Admin", null);
		modelAndView.setViewName("admin/login");
		return modelAndView;
	}
}
	