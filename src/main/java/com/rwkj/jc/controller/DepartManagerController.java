package com.rwkj.jc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;
import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.Bean.DepartBean;
import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.domain.Depart;
import com.rwkj.jc.domain.Organization;
import com.rwkj.jc.service.DepartManagerService;
import com.rwkj.jc.util.CommonUtils;
import com.rwkj.jc.util.Constant;

@Controller
public class DepartManagerController {
	
	@Resource
	private DepartManagerService departManagerService;
	
	@RequestMapping("departList")
	public ModelAndView getAdminList(HttpServletRequest request){
		
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
		PageInfo<DepartBean> page = departManagerService.getDeparts(tableName, pageNumInt, Constant.pagesize);
		modelAndView.addObject("page", page);
		modelAndView.setViewName("admin/depart/departList");
		return modelAndView;
	}
	
	@RequestMapping("departListtoJson")
	public@ResponseBody List<Depart> getAdminListToJson(HttpServletRequest request){
		
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
}
