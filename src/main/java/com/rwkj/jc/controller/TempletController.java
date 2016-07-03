package com.rwkj.jc.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;
import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.domain.Templet;
import com.rwkj.jc.service.TempletManagerService;

@Controller
public class TempletController {
	
	@Resource
	private TempletManagerService templetManagerService;
	
	@InitBinder("templet")    
    public void initBinder1(WebDataBinder binder) {    
            binder.setFieldDefaultPrefix("templet.");    
    }   
	
	@RequestMapping("templetList")
	public ModelAndView getAdminList(HttpServletRequest req){
		
		String pageNum =req.getParameter("pageNum");
		int pageNumInt = 1;
		if(!StringUtils.isNullOrEmpty(pageNum)) {
			pageNumInt = Integer.parseInt(pageNum);
		}
		
		ModelAndView modelAndView = new ModelAndView();
		PageInfo<Templet> page = templetManagerService.getTemplets(pageNumInt, 2);
		modelAndView.addObject("page", page);
		modelAndView.setViewName("admin/index/templetList");
		return modelAndView;
	}
	
	@RequestMapping("addTemplet")
	public @ResponseBody Map<String, String> addTemplet(@ModelAttribute Templet templet){
		
		Map<String,String> map = new HashMap<String,String>();
		int count = templetManagerService.insert(templet);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("updateTemplet")
	public@ResponseBody Map<String,String> updateTemplet(@ModelAttribute Templet templet){
		Map<String,String> map = new HashMap<String,String>();
		Date updattime = new Date();
		templet.setUpdattime(updattime);
		int count = templetManagerService.updateByPrimaryKey(templet);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("deleteTemplet")
	public @ResponseBody Map<String,String> deleteTemplet(@RequestParam("id") String id){
		Map<String,String> map = new HashMap<String,String>();
		int count = templetManagerService.deleteByPrimaryKey(id);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	
	@RequestMapping("checkTempletTitle")
	public @ResponseBody Map<String,String> checkTempletTitle(@RequestParam("title") String title){
		Map<String,String> map = new HashMap<String,String>();
		if(templetManagerService.checkTempletTitle(title)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
}