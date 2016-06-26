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
	@InitBinder("admin")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("admin.");    
	}    
	
	@RequestMapping("adminList")
	public ModelAndView getAdminList(){
		
		ModelAndView modelAndView = new ModelAndView();
		List<Admin> adminList = adminService.getAdminList();
		modelAndView.addObject("adminList", adminList);
		modelAndView.setViewName("admin/index/adminList");
		return modelAndView;
	}
	
	@RequestMapping("addAdminBefore")
	public @ResponseBody ModelAndView addAdminBefore(){
		ModelAndView modelAndView = new ModelAndView();
		List<Organization> organizationList= adminService.getNoConnectedOrganizationList();
		modelAndView.addObject("organizationList", organizationList);
		modelAndView.addObject("result", "success");
		return modelAndView;
	}
	@RequestMapping("addAdmin")
	public ModelAndView addAdmin(@ModelAttribute Admin admin){
		ModelAndView modelAndView = new ModelAndView();
		admin.setId(CommonUtils.getUUID());
		String password = admin.getPassword();
		admin.setPassword(CommonUtils.getMD5Pssword(password));
		admin.setLevel(false);;
		adminService.addAdmin(admin);
		modelAndView.setViewName("admin/index/adminList");
		modelAndView.addObject("adminList", adminService.getAdminList());
		return modelAndView;
	}
	
	@RequestMapping("editAdminBefore")
	public@ResponseBody ModelAndView editAdminBefore(@RequestParam("id") String id){
		ModelAndView modelAndView = new ModelAndView();
		Admin admin = adminService.selectByPrimaryKey(id);
		modelAndView.addObject("username", admin.getUsername());
		modelAndView.addObject("status", admin.getStatus());
		modelAndView.addObject("id", admin.getId());
		List<Organization> organizationList= adminService.getNoConnectedOrganizationList();
		Organization organization = new Organization();
		if(organization != null) {
			organizationList.add(0, admin.getOrganization());
		}
		modelAndView.addObject("organizationList", organizationList);
		modelAndView.addObject("result", "success");
		return modelAndView;
	}
	
	@RequestMapping("updateAdmin")
	public ModelAndView updateAdmin(@ModelAttribute Admin admin){
		ModelAndView modelAndView = new ModelAndView();
		adminService.updateAdmin(admin);
		modelAndView.setViewName("admin/index/adminList");
		modelAndView.addObject("adminList", adminService.getAdminList());
		modelAndView.addObject("result", "success");
		return modelAndView;
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
