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
		String parentNo = request.getParameter("id");
		List<Depart> departs = null;
		if(StringUtils.isNullOrEmpty(parentNo)){
			departs = departService.getFirstLevelDeparts();
			
		}else{
			departs = departService.getDepartsByParentNo(parentNo);
		}
		
		JSONArray jsonArray = new JSONArray();
		JSONArray subJsonArray = new JSONArray();
		JSONObject subjsonObject = null;
        for(Depart depart:departs){  
            subjsonObject = new JSONObject();  
            subjsonObject.put("id",depart.getDepartNo());
            subjsonObject.put("text",depart.getDepartName());
             if(depart.getIsleaf()){
            	 subjsonObject.put("state","open");
             }else{
            	 subjsonObject.put("state","closed");
             }
             subJsonArray.add(subjsonObject);
        }
        if(StringUtils.isNullOrEmpty(parentNo)){
        	 JSONObject jsonObject = new JSONObject();
             jsonObject.put("id", "0");
             jsonObject.put("text", "部门列表");
             jsonObject.put("children", subJsonArray);
             jsonArray.add(jsonObject);
     		return jsonArray;
        }else{
        	return subJsonArray;
        }
	}
	
	@RequestMapping("subDepartList")
	public @ResponseBody Object getSubDepartList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		int total = 0;
		String parentNo = request.getParameter("param");
		List<Depart> departs = null;
		if(StringUtils.isNullOrEmpty(parentNo)){
			departs = new ArrayList<Depart>();
			total = 0;
		}else{
			departs = departService.getDepartsByParentNoForPage(parentNo, (page-1)*rows, rows);
			total = departService.getSonCountByParentNo(parentNo);
		}
		
		JSONArray jsonArray = new JSONArray();  
		for(Depart depart:departs){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",depart.getId());
             jsonObject.put("departNo",depart.getDepartNo());
             jsonObject.put("departName",depart.getDepartName());
             jsonObject.put("parentNo",depart.getParentNo());
             jsonObject.put("nodePath",depart.getNodePath());
             jsonObject.put("isleaf",depart.getIsleaf());
             jsonObject.put("status",depart.getStatus());
             jsonArray.add(jsonObject) ;  
        }
		result.put("total", total);  
	    result.put("rows",jsonArray);
		return result;
	}
	
	@RequestMapping("getDepartDetail")
	public @ResponseBody Object getDepartDetail(HttpServletRequest request){
		String departNo = request.getParameter("departNo");
		Depart depart = null;
		if("0".equals(departNo)){
			depart = new Depart();
		}else{
			depart = departService.getDepartByDepartNo(departNo);
		}
		
         JSONObject jsonObject = new JSONObject();  
         jsonObject.put("id",depart.getId());
         jsonObject.put("departNo",depart.getDepartNo());
         jsonObject.put("departName",depart.getDepartName());
         jsonObject.put("parentNo",depart.getParentNo());
         jsonObject.put("nodePath",depart.getNodePath());
         jsonObject.put("isleaf",depart.getIsleaf());
         jsonObject.put("status",depart.getStatus());
         
		return jsonObject;
	}
	
	@RequestMapping("addDepart")
	public @ResponseBody Map<String,String> addDepart(@ModelAttribute Depart depart){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		depart.setId(CommonUtils.getUUID());
		depart.setIsleaf(true);
		depart.setStatus(true);
		depart.setNodePath(depart.getNodePath()+"|"+depart.getDepartNo());
 	    count = departService.addDepart(depart);
		
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
