package com.rwkj.jc.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rwkj.jc.domain.Plan;
import com.rwkj.jc.domain.Relation;
import com.rwkj.jc.domain.User;
import com.rwkj.jc.service.PlanService;
import com.rwkj.jc.service.RelationService;
import com.rwkj.jc.service.UserService;
import com.rwkj.jc.util.CheckIsPhone;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class UserLoginController {
	
	@Resource
	private UserService userService;
	@Resource
	private PlanService planService;
	@Resource
	private RelationService relationService;
	
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
				modelAndView.setViewName("client/login");
				modelAndView.addObject("message","用户编号或者密码错误！");
			}else {
				if("0".equals(user.getStatus())){
					modelAndView.setViewName("client/login");
					modelAndView.addObject("message","用户处于禁用状态！");
				}else{
					session.setAttribute("user", user);
					String userAgent = req.getHeader("user-agent");
					if(CheckIsPhone.check(userAgent)) {
						Map<Plan,List<Relation>> planForRelations = new LinkedHashMap<Plan,List<Relation>>();
						List<Plan> plans = planService.getAllPlans();
						for(Plan plan:plans) {
							List<Relation> relations = relationService.getRelationsByPlanIdAndUserNo("'"+plan.getId()+"'", "'"+user.getUserno()+"'");
							if(!CollectionUtils.isEmpty(relations)) {
								planForRelations.put(plan,relations);
							}
						}
						modelAndView.addObject("planForRelations",planForRelations);
						modelAndView.setViewName("client/main/indexm");
					}else{
						modelAndView.setViewName("client/main/main");
					}
				}
			}
		}
		return modelAndView;
	}
	
	@RequestMapping("/client/left")
	public ModelAndView left(HttpServletRequest req){
		
		ModelAndView modelAndView = new ModelAndView();
		Map<Plan,List<Relation>> planForRelations = new LinkedHashMap<Plan,List<Relation>>();
		
		HttpSession session = req.getSession(true);
		
		User user = (User)session.getAttribute("user");
		List<Plan> plans = planService.getAllPlans();
		for(Plan plan:plans) {
			List<Relation> relations = relationService.getRelationsByPlanIdAndUserNo("'"+plan.getId()+"'", "'"+user.getUserno()+"'");
			if(!CollectionUtils.isEmpty(relations)) {
				planForRelations.put(plan,relations);
			}
		}
		modelAndView.addObject("planForRelations",planForRelations);
		String userAgent = req.getHeader("user-agent");
		if(CheckIsPhone.check(userAgent)) {
			modelAndView.setViewName("client/main/indexm");
		}else{
			modelAndView.setViewName("client/main/left");
		}
		return modelAndView;
	}
	
	@RequestMapping("/client/userLoginByWebChat")
	public ModelAndView userLoginByWebChat(HttpServletRequest req){
		
		ModelAndView modelAndView = new ModelAndView();
		Map<Plan,List<Relation>> planForRelations = new LinkedHashMap<Plan,List<Relation>>();
		String webChat = req.getParameter("webChat");
		
		if(StringUtils.isEmpty(webChat)) {
			modelAndView.addObject("errorMsg", "客户端未接收到用户微信号，请联系管理员进行处理！");
			modelAndView.setViewName("client/main/error");
			
		}else{
			HttpSession session = req.getSession(true);
			
			int count = userService.getUserCountByColumnValue("webChat", webChat);
			if(count == 1) {
				User user = userService.getUserByWebChat(webChat);
						if("0".equals(user.getStatus())){
							modelAndView.addObject("errorMsg", "用户处于禁用状态，请联系管理员进行处理！");
							modelAndView.setViewName("client/main/error");
						}else{
							session.setAttribute("user", user);
							List<Plan> plans = planService.getAllPlans();
							for(Plan plan:plans) {
								List<Relation> relations = relationService.getRelationsByPlanIdAndUserNo("'"+plan.getId()+"'", "'"+user.getUserno()+"'");
								planForRelations.put(plan,relations);
							}
							modelAndView.addObject("planForRelations",planForRelations);
							modelAndView.setViewName("client/main/index");
						}
			}else{
				if(count == 0) {
					modelAndView.addObject("errorMsg", "用户在系统中不存在，请联系管理员处理！");
				}else{
					modelAndView.addObject("errorMsg", "用户的微信号与其他人重复，请联系管理员处理！");
				}
				
				modelAndView.setViewName("client/main/error");
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
