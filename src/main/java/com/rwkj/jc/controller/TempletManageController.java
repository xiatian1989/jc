package com.rwkj.jc.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.domain.Templet;
import com.rwkj.jc.service.TempletService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class TempletManageController {
	
	@Resource
	private TempletService templetService;
	
	@InitBinder("templet")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("templet.");    
	}    
	
	@RequestMapping("/admin/templetList")
	public @ResponseBody Object getTempletList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		int total = 0;
		String column = request.getParameter("column");
		String value = request.getParameter("value");
		List<Templet> templets = null;
		if(StringUtils.isNullOrEmpty(value)){
			templets = templetService.getTemplets((page-1)*rows, rows);
			total = templetService.getTempletsCount();
		}else{
			value = "%"+value+"%";
			templets = templetService.getTempletsByColumnValue(column, value, (page-1)*rows, rows);
			total = templetService.getTempletsCountByColumnValue(column, value);
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(Templet templet:templets){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",templet.getId());
             jsonObject.put("templettitle",templet.getTemplettitle());
             jsonObject.put("keyword",templet.getKeyword());
             jsonObject.put("description",templet.getDescription());
             jsonObject.put("createtime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(templet.getCreatetime()));
             jsonObject.put("updatetime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(templet.getUpdatetime()));
             jsonObject.put("type",templet.getType());
             jsonObject.put("status",templet.getStatus());
             jsonArray.add(jsonObject) ;  
        }  
		result.put("total", total);  
	    result.put("rows",jsonArray);
		return result;
	}
	
	@RequestMapping("/admin/templetListForPaper")
	public ModelAndView templetListForPage(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
			@RequestParam(required = false, defaultValue = "10") Integer rows){
		String column = request.getParameter("column");
		String value = request.getParameter("value");
		List<Templet> templets = null;
		if(StringUtils.isNullOrEmpty(value)){
			templets = templetService.getTemplets((page-1)*rows, rows);
		}else{
			value = "%"+value+"%";
			templets = templetService.getTempletsByColumnValue(column, value, (page-1)*rows, rows);
		}
		Iterator<Templet> iterator = templets.iterator();
		while(iterator.hasNext()){
			if(!iterator.next().getStatus()) {
				iterator.remove();
			}
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("templets",templets);
		modelAndView.setViewName("admin/SystemManage/templetListForPaper");
		return modelAndView;
	}
	
	@RequestMapping("/admin/addTemplet")
	public @ResponseBody Map<String,String> addTemplet(@ModelAttribute Templet templet){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		templet.setId(CommonUtils.getUUID());
		templet.setCreatetime(new Date(System.currentTimeMillis()));
		templet.setUpdatetime(new Date(System.currentTimeMillis()));
		count = templetService.addTemplet(templet);
		
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
	@RequestMapping("/admin/updateTemplet")
	public @ResponseBody Map<String,String> updateTemplet(@ModelAttribute Templet templet){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		templet.setUpdatetime(new Date(System.currentTimeMillis()));
		count = templetService.updateTemplet(templet);
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "更新失败");
		}
		return result;
	}
	
	@RequestMapping("/admin/deleteTemplet")
	public @ResponseBody Map<String,String> deleteTemplet(@RequestParam("id") String id){
		Map<String,String> map = new HashMap<String,String>();
		id = id.substring(0,id.length()-1);
		int count = templetService.deleteTemplets("("+id+")");
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("/admin/checkTempletNameUnique")
	public @ResponseBody Map<String,String> checkTempletNameUnique(@RequestParam("name") String name){
		Map<String,String> map = new HashMap<String,String>();
		if(templetService.checkTempletName(name)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
	
}
