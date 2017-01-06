package com.rwkj.jc.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rwkj.jc.domain.Relation;
import com.rwkj.jc.domain.User;
import com.rwkj.jc.service.PlanService;
import com.rwkj.jc.service.RelationService;

@Controller
public class PlanStatusForUserController {
	
	@Resource
	private PlanService planService;
	@Resource
	private RelationService relationService;
	
	@RequestMapping("/client/planStatus")
	public ModelAndView userLogout(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(true);
		String userNo = ((User)session.getAttribute("user")).getUserno();
		List<Relation> relations =  relationService.getRelationsByUserNo(userNo);
		Map<String, LinkedHashMap<String, String>> planStatus = new LinkedHashMap<String,LinkedHashMap<String,String>>();
		for(Relation relation:relations) {
			
		}
		modelAndView.setViewName("client/login");
		return modelAndView;
	}
}
