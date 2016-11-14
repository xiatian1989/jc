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
import com.rwkj.jc.service.DepartService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class DepartManageController {
	
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
        if(depart.getId() != null) {
	        jsonObject.put("id",depart.getId());
	        jsonObject.put("departNo",depart.getDepartNo());
	        jsonObject.put("departName",depart.getDepartName());
	        jsonObject.put("parentNo",depart.getParentNo());
	        jsonObject.put("nodePath",depart.getNodePath());
	        jsonObject.put("isleaf",depart.getIsleaf()?"是":"否");
	        jsonObject.put("status",depart.getStatus()?"启用":"禁用");
        }else{
        	jsonObject.put("departNo","");
  	        jsonObject.put("departName","");
  	        jsonObject.put("nodePath","");
  	        jsonObject.put("isleaf","");
  	        jsonObject.put("status","");
        }
        
		return jsonObject;
	}
	
	@RequestMapping("addDepart")
	public @ResponseBody Map<String,String> addDepart(@ModelAttribute Depart depart){
		Map<String, String> result = new HashMap<String,String>();
		Depart parentDepart = null;
		int count = 0;
		depart.setId(CommonUtils.getUUID());
		depart.setIsleaf(true);
		depart.setNodePath(depart.getNodePath()+"|"+depart.getDepartNo());
		if(StringUtils.isNullOrEmpty(depart.getParentNo())) {
			depart.setParentNo("0");
		}else{
			parentDepart = departService.getDepartByDepartNo(depart.getParentNo());
			
		}
		count = departService.addDepart(depart);
		
		if(count>0){
			result.put("result", "success");
			if(parentDepart != null){
				if(parentDepart.getIsleaf()) {
					parentDepart.setIsleaf(false);
					departService.updateDepart(parentDepart);
				}
			}
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
	@RequestMapping("updateDepart")
	public @ResponseBody Map<String,String> updateAdmin(@ModelAttribute Depart depart){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		count = departService.updateDepart(depart);
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "更新失败,请联系管理员");
		}
		return result;
	}
	
	@RequestMapping("deleteDepart")
	public @ResponseBody Map<String,String> deleteAdmin(@RequestParam("id") String id){
		Map<String,String> map = new HashMap<String,String>();
		Depart depart = departService.selectByPrimaryKey(id);
		int count = departService.deleteDepart(id); 
		if(count>0){
			//处理子部门数据，应该全部进行删除
			if(!depart.getIsleaf()){
				departService.deleteSonDepartsByNodepath("%"+depart.getNodePath()+"%");
			}
			//处理父部门数据
			List<Depart> sonForFatherDeparts = null;
			if(!"0".equals(depart.getParentNo())) {
				sonForFatherDeparts = departService.getDepartsByParentNo(depart.getParentNo());
				if(sonForFatherDeparts.size()==0){
					Depart fatherDepart = departService.getDepartByDepartNo(depart.getParentNo());
					fatherDepart.setIsleaf(true);
					departService.updateDepart(fatherDepart);
				}
				
			}
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("checkDepartDepartName")
	public @ResponseBody Map<String,String> checkDepartDepartName(@RequestParam("departName") String departName){
		Map<String,String> map = new HashMap<String,String>();
		if(departService.checkDepartName(departName)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
	
	@RequestMapping("checkDepartDepartNo")
	public @ResponseBody Map<String,String> checkDepartDepartNo(@RequestParam("departNo") String departNo){
		Map<String,String> map = new HashMap<String,String>();
		if(departService.checkDepartNo(departNo)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
	
}
