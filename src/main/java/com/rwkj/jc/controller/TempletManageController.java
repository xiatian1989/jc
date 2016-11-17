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
import com.rwkj.jc.service.AdminService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class TempletManageController {
	
	@Resource
	private AdminService adminService;
	
	@InitBinder("templet")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("templet.");    
	}    
	
	@RequestMapping("templetList")
	public @ResponseBody Object getTempletList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		int total = 0;
		String param = request.getParameter("param");
		List<Admin> admins = null;
		if(StringUtils.isNullOrEmpty(param)){
			admins = adminService.getAdmins((page-1)*rows, rows);
			total = adminService.getAdminsCount();
		}else{
			admins = adminService.getAdminsByUserName("%"+param+"%", (page-1)*rows, rows);
			total = adminService.getAdminsCountByUserName("%"+param+"%");
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(Admin admin:admins){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",admin.getId());
             jsonObject.put("username",admin.getUsername());
             jsonObject.put("password",admin.getPassword());
             jsonObject.put("level",admin.getLevel());
             jsonObject.put("status",admin.getStatus());
             jsonArray.add(jsonObject) ;  
        }  
		result.put("total", total);  
	    result.put("rows",jsonArray);
		return result;
	}
	
	@RequestMapping("addTemplet")
	public @ResponseBody Map<String,String> addTemplet(@ModelAttribute Admin admin){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		admin.setId(CommonUtils.getUUID());
		String password = admin.getPassword();
		admin.setPassword(CommonUtils.getMD5Pssword(password));
		admin.setLevel(false);
		count = adminService.addAdmin(admin);
		
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
	@RequestMapping("updateTemplet")
	public @ResponseBody Map<String,String> updateTemplet(@ModelAttribute Admin admin){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		count = adminService.updateAdmin(admin);
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "更新失败");
		}
		return result;
	}
	
	@RequestMapping("deleteTemplet")
	public @ResponseBody Map<String,String> deleteTemplet(@RequestParam("id") String id){
		Map<String,String> map = new HashMap<String,String>();
		int count = adminService.deleteAdmin(id);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("checkTempletName")
	public @ResponseBody Map<String,String> checkAdminName(@RequestParam("name") String name){
		Map<String,String> map = new HashMap<String,String>();
		if(adminService.checkAdminName(name)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
	
}
