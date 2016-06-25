package com.rwkj.jc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.domain.Organization;
import com.rwkj.jc.service.AdminService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class AdminManagerController {
	
	@Resource
	private AdminService adminService;
	
	@InitBinder("organization")    
    public void initBinder1(WebDataBinder binder) {    
            binder.setFieldDefaultPrefix("organization.");    
    }    
	
	@RequestMapping("adminList")
	public ModelAndView getAdminList(){
		
		ModelAndView modelAndView = new ModelAndView();
		List<Admin> adminList = adminService.getAdminList();
		modelAndView.addObject("adminList", adminList);
		modelAndView.setViewName("admin/index/adminList");
		return modelAndView;
	}
	
	@RequestMapping("addAdmin")
	public @ResponseBody Map<String,String> addAdmin(@ModelAttribute Admin admin){
		Map<String,String> map = new HashMap<String,String>();
		admin.setId(CommonUtils.getUUID());
		String password = admin.getPassword();
		admin.setPassword(CommonUtils.getMD5Pssword(password));
		admin.setLevel(false);;
		int count = adminService.addAdmin(admin);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("updateAdmin")
	public@ResponseBody Map<String,String> updateAdminn(@ModelAttribute Admin admin){
		Map<String,String> map = new HashMap<String,String>();
		int count = adminService.updateAdmin(admin);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("deleteAdmin")
	public @ResponseBody Map<String,String> deleteAdmin(@RequestParam("id") String id){
		Map<String,String> map = new HashMap<String,String>();
		int count = adminService.deleteAdmin(id);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	
	@RequestMapping("checkAdminName")
	public @ResponseBody Map<String,String> checkAdminName(@RequestParam("name") String name){
		Map<String,String> map = new HashMap<String,String>();
		if(adminService.checkAdminName(name)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
	
	@RequestMapping("organizationList")
	public ModelAndView getOrganizationList(){
		
		ModelAndView modelAndView = new ModelAndView();
		List<Organization> organizationList = adminService.getOrganizationList();
		modelAndView.addObject("organizationList", organizationList);
		modelAndView.setViewName("admin/index/organizationList");
		return modelAndView;
	}
	
	
	@RequestMapping("addOrganization")
	public @ResponseBody Map<String,String> addOrganization(@ModelAttribute Organization organization){
		Map<String,String> map = new HashMap<String,String>();
		organization.setId(CommonUtils.getUUID());
		organization.setSequence(adminService.getMaxSequence()+1);
		int count = adminService.addOrganization(organization);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("updateOrganization")
	public@ResponseBody Map<String,String> updateOrganization(@ModelAttribute Organization organization){
		Map<String,String> map = new HashMap<String,String>();
		int count = adminService.updateOrganization(organization);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("deleteOrganization")
	public @ResponseBody Map<String,String> deleteOrganization(@RequestParam("id") String id){
		Map<String,String> map = new HashMap<String,String>();
		int count = adminService.deleteOrganization(id);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	
	@RequestMapping("checkOrganizationName")
	public @ResponseBody Map<String,String> checkOrganizationName(@RequestParam("name") String name){
		Map<String,String> map = new HashMap<String,String>();
		if(adminService.checkOrganizationName(name)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
}
