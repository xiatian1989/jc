package com.rwkj.jc.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rwkj.jc.domain.User;
import com.rwkj.jc.service.UserService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class UserLoginController {
	
	@Resource
	private UserService userService;
	
	@RequestMapping("/client/userLogin")
	public ModelAndView userLogin(HttpServletRequest req){
		
		ModelAndView modelAndView = new ModelAndView();
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		
		HttpSession session = req.getSession(true);
		
		User user = userService.getUserByUserNo(username);
		
		if(user==null){
			modelAndView.setViewName("client/login");
			modelAndView.addObject("message","用户编号不存在！");
		}else{
			if(!CommonUtils.getMD5Pssword(password).equals(user.getPassword())) {
				modelAndView.setViewName("admin/login");
				modelAndView.addObject("message","用户编号或者密码错误！");
			}else {
				if("0".equals(user.getStatus())){
					modelAndView.setViewName("admin/login");
					modelAndView.addObject("message","用户处于禁用状态！");
				}else{
					session.setAttribute("user", user);
					modelAndView.setViewName("client/main/index");
				}
			}
		}
		return modelAndView;
	}
	
	@RequestMapping("/client/userLogout")
	public ModelAndView userLogout(HttpServletRequest req){
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = req.getSession(true);
		session.setAttribute("user", null);
		modelAndView.setViewName("client/login");
		return modelAndView;
	}
}
