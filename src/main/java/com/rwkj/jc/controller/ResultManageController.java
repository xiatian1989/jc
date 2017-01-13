package com.rwkj.jc.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.rwkj.jc.domain.Depart;
import com.rwkj.jc.domain.PaperDetail;
import com.rwkj.jc.domain.Plan;
import com.rwkj.jc.domain.Relation;
import com.rwkj.jc.domain.Result;
import com.rwkj.jc.domain.User;
import com.rwkj.jc.service.DepartService;
import com.rwkj.jc.service.PaperDetailService;
import com.rwkj.jc.service.PlanService;
import com.rwkj.jc.service.RelationService;
import com.rwkj.jc.service.ResultService;
import com.rwkj.jc.service.UserService;

@Controller
public class ResultManageController {
	
	@Resource
	private RelationService relationService;
	@Resource
	private PaperDetailService paperDetailService;
	@Resource
	private DepartService departService;
	@Resource
	private ResultService resultService;
	@Resource
	private PlanService planService;
	@Resource
	private UserService userService;
	
	
	@RequestMapping("/admin/resultList")
	public @ResponseBody Object resultList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
        Map<String, Object> resultForPage = new HashMap<String, Object>(2) ;
        String column = request.getParameter("column");
		String value = request.getParameter("value");
		int total = 0;
		
		Plan plan = null;
		Depart depart = null;
		List<Result> results = null;
		List<Relation> relations = null;
		List<User> users = null;
		if(StringUtils.isEmpty(value)){
			results = resultService.getResults((page-1)*rows, rows);
			total = resultService.getResultsCount();
		}else{
			if("plan_id".equals(column) || "testPerson".equals(column) || "betestedobject".equals(column)) {
				if("plan_id".equals(column)) {
					plan = planService.getPlanByPlanTitle(value);
					if(plan != null) {
						relations = relationService.getRelationsByPlanId(plan.getId());
					}
				}else if("testPerson".equals(column)){
					users = userService.getUsersByUserName(value);
					if(!CollectionUtils.isEmpty(users)) {
						StringBuffer userNos = new StringBuffer();
						for(User user:users) {
							userNos.append(",");
							userNos.append("'");
							userNos.append(user.getUserno());
							userNos.append("'");
						}
						relations = relationService.getRelationsByUserNos(userNos.substring(1));
					}
				}else if("betestedobject".equals(column)){
					users = userService.getUsersByUserName(value);
					StringBuffer userNos = new StringBuffer();
					if(CollectionUtils.isEmpty(users)) {
						depart = departService.getDepartByDepartName(value);
						if(depart != null) {
							relations = relationService.getRelationsByBeTestedDepartNo(depart.getDepartNo());
						}
					}else{
						
						for(User user:users) {
							userNos.append(",");
							userNos.append("'");
							userNos.append(user.getUserno());
							userNos.append("'");
						}
						
						relations = relationService.getRelationsByBeTestedUserNos(userNos.substring(1));
					}
				}
				StringBuffer relationIds = new StringBuffer();
				for(Relation relation:relations) {
					relationIds.append(",");
					relationIds.append("'");
					relationIds.append(relation.getId());
					relationIds.append("'");
				}
				if(relationIds.length()>0) {
					results = resultService.getResultsByRelationIds(value, (page-1)*rows, rows);
					total = resultService.getResultsCountByRelationIds(value);
				}
			}else if("answerproportion".equals(column)){
				results = resultService.getResultsByRegion(column, value, (page-1)*rows, rows);
				total = resultService.getResultsCountByRegion(column, value);
			}else{
				results = resultService.getResultsByColumnValue(column, value,  (page-1)*rows, rows);
				total = resultService.getResultsCountByColumnValue(column, value);
			}
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(Result result:results){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",result.getId());
             jsonObject.put("plantitle", result.getRelation().getPlan().getPlantitle());
             jsonObject.put("relationId",result.getRelationId());
             jsonObject.put("testperson",result.getRelation().getTestUser().getTruename());
             jsonObject.put("betestedobject",result.getRelation().getIsperson()?result.getRelation().getBeTestedUser().getTruename():result.getRelation().getTestedDepart().getDepartName());
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
	
	@RequestMapping("/admin/ensabledResultByids")
	public @ResponseBody Map<String,String> ensabledResultByids(@RequestParam("ids") String ids){
		
		Map<String,String> map = new HashMap<String,String>();
		int count = resultService.ensabledResultByids(ids.substring(1));
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
			map.put("msg", "数据处理失败，请联系管理员！");
		}
		return map;
	}
	
	@RequestMapping("/admin/disabledResultByids")
	public @ResponseBody Map<String,String> disabledResultByids(@RequestParam("ids") String ids){
		
		Map<String,String> map = new HashMap<String,String>();
		int count = resultService.disabledResultByids(ids.substring(1));
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
			map.put("msg", "数据处理失败，请联系管理员！");
		}
		return map;
	}
	
	@RequestMapping("/admin/paperTestDetail")
	public ModelAndView paperListForPaper(HttpServletRequest request){
		String resultId = request.getParameter("resultId");
		Result result = resultService.getResultById(resultId);
		List<PaperDetail> paperDetails = paperDetailService.getPaperDetailsByPaperId(result.getRelation().getPaperId());
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("paperDetails", paperDetails);
		modelAndView.addObject("resultMessage", result.getResultmessage());
		modelAndView.addObject("extraMeassge", result.getExtrameassge());
		modelAndView.setViewName("admin/ResultManage/paperTestDetail");
		return modelAndView;
	}
}
