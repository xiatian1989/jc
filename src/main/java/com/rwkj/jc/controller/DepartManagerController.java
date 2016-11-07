package com.rwkj.jc.controller;

import java.util.HashMap;
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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.domain.Depart;
import com.rwkj.jc.service.DepartService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class DepartManagerController {
	
	@Resource
	private DepartService departService;
	
	@InitBinder("depart")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("depart.");    
	}    
	
	@RequestMapping("departList")
	public @ResponseBody Object getDepartList(HttpServletRequest request){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		String param = request.getParameter("param");
		List<Depart> departs = null;
		if(StringUtils.isNullOrEmpty(param)){
			departs = departService.getDeparts();
		}else{
			departs = departService.getDepartsByDepartName(param);
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(Depart depart:departs){  
           /*  JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",admin.getId());
             jsonObject.put("username",admin.getUsername());
             jsonObject.put("password",admin.getPassword());
             jsonObject.put("level",admin.getLevel());
             jsonObject.put("status",admin.getStatus());
             jsonArray.add(jsonObject) ;  */
        }  
	    result.put("rows",jsonArray);
		return result;
	}
	
	@RequestMapping("addDepart")
	public @ResponseBody Map<String,String> addAdmin(@ModelAttribute Admin admin){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		admin.setId(CommonUtils.getUUID());
		String password = admin.getPassword();
		admin.setPassword(CommonUtils.getMD5Pssword(password));
		admin.setLevel(false);
/*		count = adminService.addAdmin(admin);*/
		
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
	@RequestMapping("updateDepart")
	public @ResponseBody Map<String,String> updateAdmin(@ModelAttribute Admin admin){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		/*count = adminService.updateAdmin(admin);*/
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "更新失败");
		}
		return result;
	}
	
	@RequestMapping("deleteDepart")
	public @ResponseBody Map<String,String> deleteAdmin(@RequestParam("id") String id){
		Map<String,String> map = new HashMap<String,String>();
	/*	int count = adminService.deleteAdmin(id);*/
	/*	if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}*/
		return map;
	}
	
	@RequestMapping("checkDepartName")
	public @ResponseBody Map<String,String> checkAdminName(@RequestParam("name") String name){
		Map<String,String> map = new HashMap<String,String>();
	/*	if(adminService.checkAdminName(name)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}*/
		return map;
	}
	
}