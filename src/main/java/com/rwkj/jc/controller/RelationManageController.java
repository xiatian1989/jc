package com.rwkj.jc.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.domain.Depart;
import com.rwkj.jc.domain.Plan;
import com.rwkj.jc.domain.Relation;
import com.rwkj.jc.domain.User;
import com.rwkj.jc.service.DepartService;
import com.rwkj.jc.service.PlanService;
import com.rwkj.jc.service.RelationService;
import com.rwkj.jc.service.UserService;

@Controller
public class RelationManageController {
	
	@Resource
	private RelationService relationService;
	@Resource
	private PlanService planService;
	@Resource
	private UserService userService;
	@Resource
	private DepartService departService;
	
	
	@InitBinder("relation")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("relation.");    
	}    
	
	@RequestMapping("relationList")
	public @ResponseBody Object getRelationList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		int total = 0;
		Plan plan = null;
		List<User> users = null;
		Depart depart = null;
		String column= request.getParameter("column");
		String value = request.getParameter("value");
		List<Relation> relations = null;
		if(StringUtils.isNullOrEmpty(value)){
			relations = relationService.getRelations((page-1)*rows, rows);
			total = relationService.getRelationsCount();
		}else{
			if("plan_id".equals(column)) {
				plan = planService.getPlanByPlanTitle(value);
				if(plan == null){
					relations = new ArrayList<Relation>();
				}else{
					relations = relationService.getRelationsByColumnValue(column, plan.getId(), (page-1)*rows, rows);
					total = relationService.getRelationsCountByColumnValue(column,plan.getId());
				}
			}else if("testPerson".equals(column)){
				users = userService.getUsersByUserName(value);
				StringBuffer uerIds = new StringBuffer();
				if(CollectionUtils.isEmpty(users)) {
					depart = departService.getDepartByDepartName(value);
					if(depart == null) {
						relations = new ArrayList<Relation>();
					}else{
						relations = relationService.getRelationsByColumnValue(column, depart.getId(), (page-1)*rows, rows);
						total = relationService.getRelationsCountByColumnValue(column,depart.getId());
					}
				}else{
					for(User user:users){
						uerIds.append(",");
						uerIds.append(user.getId());
					}
					
					relations = relationService.getRelationsByColumnValueForNoSureValue(column, uerIds.substring(1), (page-1)*rows, rows);
					total = relationService.getRelationsCountByColumnValueForNoSureValue(column, uerIds.substring(1));
				}
			}else if("betestedobject".equals(column)){
				users = userService.getUsersByUserName(value);
				StringBuffer uerIds = new StringBuffer();
				if(CollectionUtils.isEmpty(users)) {
					relations = new ArrayList<Relation>();
				}else{
					for(User user:users){
						uerIds.append(",");
						uerIds.append(user.getId());
					}
					
					relations = relationService.getRelationsByColumnValueForNoSureValue(column, uerIds.substring(1), (page-1)*rows, rows);
					total = relationService.getRelationsCountByColumnValueForNoSureValue(column, uerIds.substring(1));
				}
			}else{
				relations = relationService.getRelationsByColumnValue(column, value, (page-1)*rows, rows);
				total = relationService.getRelationsCountByColumnValue(column, value);
			}
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(Relation relation:relations){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("plantitle",relation.getPlan().getPlantitle());
             jsonObject.put("testperson",relation.getTestUser().getTruename());
             if(relation.getIsperson()) {
            	 jsonObject.put("betestedobject",relation.getBeTestedUser().getTruename());
             }else{
            	 jsonObject.put("betestedobject",relation.getBeTestedDepart().getDepartName());
             }
             jsonObject.put("isperson",relation.getIsperson());
             jsonObject.put("isfinish",relation.getIsfinish());
             jsonObject.put("issupportsms",relation.getIssupportsms());
             jsonObject.put("createtime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(relation.getCreatetime()));
             jsonObject.put("ruleId",relation.getRuleId());
             jsonObject.put("paperId", relation.getPaperId());
             jsonArray.add(jsonObject) ;  
        }  
		result.put("total", total);  
	    result.put("rows",jsonArray);
		return result;
	}
	
	
	@RequestMapping("deleteRelation")
	public @ResponseBody Map<String,String> deleteRelation(@RequestParam("id") String id){
		
		Map<String,String> map = new HashMap<String,String>();
		int count = relationService.deleteRelation(id);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	 @RequestMapping("addRelations")  
	 public @ResponseBody Map<String,String> addRelations(HttpServletRequest request)  
    {
		 int count = 0;
		 Map<String,String> result = new HashMap<String,String>();
		 String paperId = request.getParameter("paperId");
		 String ruleId = request.getParameter("ruleId");
		 String testPeople = request.getParameter("testPeople");
		 String beTestObject = request.getParameter("beTestObject");
		 String isPerson = request.getParameter("isPerson");
		 Relation relation = null;
		 List<Plan> plans = planService.getPlans(1, 1);
		 if(CollectionUtils.isEmpty(plans)) {
			 	result.put("result", "failed");
				result.put("errorMsg", "请先添加计划！");
				return result;
		 }
		 try{
			 List<Relation> relations = new ArrayList<Relation>();
			 if("0".equals(isPerson)) {
				 relation = new Relation();
				 relation.setPlanId(plans.get(0).getId());
			 }
			 count = relationService.batchInsert(relations);
		 } catch (Exception e) {
			result.put("result", "failed");
			result.put("errorMsg", "导入发生异常，请联系管理员！");
			e.printStackTrace();
			return result;
		 }  
        //记录上传该文件后的时间  t
        result.put("result", "success");
        result.put("count", count+"");
        return result;  
    } 
}
