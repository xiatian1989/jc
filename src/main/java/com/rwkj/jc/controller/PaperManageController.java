package com.rwkj.jc.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
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
import com.rwkj.jc.domain.Paper;
import com.rwkj.jc.service.PaperService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class PaperManageController {
	
	@Resource
	private PaperService paperService;
	
	@InitBinder("paper")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("paper.");    
	}    
	
	@RequestMapping("paperList")
	public @ResponseBody Object getPaperList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		int total = 0;
		String column = request.getParameter("column");
		String value = request.getParameter("value");
		List<Paper> papers = null;
		if(StringUtils.isNullOrEmpty(value)){
			papers = paperService.getPapers((page-1)*rows, rows);
			total = paperService.getPapersCount();
		}else{
			value = "%"+value+"%";
			papers = paperService.getPapersByColumnValue(column, value, (page-1)*rows, rows);
			total = paperService.getPapersCountByColumnValue(column, value);
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(Paper paper:papers){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",paper.getId());
             jsonObject.put("papertitle",paper.getPapertitle());
             jsonObject.put("createtime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(paper.getCreatetime()));
             jsonObject.put("type",paper.getType());
             jsonObject.put("status",paper.getStatus());
             jsonArray.add(jsonObject) ;  
        }  
		result.put("total", total);  
	    result.put("rows",jsonArray);
		return result;
	}
	
	@RequestMapping("addPaper")
	public @ResponseBody Map<String,String> addPaper(@ModelAttribute Paper paper){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		paper.setId(CommonUtils.getUUID());
		paper.setCreatetime(new Date(System.currentTimeMillis()));
		count = paperService.addPaper(paper);
		
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
	@RequestMapping("updatePaper")
	public @ResponseBody Map<String,String> updatePaper(@ModelAttribute Paper paper){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		paper.setCreatetime(new Date(System.currentTimeMillis()));
		count = paperService.updatePaper(paper);
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "更新失败");
		}
		return result;
	}
	
	@RequestMapping("deletePaper")
	public @ResponseBody Map<String,String> deletePaper(@RequestParam("id") String id){
		Map<String,String> map = new HashMap<String,String>();
		id = id.substring(0,id.length()-1);
		int count = paperService.deletePapers("("+id+")");
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("checkPaperNameUnique")
	public @ResponseBody Map<String,String> checkPaperNameUnique(@RequestParam("name") String name){
		Map<String,String> map = new HashMap<String,String>();
		if(paperService.checkPaperName(name)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
	
}
