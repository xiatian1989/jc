package com.rwkj.jc.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@RequestMapping("addRule")
	public @ResponseBody Map<String,String> addRule(@ModelAttribute Rule rule){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		rule.setId(CommonUtils.getUUID());
		count = ruleService.addRule(rule);
		
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
	@RequestMapping("updateRule")
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
