package com.rwkj.jc.controller;

import java.util.ArrayList;
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
import com.rwkj.jc.domain.Depart;
import com.rwkj.jc.domain.User;
import com.rwkj.jc.service.DepartService;
import com.rwkj.jc.service.UserService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class UserManageController {
	
	@Resource
	private UserService userService;
	@Resource
	private DepartService departService;
	
	@InitBinder("user")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("user.");    
	}    
	
	@RequestMapping("userList")
	public @ResponseBody Object getuserList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		int total = 0;
		Depart depart = null;
		String column= request.getParameter("column");
		String value = request.getParameter("value");
		List<User> users = null;
		if(StringUtils.isNullOrEmpty(column)){
			users = userService.getAllUsersForPage((page-1)*rows, rows);
			total = userService.getAllUsersCount();
		}else{
			if("depart_No".equals(column)) {
				depart = departService.getDepartByDepartName(value);
				if(depart == null){
					users = new ArrayList<User>();
				}else{
					value = depart.getDepartNo();
					users = userService.getUserByColumnValue(column, value, (page-1)*rows, rows);
					total = userService.getUserCountByColumnValue(column, value);
				}
			}else if("leader_No"){
				
			}
			
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(user user:users){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",user.getId());
             jsonObject.put("username",user.getUsername());
             jsonObject.put("password",user.getPassword());
             jsonObject.put("level",user.getLevel());
             jsonObject.put("status",user.getStatus());
             jsonArray.add(jsonObject) ;  
        }  
		result.put("total", total);  
	    result.put("rows",jsonArray);
		return result;
	}
	
	@RequestMapping("adduser")
	public @ResponseBody Map<String,String> adduser(@ModelAttribute user user){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		user.setId(CommonUtils.getUUID());
		String password = user.getPassword();
		user.setPassword(CommonUtils.getMD5Pssword(password));
		user.setLevel(false);
		count = userService.adduser(user);
		
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
	@RequestMapping("updateuser")
	public @ResponseBody Map<String,String> updateuser(@ModelAttribute user user){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		count = userService.updateuser(user);
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "更新失败");
		}
		return result;
	}
	
	@RequestMapping("deleteuser")
	public @ResponseBody Map<String,String> deleteuser(@RequestParam("id") String id){
		Map<String,String> map = new HashMap<String,String>();
		int count = userService.deleteuser(id);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("checkuserName")
	public @ResponseBody Map<String,String> checkuserName(@RequestParam("name") String name){
		Map<String,String> map = new HashMap<String,String>();
		if(userService.checkuserName(name)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
	
}
