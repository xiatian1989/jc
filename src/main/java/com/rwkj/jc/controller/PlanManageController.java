package com.rwkj.jc.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.domain.Plan;
import com.rwkj.jc.domain.Relation;
import com.rwkj.jc.domain.Result;
import com.rwkj.jc.service.PlanService;
import com.rwkj.jc.service.RelationService;
import com.rwkj.jc.service.ResultService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class PlanManageController {
	
	@Resource
	private PlanService planService;
	@Resource
	private RelationService relationService;
	@Resource
	private ResultService resultService;
	
	@InitBinder("plan")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("plan.");    
	}
	
	@InitBinder  
	public void initBinder(WebDataBinder binder) {  
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");  
		dateFormat.setLenient(false);  
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping("/admin/planList")
	public @ResponseBody Object getPlanList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		int total = 0;
		String param = request.getParameter("param");
		List<Plan> plans = null;
		if(StringUtils.isNullOrEmpty(param)){
			plans = planService.getPlans((page-1)*rows, rows);
			total = planService.getPlansCount();
		}else{
			plans = planService.getPlansByPlanTitle("%"+param+"%", (page-1)*rows, rows);
			total = planService.getPlansCountByPlanTitle("%"+param+"%");
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(Plan plan:plans){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",plan.getId());
             jsonObject.put("plantitle",plan.getPlantitle());
             jsonObject.put("begintime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(plan.getBegintime()));
             jsonObject.put("endtime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(plan.getEndtime()));
             jsonObject.put("isstart",plan.getIsstart());
             jsonObject.put("isfinish",plan.getIsfinish());
             jsonObject.put("createtime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(plan.getCreatetime()));
             jsonArray.add(jsonObject) ;  
        }  
		result.put("total", total);  
	    result.put("rows",jsonArray);
		return result;
	}
	@RequestMapping("/admin/planListForMakeSure")
	public @ResponseBody Object planListForMakeSure(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
			@RequestParam(required = false, defaultValue = "10") Integer rows){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		int total = 0;
		String param = request.getParameter("param");
		List<Plan> plans = null;
		if(StringUtils.isNullOrEmpty(param)){
			plans = planService.getPlansForFinish((page-1)*rows, rows);
			total = planService.getPlansCountForFinish();
		}else{
			plans = planService.getPlansByPlanTitleForFinish("%"+param+"%", (page-1)*rows, rows);
			total = planService.getPlansCountByPlanTitleForFinish("%"+param+"%");
		}
		
		JSONArray jsonArray = new JSONArray();  
		for(Plan plan:plans){  
			JSONObject jsonObject = new JSONObject();  
			jsonObject.put("id",plan.getId());
			jsonObject.put("plantitle",plan.getPlantitle());
			jsonObject.put("begintime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(plan.getBegintime()));
			jsonObject.put("endtime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(plan.getEndtime()));
			jsonObject.put("issure",plan.getIssure());
			jsonObject.put("isfinish",plan.getIsfinish());
			jsonObject.put("createtime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(plan.getCreatetime()));
			jsonArray.add(jsonObject) ;  
		}  
		result.put("total", total);  
		result.put("rows",jsonArray);
		return result;
	}
	
	@RequestMapping("/admin/planListForNoStart")
	public ModelAndView planListForNoStart(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
			@RequestParam(required = false, defaultValue = "10") Integer rows){
		String param = request.getParameter("param");
		List<Plan> plans = null;
		if(StringUtils.isNullOrEmpty(param)){
			plans = planService.getPlansForNoStart((page-1)*rows, rows);
		}else{
			plans = planService.getPlansByPlanTitleForNoStart("%"+param+"%", (page-1)*rows, rows);
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("plans",plans);
		modelAndView.setViewName("admin/EvaluationManage/planListForChoose");
		return modelAndView;
	}
	
	@RequestMapping("/admin/addPlan")
	public @ResponseBody Map<String,String> addPlan(@ModelAttribute Plan plan){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		plan.setId(CommonUtils.getUUID());
		plan.setCreatetime(new Date(System.currentTimeMillis()));
		plan.setIsfinish(false);
		plan.setIsstart(false);
		plan.setIssure(false);
		count = planService.addPlan(plan);
		
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
	@RequestMapping("/admin/updatePlan")
	public @ResponseBody Map<String,String> updatePlan(@ModelAttribute Plan plan){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		count = planService.updatePlan(plan);
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "更新失败");
		}
		return result;
	}
	
	@RequestMapping("/admin/makeSurePlan")
	public @ResponseBody Map<String,String> makeSurePlan(@ModelAttribute Plan plan){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		plan.setIssure(true);
		count = planService.updatePlan(plan);
		List<Relation> relations = relationService.getRelationsByPlanId(plan.getId());
		StringBuffer relationIds = new StringBuffer();
		for(Relation relation:relations) {
			relationIds.append(",");
			relationIds.append("'");
			relationIds.append(relation.getId());
			relationIds.append("'");
		}
		if(relationIds.length()>0){
			List<Result> results = resultService.getResultsByRelationIds("("+relationIds.substring(1)+")");
			for(Result tempResult:results) {
				tempResult.setIssure(true);
				resultService.updateResult(tempResult);
			}
		}
		
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "发布测评结果失败！");
		}
		return result;
	}
	
	@RequestMapping("/admin/deletePlan")
	public @ResponseBody Map<String,String> deletePlan(@RequestParam("id") String id){
		Map<String,String> map = new HashMap<String,String>();
		int count = planService.deletePlan(id);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("/admin/checkPlantitle")
	public @ResponseBody Map<String,String> checkPlantitle(@RequestParam("plantitle") String plantitle){
		Map<String,String> map = new HashMap<String,String>();
		if(planService.checkPlantitle(plantitle)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
}
