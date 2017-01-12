package com.rwkj.jc.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.rwkj.jc.domain.Result;
import com.rwkj.jc.service.PaperDetailService;
import com.rwkj.jc.service.RelationService;
import com.rwkj.jc.service.ResultService;

@Controller
public class ResultManageController {
	
	@Resource
	private RelationService relationService;
	@Resource
	private PaperDetailService paperDetailService;
	@Resource
	private ResultService resultService;
	
	
	@RequestMapping("/admin/resultList")
	public @ResponseBody Object resultList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){{
            	
            }
        Map<String, Object> resultForPage = new HashMap<String, Object>(2) ;
        String column = request.getParameter("column");
		String value = request.getParameter("value");
		int total = 0;
		
		List<Result> results = null;
		if(StringUtils.isEmpty(value)){
			results = resultService.getResults((page-1)*rows, rows);
			total = resultService.getResultsCount();
		}else{
			results = resultService.getResultsByColumnValue(column, value, (page-1)*rows, rows);
			total = resultService.getResultsCountByColumnValue(column, value);
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(Result result:results){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",result.getId());
             jsonObject.put("planTitle", result.getRelation().getPlan().getPlantitle());
             jsonObject.put("relationId",result.getRelationId());
             jsonObject.put("testPeople",result.getRelation().getTestperson());
             jsonObject.put("beTestdObject",result.getRelation().getIsperson()?result.getRelation().getBetestedperson():result.getRelation().getBetesteddepart());
             jsonObject.put("answerproportion",result.getAnswerproportion());
             jsonObject.put("createtime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(result.getCreatetime()));
             jsonObject.put("status",result.getStatus());
             jsonObject.put("score",result.getScore());
             jsonArray.add(jsonObject) ;  
        }  
		resultForPage.put("total", total);  
		resultForPage.put("rows",jsonArray);
		return resultForPage;
	}
	
}
