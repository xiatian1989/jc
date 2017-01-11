package com.rwkj.jc.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rwkj.jc.domain.PaperDetail;
import com.rwkj.jc.service.PaperDetailService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class PaperTestController {
	
	@Resource
	private PaperDetailService paperDetailService;
	
	
	@RequestMapping("addPaperDetail")
	public @ResponseBody Map<String,String> addPaperDetail(HttpServletRequest request,@ModelAttribute PaperDetail paperDetail){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		paperDetail.setId(CommonUtils.getUUID());
		HttpSession session = request.getSession(true);
		String paperId = (String)session.getAttribute("paperId");
		paperDetail.setPaperId(paperId);
		count = paperDetailService.addPaperDetail(paperDetail);
		
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
}
