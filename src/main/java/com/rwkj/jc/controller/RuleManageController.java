package com.rwkj.jc.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.rwkj.jc.domain.Rule;
import com.rwkj.jc.service.RuleService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class RuleManageController {
	
	@Resource
	private RuleService ruleService;
	
	@InitBinder("rule")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("rule.");    
	}
	
	@RequestMapping("/admin/addRule")
	public @ResponseBody Map<String,String> addRule(@ModelAttribute Rule rule){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		String id = CommonUtils.getUUID();
		rule.setId(id);
		count = ruleService.addRule(rule);
		
		if(count>0){
			result.put("result", "success");
			result.put("id", id);
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
	@RequestMapping("/admin/rulePreview")
	public ModelAndView rulePreview(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		String ruleId = request.getParameter("ruleId");
		Rule rule= ruleService.getRuleById(ruleId);
		modelAndView.addObject("rule",rule);
		modelAndView.setViewName("admin/EvaluationManage/ruleview");
		return modelAndView;
	}
	
	@RequestMapping("/admin/updateRule")
	public @ResponseBody Map<String,String> updateRule(@ModelAttribute Rule rule){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		count = ruleService.updateRule(rule);
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "更新失败");
		}
		return result;
	}
	
}
