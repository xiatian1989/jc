package com.rwkj.jc.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;
import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.Bean.DepartBean;
import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.service.DepartManagerService;
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
		modelAndView.setViewName("admin/index/departList");
		return modelAndView;
	}
}
