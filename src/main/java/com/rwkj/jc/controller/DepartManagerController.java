package com.rwkj.jc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.domain.Depart;
import com.rwkj.jc.service.DepartManagerService;
import com.rwkj.jc.util.CommonUtils;
import com.rwkj.jc.util.Constant;

@Controller
public class DepartManagerController {
	
	@Resource
	private DepartManagerService departManagerService;
	
	@InitBinder("depart")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("depart.");    
	} 
	
	@RequestMapping("departList")
	public ModelAndView getdepartList(HttpServletRequest request){
		
		HttpSession session = request.getSession(true);
		
		String pageNum =request.getParameter("pageNum");
		int pageNumInt = 1;
		if(!StringUtils.isNullOrEmpty(pageNum)) {
			pageNumInt = Integer.parseInt(pageNum);
		}
		Admin admin = (Admin)session.getAttribute("Admin");
		int sequence = admin.getOrganization().getSequence();
		String tableName = "jc_depart_"+sequence;
		ModelAndView modelAndView = new ModelAndView();
		PageInfo<Depart> page = departManagerService.getDeparts(tableName, pageNumInt, Constant.pagesize);
		modelAndView.addObject("page", page);
		modelAndView.setViewName("admin/depart/departList");
		return modelAndView;
	}
	
	@RequestMapping("departListtoJsonForUpdate")
	public@ResponseBody List<Depart> departListtoJsonForUpdate(@RequestParam("departNo") String departNo,HttpServletRequest request){
		
		HttpSession session = request.getSession(true);
		
		Admin admin = (Admin)session.getAttribute("Admin");
		int sequence = admin.getOrganization().getSequence();
		String tableName = "jc_depart_"+sequence;
		List<Depart> departs = departManagerService.getDeparts(tableName);
		List<Depart> dealDeparts = new ArrayList<Depart>();
		
		String parentDepartNo ="";
		String tempDepartNo ="";
		String tempNodepath ="";
		
		for(Depart depart:departs) {
			if(depart.getDepartNo().equals(departNo)){
				parentDepartNo = depart.getParentNo();
				break;
			}
		}
		for(Depart depart:departs) {
			tempDepartNo = depart.getDepartNo();
			tempNodepath = depart.getNodePath();
			if(tempDepartNo.equals(departNo)) {
				continue;
			}
			if(tempNodepath.contains(departNo)) {
				continue;
			}
			if(tempNodepath.endsWith("|"+parentDepartNo+"|") || tempNodepath.equals(parentDepartNo+"|")) {
				dealDeparts.add(0, depart);
			}else{
				dealDeparts.add(depart);
			}
			
		}
		return dealDeparts;
	}
	
	@RequestMapping("departListtoJson")
	public@ResponseBody List<Depart> getDepartToJson(HttpServletRequest request){
		
		HttpSession session = request.getSession(true);
		
		Admin admin = (Admin)session.getAttribute("Admin");
		int sequence = admin.getOrganization().getSequence();
		String tableName = "jc_depart_"+sequence;
		List<Depart> departs = departManagerService.getDeparts(tableName);
		return departs;
	}
	
	@RequestMapping("addDepart")
	public @ResponseBody Map<String,String> addDepart(@ModelAttribute Depart depart,HttpServletRequest request){
		Map<String,String> map = new HashMap<String,String>();
		HttpSession session = request.getSession(true);
		
		Admin admin = (Admin)session.getAttribute("Admin");
		int sequence = admin.getOrganization().getSequence();
		String tableName = "jc_depart_"+sequence;
		
		depart.setId(CommonUtils.getUUID());
		int maxSequence = departManagerService.getMaxDepartNo(tableName)+1;
		depart.setDepartNo(maxSequence+"");
		depart.setNodePath(depart.getNodePath()+maxSequence+"|");
		depart.setIsleaf(true);
		int count = departManagerService.addDepart(tableName, depart);
		
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("updateDepart")
	public @ResponseBody Map<String,String> updateDepart(@ModelAttribute Depart depart,HttpServletRequest request){
		
		Map<String,String> map = new HashMap<String,String>();
		HttpSession session = request.getSession(true);
		
		Admin admin = (Admin)session.getAttribute("Admin");
		int sequence = admin.getOrganization().getSequence();
		String tableName = "jc_depart_"+sequence;
		
		int count = departManagerService.updateDepart(tableName, depart);
		
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("deleteDepart")
	public @ResponseBody Map<String,String> deleteDepart(@RequestParam("id") String id,HttpServletRequest request){
		
		Map<String,String> map = new HashMap<String,String>();
		
		HttpSession session = request.getSession(true);
		
		Admin admin = (Admin)session.getAttribute("Admin");
		int sequence = admin.getOrganization().getSequence();
		String tableName = "jc_depart_"+sequence;
		
		int count = departManagerService.deleteDepart(tableName, id);
		
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("checkDepartName")
	public @ResponseBody Map<String,String> checkDepartName(@RequestParam("name") String name,HttpServletRequest request){
		

		HttpSession session = request.getSession(true);
		
		Admin admin = (Admin)session.getAttribute("Admin");
		int sequence = admin.getOrganization().getSequence();
		String tableName = "jc_depart_"+sequence;
		
		Map<String,String> map = new HashMap<String,String>();
		if(departManagerService.checkDepartName(tableName, name)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
}
