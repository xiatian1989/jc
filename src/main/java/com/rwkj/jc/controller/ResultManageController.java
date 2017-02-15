package com.rwkj.jc.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.write.WritableWorkbook;

import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.rwkj.jc.bean.ResultBean;
import com.rwkj.jc.domain.Depart;
import com.rwkj.jc.domain.Paper;
import com.rwkj.jc.domain.PaperDetail;
import com.rwkj.jc.domain.Plan;
import com.rwkj.jc.domain.Relation;
import com.rwkj.jc.domain.Result;
import com.rwkj.jc.domain.Rule;
import com.rwkj.jc.domain.User;
import com.rwkj.jc.service.DepartService;
import com.rwkj.jc.service.PaperDetailService;
import com.rwkj.jc.service.PlanService;
import com.rwkj.jc.service.RelationService;
import com.rwkj.jc.service.ResultService;
import com.rwkj.jc.service.UserService;
import com.rwkj.jc.util.ExcelUtil;

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
						relations = relationService.getRelationsByUserNos("("+userNos.substring(1)+")");
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
						
						relations = relationService.getRelationsByBeTestedUserNos("("+userNos.substring(1)+")");
					}
				}
				StringBuffer relationIds = new StringBuffer();
				if(CollectionUtils.isEmpty(relations)) {
					results = new ArrayList<Result>();
				}else{
					for(Relation relation:relations) {
						relationIds.append(",");
						relationIds.append("'");
						relationIds.append(relation.getId());
						relationIds.append("'");
					}
					results = resultService.getResultsByRelationIds("("+relationIds.substring(1)+")", (page-1)*rows, rows);
					total = resultService.getResultsCountByRelationIds("("+relationIds.substring(1)+")");
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
		int count = resultService.ensabledResultByids("("+ids.substring(1)+")");
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
		int count = resultService.disabledResultByids("("+ids.substring(1)+")");
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
			map.put("msg", "数据处理失败，请联系管理员！");
		}
		return map;
	}
	
	@RequestMapping("/admin/paperTestDetail")
	public ModelAndView paperTestDetail(HttpServletRequest request){
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
	
	@RequestMapping("/admin/resultSearch")
	public ModelAndView resultSearch(HttpServletRequest request) throws UnsupportedEncodingException{
		ModelAndView modelAndView = new ModelAndView();
		String userno = request.getParameter("userno");
		String truename = request.getParameter("truename");
		String departname = request.getParameter("departname");
		List<Relation> relations = new ArrayList<Relation>();
		List<Result> results = new ArrayList<Result>();
		List<Result> tempResults = null;
		List<Relation> tempRelations = null;
		List<Relation> tempRelations2 = null;
		if(!StringUtils.isEmpty(userno)) {
			tempRelations = relationService.getRelationsByBeTestedUserNo("'"+userno+"'");
			relations.addAll(tempRelations);
			modelAndView.addObject("userno", userno);
		}
		if(StringUtils.isEmpty(userno) && !StringUtils.isEmpty(truename)) {
			List<User> users = userService.getUsersByUserName(URLDecoder.decode(truename,"UTF-8"));
			modelAndView.addObject("truename", URLDecoder.decode(truename,"UTF-8"));
			if(!CollectionUtils.isEmpty(users)) {
				StringBuffer userNos = new StringBuffer();
				for(User user:users) {
					userNos.append(",");
					userNos.append("'");
					userNos.append(user.getUserno());
					userNos.append("'");
				}
				tempRelations = relationService.getRelationsByBeTestedUserNos("("+userNos.substring(1)+")");
				relations.addAll(tempRelations);
			}
		}else if(!StringUtils.isEmpty(userno) && !StringUtils.isEmpty(truename)) {
			Iterator<Relation> iterator = relations.iterator();
			while(iterator.hasNext()){
				if(!URLDecoder.decode(truename,"UTF-8").equals(iterator.next().getBeTestedUser().getTruename())) {
					iterator.remove();
				}
			}
		}
		if(!StringUtils.isEmpty(departname)) {
			Depart depart = departService.getDepartByDepartName(URLDecoder.decode(departname,"UTF-8"));
			tempRelations = relationService.getRelationsByBeTestedDepartNo(depart.getDepartNo());
			List<User> users = userService.getUsersByDepartNo(depart.getDepartNo());
			if(!CollectionUtils.isEmpty(users)) {
				StringBuffer userNos = new StringBuffer();
				for(User user:users) {
					userNos.append(",");
					userNos.append("'");
					userNos.append(user.getUserno());
					userNos.append("'");
				}
				tempRelations2 = relationService.getRelationsByBeTestedUserNos("("+userNos.substring(1)+")");
				relations.addAll(tempRelations2);
			}
			relations.addAll(tempRelations);
			modelAndView.addObject("departname", URLDecoder.decode(departname,"UTF-8"));
		}
		
		StringBuffer relationIds = new StringBuffer();
		if(CollectionUtils.isEmpty(relations)) {
			results = new ArrayList<Result>();
		}else{
			for(Relation relation:relations) {
				if(!relation.getPlan().getIssure()) {
					continue;
				}
				relationIds.append(",");
				relationIds.append("'");
				relationIds.append(relation.getId());
				relationIds.append("'");
			}
			if(relationIds.length()>0) {
				results = resultService.getResultsByRelationIds("("+relationIds.substring(1)+")");
			}else{
				results = new ArrayList<Result>();
			}
		}
		Map<String,Map<String,Map<String,LinkedHashMap<String,String>>>> map = new LinkedHashMap<String,Map<String,Map<String,LinkedHashMap<String,String>>>>();
		
		Map<String,List<Result>> mapForPlan = new LinkedHashMap<String,List<Result>>();
		for(Result result:results) {
			Relation relation = result.getRelation();
			String planTitle = relation.getPlan().getPlantitle();
			if(mapForPlan.containsKey(planTitle)) {
				tempResults = mapForPlan.get(planTitle);
				tempResults.add(result);
				mapForPlan.put(planTitle, tempResults);
			}else{
				tempResults = new ArrayList<Result>();
				tempResults.add(result);
				mapForPlan.put(planTitle, tempResults);
			}
		}
		
		Map<String,Map<String,List<Result>>> mapForPalnAndBeTestedObject = new LinkedHashMap<String,Map<String,List<Result>>>();
		Map<String,List<Result>> mapForBeTestedObject = null;
		
		for(Entry<String, List<Result>> entry: mapForPlan.entrySet()) {
			mapForBeTestedObject = new HashMap<String,List<Result>>();
			for(Result result:entry.getValue()) {
				Relation relation = result.getRelation();
				String key = "";
				if(relation.getIsperson()) {
					key = relation.getBeTestedUser().getTruename()+"("+relation.getBetestedperson()+")";
				}else{
					key = relation.getTestedDepart().getDepartName()+"("+relation.getBetesteddepart()+")";
				}
				if(mapForBeTestedObject.containsKey(key)) {
					tempResults = mapForBeTestedObject.get(key);
					tempResults.add(result);
					mapForBeTestedObject.put(key, tempResults);
				}else{
					tempResults = new ArrayList<Result>();
					tempResults.add(result);
					mapForBeTestedObject.put(key, tempResults);
				}
			}
			mapForPalnAndBeTestedObject.put(entry.getKey(), mapForBeTestedObject);
		}
		
		Map<String,List<Result>> mapForPaper = null;
		Map<String,Map<String,Map<String,List<Result>>>> mapForPalnAndBeTestedObjectAndPaper = new LinkedHashMap<String,Map<String,Map<String,List<Result>>>>();
		Map<String,Map<String,List<Result>>> mapForBeTestedObjectAndPaper = null;
		
		for(Entry<String, Map<String, List<Result>>> entry: mapForPalnAndBeTestedObject.entrySet()) {
			mapForBeTestedObjectAndPaper = new HashMap<String,Map<String,List<Result>>>();
			for(Entry<String, List<Result>> entryForBeTestedObject: entry.getValue().entrySet()) {
				mapForPaper = new HashMap<String,List<Result>>();
				for(Result result:entryForBeTestedObject.getValue()) {
					Relation relation = result.getRelation();
					String key = relation.getPaper().getPapertitle();
					if(mapForPaper.containsKey(key)) {
						tempResults = mapForPaper.get(key);
						tempResults.add(result);
						mapForPaper.put(key, tempResults);
					}else{
						tempResults = new ArrayList<Result>();
						tempResults.add(result);
						mapForPaper.put(key, tempResults);
					}
				}
				mapForBeTestedObjectAndPaper.put(entryForBeTestedObject.getKey(), mapForPaper);
			}
			mapForPalnAndBeTestedObjectAndPaper.put(entry.getKey(), mapForBeTestedObjectAndPaper);
		}
		
		LinkedHashMap<String,String> detail = null;
		Map<String, LinkedHashMap<String, String>> mapForPaperAndDetail = null;
		Map<String, Map<String, LinkedHashMap<String, String>>> mapForBeTestedObjectAndPaperAndDetail = null;
		
		for(Entry<String, Map<String, Map<String, List<Result>>>> entry: mapForPalnAndBeTestedObjectAndPaper.entrySet()){
			mapForBeTestedObjectAndPaperAndDetail = new HashMap<String,Map<String,LinkedHashMap<String,String>>>();
			for(Entry<String, Map<String, List<Result>>> entryForBeTestedObject:entry.getValue().entrySet()) {
				mapForPaperAndDetail = new HashMap<String,LinkedHashMap<String,String>>();
				for(Entry<String, List<Result>> entryForpaper:entryForBeTestedObject.getValue().entrySet()) {
					detail = new LinkedHashMap<String,String>();
					Paper paper = null;
					Rule rule = null;
					tempResults = entryForpaper.getValue();
					if(CollectionUtils.isEmpty(tempResults)) {
						continue;
					}else{
						paper= tempResults.get(0).getRelation().getPaper();
						rule = tempResults.get(0).getRelation().getRule();
					}
					List<PaperDetail> paperDetails = paperDetailService.getPaperDetailsByPaperId(paper.getId());
					if(paper.getType()) {
						StringBuffer extraMessage = null;
						int allScore = 0;
						int firstCount = 0;
						int secondCount = 0;
						int thirdCount = 0;
						int forthCount = 0;
						int fifthCount = 0;
						int allCount = 0;
						int firstLevlel = rule.getFirst();
						int secondLevel = rule.getSecond();
						int thirdLevel = rule.getThird();
						int forthLevel = rule.getForth()==null?0:rule.getForth();
						int fifthLevel = rule.getFifth()==null?0:rule.getFifth();
						String firstName = rule.getFirstname();
						String sencondName = rule.getSecondname();
						String thirdName = rule.getThirdname();
						String forthName = rule.getForthname()==null?"":rule.getForthname();
						String fifthName = rule.getFifthname()==null?"":rule.getFifthname();
						
						for(Result result:tempResults) {
							int score = result.getScore();
							allScore = allScore + score;
							allCount++;
							if(score>firstLevlel) {
								firstCount++;
							}else if(score>secondLevel){
								secondCount++;
							}else if(score>thirdLevel){
								thirdCount++;
							}else if(score>forthLevel){
								forthCount++;
							}else if(score>fifthLevel){
								fifthCount++;
							}
						}
						StringBuffer allMessage = new StringBuffer();
						double averageScore = (double)allScore/allCount;
						if(allCount>0){
							allMessage.append("总共"+allCount+"人做出评价,");
						}
						if(firstCount>0){
							allMessage.append("其中"+firstCount+"人评价:"+firstName+";");
						}
						if(secondCount>0){
							allMessage.append("其中"+secondCount+"人评价:"+sencondName+";");
						}
						if(thirdCount>0){
							allMessage.append("其中"+thirdCount+"人评价:"+thirdName+";");
						}
						if(forthCount>0){
							allMessage.append("其中"+forthCount+"人评价:"+forthName+";");
						}
						if(fifthCount>0){
							allMessage.append("其中"+fifthCount+"人评价:"+fifthName+";");
						}
						
						if(averageScore>(double)firstLevlel) {
							allMessage.append("综合评价:"+firstName+"("+averageScore+")");
						}else if(averageScore>(double)secondLevel){
							allMessage.append("综合评价:"+sencondName+"("+averageScore+")");
						}else if(averageScore>(double)thirdLevel){
							allMessage.append("综合评价:"+thirdName+"("+averageScore+")");
						}else if(averageScore>(double)forthLevel){
							allMessage.append("综合评价:"+forthName+"("+averageScore+")");
						}else if(averageScore>(double)fifthLevel){
							allMessage.append("综合评价:"+fifthName+"("+averageScore+")");
						}
						detail.put("总结：", allMessage.toString());
						for(PaperDetail paperDetail:paperDetails) {
							extraMessage = new StringBuffer("建议:");
							String questionno = String.valueOf(paperDetail.getQuestionno());
							for(Result result:tempResults) {
								String extramessage = result.getExtrameassge();
								if(extramessage != null && extramessage.contains(questionno)) {
									int beginIndex = extramessage.indexOf(questionno+":");
									extraMessage.append(extramessage.substring(beginIndex,extramessage.indexOf("#",beginIndex)));
									extraMessage.append(";");
								}
							}
							if(!"建议:".equals(extraMessage.toString())) {
								detail.put(questionno+":"+paperDetail.getQuestion(), extraMessage.toString());
							}
						}
					}else{
						int Aproportion = 0;
						int Bproportion = 0;
						int Cproportion = 0;
						int Dproportion = 0;
						int Eproportion = 0;
						int Fproportion = 0;
						StringBuffer extraMessage = null;
						int all = 0;
						
						for(PaperDetail paperDetail:paperDetails) {
							String questionno = String.valueOf(paperDetail.getQuestionno());
							Aproportion = 0;
							Bproportion = 0;
							Cproportion = 0;
							Dproportion = 0;
							Eproportion = 0;
							Fproportion = 0;
							extraMessage = new StringBuffer("建议:");
							all = 0;
							for(Result result:tempResults) {
								String resultmessage = result.getResultmessage();
								String extramessage = result.getExtrameassge();
								
								if(resultmessage.contains(questionno)) {
									all++;
								}
								if(resultmessage.contains(questionno+":A")) {
									Aproportion++;
								}
								if(resultmessage.contains(questionno+":B")) {
									Bproportion++;
								}
								if(resultmessage.contains(questionno+":C")) {
									Cproportion++;
								}
								if(resultmessage.contains(questionno+":D")) {
									Dproportion++;
								}
								if(resultmessage.contains(questionno+":E")) {
									Eproportion++;
								}
								if(resultmessage.contains(questionno+":F")) {
									Fproportion++;
								}
								if(extramessage != null && extramessage.contains(questionno)) {
									int beginIndex = extramessage.indexOf(questionno+":");
									extraMessage.append(extramessage.substring(beginIndex,extramessage.indexOf("#",beginIndex)));
									extraMessage.append(";");
								}
							}
							StringBuffer allMessage = new StringBuffer();
							if(all>0){
								allMessage.append("总共"+all+"人做出选择,");
							}
							if(Aproportion>0){
								allMessage.append("其中"+Aproportion+"人选择A:"+paperDetail.getOptiona()+";");
							}
							if(Bproportion>0){
								allMessage.append("其中"+Bproportion+"人选择B:"+paperDetail.getOptionb()+";");
							}
							if(Cproportion>0){
								allMessage.append("其中"+Cproportion+"人选择C:"+paperDetail.getOptionc()+";");
							}
							if(Dproportion>0){
								allMessage.append("其中"+Dproportion+"人选择D:"+paperDetail.getOptiond()+";");
							}
							if(Eproportion>0){
								allMessage.append("其中"+Eproportion+"人选择E:"+paperDetail.getOptione()+";");
							}
							if(Fproportion>0){
								allMessage.append("其中"+Fproportion+"人选择F:"+paperDetail.getOptionf()+";");
							}
							if(!"建议:".equals(extraMessage.toString())){
								allMessage.append(extraMessage);
							}
							detail.put(questionno+":"+paperDetail.getQuestion(), allMessage.toString());
						}
					}
					mapForPaperAndDetail.put(entryForpaper.getKey(), (LinkedHashMap<String, String>) detail);
				}
				mapForBeTestedObjectAndPaperAndDetail.put(entryForBeTestedObject.getKey(), mapForPaperAndDetail);
			}
			map.put(entry.getKey(), mapForBeTestedObjectAndPaperAndDetail);
		}
		
		modelAndView.addObject("map", map);
		modelAndView.addObject("search", "1");
		modelAndView.setViewName("admin/ResultManage/resultSearch");
		return modelAndView;
	}
	
	@RequestMapping("/client/resultSearchForSingle")
	public ModelAndView resultSearchForSingle(HttpServletRequest request) throws UnsupportedEncodingException{
		ModelAndView modelAndView = new ModelAndView();
		String userno = request.getParameter("userno");
		List<Relation> relations = new ArrayList<Relation>();
		List<Result> results = new ArrayList<Result>();
		List<Result> tempResults = null;
		List<Relation> tempRelations = null;
		if(!StringUtils.isEmpty(userno)) {
			tempRelations = relationService.getRelationsByBeTestedUserNo("'"+userno+"'");
			relations.addAll(tempRelations);
			modelAndView.addObject("userno", userno);
		}
		
		StringBuffer relationIds = new StringBuffer();
		if(CollectionUtils.isEmpty(relations)) {
			results = new ArrayList<Result>();
		}else{
			for(Relation relation:relations) {
				relationIds.append(",");
				relationIds.append("'");
				relationIds.append(relation.getId());
				relationIds.append("'");
			}
			results = resultService.getResultsByRelationIds("("+relationIds.substring(1)+")");
		}
		Map<String,Map<String,Map<String,LinkedHashMap<String,String>>>> map = new LinkedHashMap<String,Map<String,Map<String,LinkedHashMap<String,String>>>>();
		
		Map<String,List<Result>> mapForPlan = new LinkedHashMap<String,List<Result>>();
		for(Result result:results) {
			Relation relation = result.getRelation();
			String planTitle = relation.getPlan().getPlantitle();
			if(mapForPlan.containsKey(planTitle)) {
				tempResults = mapForPlan.get(planTitle);
				tempResults.add(result);
				mapForPlan.put(planTitle, tempResults);
			}else{
				tempResults = new ArrayList<Result>();
				tempResults.add(result);
				mapForPlan.put(planTitle, tempResults);
			}
		}
		
		Map<String,Map<String,List<Result>>> mapForPalnAndBeTestedObject = new LinkedHashMap<String,Map<String,List<Result>>>();
		Map<String,List<Result>> mapForBeTestedObject = null;
		
		for(Entry<String, List<Result>> entry: mapForPlan.entrySet()) {
			mapForBeTestedObject = new HashMap<String,List<Result>>();
			for(Result result:entry.getValue()) {
				Relation relation = result.getRelation();
				String key = "";
				if(relation.getIsperson()) {
					key = relation.getBeTestedUser().getTruename()+"("+relation.getBetestedperson()+")";
				}else{
					key = relation.getTestedDepart().getDepartName()+"("+relation.getBetesteddepart()+")";
				}
				if(mapForBeTestedObject.containsKey(key)) {
					tempResults = mapForBeTestedObject.get(key);
					tempResults.add(result);
					mapForBeTestedObject.put(key, tempResults);
				}else{
					tempResults = new ArrayList<Result>();
					tempResults.add(result);
					mapForBeTestedObject.put(key, tempResults);
				}
			}
			mapForPalnAndBeTestedObject.put(entry.getKey(), mapForBeTestedObject);
		}
		
		Map<String,List<Result>> mapForPaper = null;
		Map<String,Map<String,Map<String,List<Result>>>> mapForPalnAndBeTestedObjectAndPaper = new LinkedHashMap<String,Map<String,Map<String,List<Result>>>>();
		Map<String,Map<String,List<Result>>> mapForBeTestedObjectAndPaper = null;
		
		for(Entry<String, Map<String, List<Result>>> entry: mapForPalnAndBeTestedObject.entrySet()) {
			mapForBeTestedObjectAndPaper = new HashMap<String,Map<String,List<Result>>>();
			for(Entry<String, List<Result>> entryForBeTestedObject: entry.getValue().entrySet()) {
				mapForPaper = new HashMap<String,List<Result>>();
				for(Result result:entryForBeTestedObject.getValue()) {
					Relation relation = result.getRelation();
					String key = relation.getPaper().getPapertitle();
					if(mapForPaper.containsKey(key)) {
						tempResults = mapForPaper.get(key);
						tempResults.add(result);
						mapForPaper.put(key, tempResults);
					}else{
						tempResults = new ArrayList<Result>();
						tempResults.add(result);
						mapForPaper.put(key, tempResults);
					}
				}
				mapForBeTestedObjectAndPaper.put(entryForBeTestedObject.getKey(), mapForPaper);
			}
			mapForPalnAndBeTestedObjectAndPaper.put(entry.getKey(), mapForBeTestedObjectAndPaper);
		}
		
		LinkedHashMap<String,String> detail = null;
		Map<String, LinkedHashMap<String, String>> mapForPaperAndDetail = null;
		Map<String, Map<String, LinkedHashMap<String, String>>> mapForBeTestedObjectAndPaperAndDetail = null;
		
		for(Entry<String, Map<String, Map<String, List<Result>>>> entry: mapForPalnAndBeTestedObjectAndPaper.entrySet()){
			mapForBeTestedObjectAndPaperAndDetail = new HashMap<String,Map<String,LinkedHashMap<String,String>>>();
			for(Entry<String, Map<String, List<Result>>> entryForBeTestedObject:entry.getValue().entrySet()) {
				mapForPaperAndDetail = new HashMap<String,LinkedHashMap<String,String>>();
				for(Entry<String, List<Result>> entryForpaper:entryForBeTestedObject.getValue().entrySet()) {
					detail = new LinkedHashMap<String,String>();
					Paper paper = null;
					Rule rule = null;
					tempResults = entryForpaper.getValue();
					if(CollectionUtils.isEmpty(tempResults)) {
						continue;
					}else{
						paper= tempResults.get(0).getRelation().getPaper();
						rule = tempResults.get(0).getRelation().getRule();
					}
					List<PaperDetail> paperDetails = paperDetailService.getPaperDetailsByPaperId(paper.getId());
					if(paper.getType()) {
						StringBuffer extraMessage = null;
						int allScore = 0;
						int firstCount = 0;
						int secondCount = 0;
						int thirdCount = 0;
						int forthCount = 0;
						int fifthCount = 0;
						int allCount = 0;
						int firstLevlel = rule.getFirst();
						int secondLevel = rule.getSecond();
						int thirdLevel = rule.getThird();
						int forthLevel = rule.getForth()==null?0:rule.getForth();
						int fifthLevel = rule.getFifth()==null?0:rule.getFifth();
						String firstName = rule.getFirstname();
						String sencondName = rule.getSecondname();
						String thirdName = rule.getThirdname();
						String forthName = rule.getForthname()==null?"":rule.getForthname();
						String fifthName = rule.getFifthname()==null?"":rule.getFifthname();
						
						for(Result result:tempResults) {
							int score = result.getScore();
							allScore = allScore + score;
							allCount++;
							if(score>firstLevlel) {
								firstCount++;
							}else if(score>secondLevel){
								secondCount++;
							}else if(score>thirdLevel){
								thirdCount++;
							}else if(score>forthLevel){
								forthCount++;
							}else if(score>fifthLevel){
								fifthCount++;
							}
						}
						StringBuffer allMessage = new StringBuffer();
						double averageScore = (double)allScore/allCount;
						if(allCount>0){
							allMessage.append("总共"+allCount+"人做出评价,");
						}
						if(firstCount>0){
							allMessage.append("其中"+firstCount+"人评价:"+firstName+";");
						}
						if(secondCount>0){
							allMessage.append("其中"+secondCount+"人评价:"+sencondName+";");
						}
						if(thirdCount>0){
							allMessage.append("其中"+thirdCount+"人评价:"+thirdName+";");
						}
						if(forthCount>0){
							allMessage.append("其中"+forthCount+"人评价:"+forthName+";");
						}
						if(fifthCount>0){
							allMessage.append("其中"+fifthCount+"人评价:"+fifthName+";");
						}
						
						if(averageScore>(double)firstLevlel) {
							allMessage.append("综合评价:"+firstName+"("+averageScore+")");
						}else if(averageScore>(double)secondLevel){
							allMessage.append("综合评价:"+sencondName+"("+averageScore+")");
						}else if(averageScore>(double)thirdLevel){
							allMessage.append("综合评价:"+thirdName+"("+averageScore+")");
						}else if(averageScore>(double)forthLevel){
							allMessage.append("综合评价:"+forthName+"("+averageScore+")");
						}else if(averageScore>(double)fifthLevel){
							allMessage.append("综合评价:"+fifthName+"("+averageScore+")");
						}
						detail.put("总结：", allMessage.toString());
						for(PaperDetail paperDetail:paperDetails) {
							extraMessage = new StringBuffer("建议:");
							String questionno = String.valueOf(paperDetail.getQuestionno());
							for(Result result:tempResults) {
								String extramessage = result.getExtrameassge();
								if(extramessage != null && extramessage.contains(questionno)) {
									int beginIndex = extramessage.indexOf(questionno+":");
									extraMessage.append(extramessage.substring(beginIndex,extramessage.indexOf("#",beginIndex)));
									extraMessage.append(";");
								}
							}
							if(!"建议:".equals(extraMessage.toString())) {
								detail.put(questionno+":"+paperDetail.getQuestion(), extraMessage.toString());
							}
						}
					}
					mapForPaperAndDetail.put(entryForpaper.getKey(), (LinkedHashMap<String, String>) detail);
				}
				mapForBeTestedObjectAndPaperAndDetail.put(entryForBeTestedObject.getKey(), mapForPaperAndDetail);
			}
			map.put(entry.getKey(), mapForBeTestedObjectAndPaperAndDetail);
		}
		
		modelAndView.addObject("map", map);
		modelAndView.addObject("search", "1");
		modelAndView.setViewName("client/main/resultSearchForSingle");
		return modelAndView;
	}
	
	@RequestMapping("/admin/allPlanStatus")
	public ModelAndView allPlanStatus(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		Map<String,LinkedHashMap<String,Object>> map = new HashMap<String,LinkedHashMap<String,Object>>();
		List<Plan> plans = planService.getAllPlans();
		List<Relation> relations = relationService.getAllRelations();
		LinkedHashMap<String,Object> mapForAnalysis = null;
		int allCount;
		int enableCount;
		int useCount;
		int notUseCount;
		for(Plan plan:plans) {
			if(plan.getIssure()){
				continue;
			}
			String key = plan.getPlantitle();
			mapForAnalysis = new LinkedHashMap<String,Object>();
			allCount = 0;
			enableCount = 0;
			useCount = 0;
			notUseCount = 0;
			for(Relation relation:relations) {
				if(key.equals(relation.getPlan().getPlantitle())) {
					allCount++;
					if(relation.getStatus()){
						enableCount++;
						if(relation.getIsfinish()) {
							useCount++;
						}else{
							notUseCount++;
						}
					}
				}
			}
			mapForAnalysis.put("plan", plan);
			mapForAnalysis.put("allCount", "总共建立了"+allCount+"对测评关系");
			mapForAnalysis.put("enableCount", "存在"+enableCount+"对有效测评关系");
			mapForAnalysis.put("useCount", "完成了"+useCount+"对测评关系");
			mapForAnalysis.put("notUseCount", "还有"+notUseCount+"对测评关系需要完成");
			
			map.put(key, mapForAnalysis);
		}
		
		modelAndView.addObject("map", map);
		modelAndView.setViewName("admin/ResultManage/planStatus");
		return modelAndView;
	}
	
	@RequestMapping("/admin/initResultExportSearch")
	public ModelAndView initResultExportSearch(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		List<Plan> plans = planService.getAllPlans();
		Iterator<Plan> iterator = plans.iterator();
		while(iterator.hasNext()) {
			Plan plan = iterator.next();
			if(!plan.getIssure()) {
				iterator.remove();
			}
		}
		modelAndView.addObject("plans", plans);
		modelAndView.setViewName("admin/ResultManage/resultExportSearch");
		return modelAndView;
	}
	
	@RequestMapping("/admin/resultListForExport")
	public @ResponseBody Object resultListForExport(HttpServletRequest request,
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
        Map<String, Object> resultForPage = new HashMap<String, Object>(2) ;
		String planId = request.getParameter("planId");
		List<Result> results = null;
		List<ResultBean> resultBeans = new ArrayList<ResultBean>();
		List<Relation> relations = null;
		relations = relationService.getRelationsByPlanId(planId);
		StringBuffer relationIds = new StringBuffer();
		if(CollectionUtils.isEmpty(relations)) {
			results = new ArrayList<Result>();
		}else{
			for(Relation relation:relations) {
				relationIds.append(",");
				relationIds.append("'");
				relationIds.append(relation.getId());
				relationIds.append("'");
			}
			results = resultService.getResultsByRelationIds("("+relationIds.substring(1)+")");
		}
		Map<String,List<Result>> mapForPlan = new TreeMap<String,List<Result>>();
		List<Result> tempResults = null;
		for(Result result:results){  
			String key = "";
			if(result.getRelation().getIsperson()){
				key = result.getRelation().getBetestedperson();
			}else{
				key = result.getRelation().getBetesteddepart();
			}
			if(mapForPlan.containsKey(key)) {
				tempResults = mapForPlan.get(key);
				tempResults.add(result);
				mapForPlan.put(key, tempResults);
			}else{
				tempResults = new ArrayList<Result>();
				tempResults.add(result);
				mapForPlan.put(key, tempResults);
			}
		}
		ResultBean rsultBean = null;
		TreeMap<String,List<Result>> mapForPaper = null;
		Map<String,TreeMap<String,List<Result>>> resultmap = new TreeMap<String,TreeMap<String,List<Result>>>();
		for(Entry<String, List<Result>> entry:mapForPlan.entrySet()) {
			mapForPaper = new TreeMap<String,List<Result>>();
			for(Result result:entry.getValue()){ 
				String key = result.getRelation().getPaper().getPapertitle();
				if(!result.getRelation().getPaper().getType()){
					continue;
				}
				if(mapForPaper.containsKey(key)) {
					tempResults = mapForPaper.get(key);
					tempResults.add(result);
					mapForPaper.put(key, tempResults);
				}else{
					tempResults = new ArrayList<Result>();
					tempResults.add(result);
					mapForPaper.put(key, tempResults);
				}
			}
			resultmap.put(entry.getKey(), mapForPaper);
		}
		for(Entry<String,TreeMap<String,List<Result>>> entry:resultmap.entrySet()) {
			for(Entry<String, List<Result>> entryForResultBean:entry.getValue().entrySet()) {
				rsultBean = new ResultBean();
				tempResults = entryForResultBean.getValue();
				Relation relation = tempResults.get(0).getRelation();
				Rule rule = relation.getRule();
				int firstLevlel = rule.getFirst();
				int secondLevel = rule.getSecond();
				int thirdLevel = rule.getThird();
				int forthLevel = rule.getForth()==null?0:rule.getForth();
				int fifthLevel = rule.getFifth()==null?0:rule.getFifth();
				String firstName = rule.getFirstname();
				String sencondName = rule.getSecondname();
				String thirdName = rule.getThirdname();
				String forthName = rule.getForthname()==null?"":rule.getForthname();
				String fifthName = rule.getFifthname()==null?"":rule.getFifthname();
				int allScore = 0;
				int allCount = 0;
				for(Result result:tempResults){ 
					allScore =allScore +result.getScore();
					allCount++;
				}
				double averageScore = (double)allScore/allCount;
				rsultBean.setScore(averageScore);
				if(averageScore>(double)firstLevlel) {
					rsultBean.setResult(firstName);
				}else if(averageScore>(double)secondLevel){
					rsultBean.setResult(sencondName);
				}else if(averageScore>(double)thirdLevel){
					rsultBean.setResult(thirdName);
				}else if(averageScore>(double)forthLevel){
					rsultBean.setResult(forthName);
				}else if(averageScore>(double)fifthLevel){
					rsultBean.setResult(fifthName);
				}
				rsultBean.setPlanTitle(relation.getPlan().getPlantitle());
				rsultBean.setPaperTitle(entryForResultBean.getKey());
				rsultBean.setBeTestedObject(relation.getIsperson()?relation.getBeTestedUser().getTruename():relation.getTestedDepart().getDepartName());
				resultBeans.add(rsultBean);
			}
		}
		JSONArray jsonArray = new JSONArray();
        for(ResultBean resultBean:resultBeans.subList((page-1)*rows, rows<resultBeans.size()?rows:resultBeans.size())){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("plantitle", resultBean.getPlanTitle());
             jsonObject.put("papertitle", resultBean.getPaperTitle());
             jsonObject.put("betestedobject",resultBean.getBeTestedObject());
             jsonObject.put("score",resultBean.getScore());
             jsonObject.put("result",resultBean.getResult());
             jsonArray.add(jsonObject) ;  
        }  
		resultForPage.put("total", resultBeans.size());  
		resultForPage.put("rows",jsonArray);
		return resultForPage;
	}
	
	@RequestMapping("/admin/exportExcelForResult")
	public void exportExcelForResult(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String fileName = "测评结果表";
		String planId = request.getParameter("planId");
		List<Result> results = null;
		List<ResultBean> resultBeans = new ArrayList<ResultBean>();
		List<Relation> relations = null;
		relations = relationService.getRelationsByPlanId(planId);
		StringBuffer relationIds = new StringBuffer();
		if(CollectionUtils.isEmpty(relations)) {
			results = new ArrayList<Result>();
		}else{
			for(Relation relation:relations) {
				relationIds.append(",");
				relationIds.append("'");
				relationIds.append(relation.getId());
				relationIds.append("'");
			}
			results = resultService.getResultsByRelationIds("("+relationIds.substring(1)+")");
		}
		Map<String,List<Result>> mapForPlan = new TreeMap<String,List<Result>>();
		List<Result> tempResults = null;
		for(Result result:results){  
			String key = "";
			if(result.getRelation().getIsperson()){
				key = result.getRelation().getBetestedperson();
			}else{
				key = result.getRelation().getBetesteddepart();
			}
			if(mapForPlan.containsKey(key)) {
				tempResults = mapForPlan.get(key);
				tempResults.add(result);
				mapForPlan.put(key, tempResults);
			}else{
				tempResults = new ArrayList<Result>();
				tempResults.add(result);
				mapForPlan.put(key, tempResults);
			}
		}
		ResultBean rsultBean = null;
		TreeMap<String,List<Result>> mapForPaper = null;
		Map<String,TreeMap<String,List<Result>>> resultmap = new TreeMap<String,TreeMap<String,List<Result>>>();
		for(Entry<String, List<Result>> entry:mapForPlan.entrySet()) {
			mapForPaper = new TreeMap<String,List<Result>>();
			for(Result result:entry.getValue()){ 
				String key = result.getRelation().getPaper().getPapertitle();
				if(!result.getRelation().getPaper().getType()){
					continue;
				}
				if(mapForPaper.containsKey(key)) {
					tempResults = mapForPaper.get(key);
					tempResults.add(result);
					mapForPaper.put(key, tempResults);
				}else{
					tempResults = new ArrayList<Result>();
					tempResults.add(result);
					mapForPaper.put(key, tempResults);
				}
			}
			resultmap.put(entry.getKey(), mapForPaper);
		}
		for(Entry<String,TreeMap<String,List<Result>>> entry:resultmap.entrySet()) {
			for(Entry<String, List<Result>> entryForResultBean:entry.getValue().entrySet()) {
				rsultBean = new ResultBean();
				tempResults = entryForResultBean.getValue();
				Relation relation = tempResults.get(0).getRelation();
				Rule rule = relation.getRule();
				int firstLevlel = rule.getFirst();
				int secondLevel = rule.getSecond();
				int thirdLevel = rule.getThird();
				int forthLevel = rule.getForth()==null?0:rule.getForth();
				int fifthLevel = rule.getFifth()==null?0:rule.getFifth();
				String firstName = rule.getFirstname();
				String sencondName = rule.getSecondname();
				String thirdName = rule.getThirdname();
				String forthName = rule.getForthname()==null?"":rule.getForthname();
				String fifthName = rule.getFifthname()==null?"":rule.getFifthname();
				int allScore = 0;
				int allCount = 0;
				for(Result result:tempResults){ 
					allScore =allScore +result.getScore();
					allCount++;
				}
				double averageScore = (double)allScore/allCount;
				rsultBean.setScore(averageScore);
				if(averageScore>(double)firstLevlel) {
					rsultBean.setResult(firstName);
				}else if(averageScore>(double)secondLevel){
					rsultBean.setResult(sencondName);
				}else if(averageScore>(double)thirdLevel){
					rsultBean.setResult(thirdName);
				}else if(averageScore>(double)forthLevel){
					rsultBean.setResult(forthName);
				}else if(averageScore>(double)fifthLevel){
					rsultBean.setResult(fifthName);
				}
				rsultBean.setPlanTitle(relation.getPlan().getPlantitle());
				rsultBean.setPaperTitle(entryForResultBean.getKey());
				rsultBean.setBeTestedObject(relation.getIsperson()?relation.getBeTestedUser().getTruename():relation.getTestedDepart().getDepartName());
				resultBeans.add(rsultBean);
			}
		}
		ExcelUtil<ResultBean> excelUtil = new ExcelUtil<ResultBean>(ResultBean.class);
		List<Map<String,Object>> list = excelUtil.createExcelRecord(resultBeans, "人员信息一览");
		
		String columnNames[]={"测评计划名称","测评试卷名称","被测评对象","平均得分","综合评价"};//列名
		String keys[]={"planTitle","paperTitle","beTestedObject","score","result"};//map中的key
		
		ServletOutputStream out = response.getOutputStream();

		// 设置response参数，可以打开下载页面
        response.reset();
        response.setContentType("application/vnd.ms-excel;charset=utf-8");
		response.addHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("gbk"),"iso-8859-1")+".xls");
		WritableWorkbook workbook = excelUtil.createWorkBook(list, keys, columnNames, out);
		workbook.write();   
        workbook.close();   
        out.close();  
	}
}
