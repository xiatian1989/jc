package com.rwkj.jc.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rwkj.jc.domain.Plan;
import com.rwkj.jc.domain.Relation;
import com.rwkj.jc.domain.User;
import com.rwkj.jc.service.PlanService;
import com.rwkj.jc.service.RelationService;

@Controller
public class PlanStatusForUserController {
	
	@Resource
	private PlanService planService;
	@Resource
	private RelationService relationService;
	
	@RequestMapping("/client/planStatus")
	public ModelAndView userLogout(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(true);
		String userNo = ((User)session.getAttribute("user")).getUserno();
		List<Relation> relations =  relationService.getRelationsByUserNo(userNo);
		Map<String, LinkedHashMap<String, String>> planStatus = new LinkedHashMap<String,LinkedHashMap<String,String>>();
		LinkedHashMap<String,String> userForRelations = null;
		Map<String,List<Relation>> planForRelations = new LinkedHashMap<String,List<Relation>>();
		List<Relation> tempRelations = null;
		String planTitle= "";
		for(Relation relation:relations) {
			Plan plan = relation.getPlan();
			if(!plan.getIsstart() || plan.getIsfinish()) {
				continue;
			}
			if(new Date().after(plan.getEndviewtime())){
				continue;
			}
			planTitle = plan.getPlantitle();
			if(planForRelations.containsKey(planTitle)){
				tempRelations = planForRelations.get(planTitle);
				tempRelations.add(relation);
				planForRelations.put(planTitle, tempRelations);
			}else{
				tempRelations = new ArrayList<Relation>();
				tempRelations.add(relation);
				planForRelations.put(planTitle, tempRelations);
			}
		}
		for(Entry<String, List<Relation>> entry:planForRelations.entrySet()) {
			userForRelations = new LinkedHashMap<String,String>();
			planTitle = entry.getKey();
			tempRelations = entry.getValue();
			long total = 0;
			long noTested = 0;
			long tested = 0;
			for(Relation relation:tempRelations) {
				total++;
				if(relation.getIsfinish()) {
					tested++;
				}else{
					noTested++;
				}
			}
			userForRelations.put("total", String.valueOf(total));
			userForRelations.put("tested", String.valueOf(tested));
			userForRelations.put("noTested", String.valueOf(noTested));
			planStatus.put(planTitle, userForRelations);
		}
		modelAndView.addObject("planStatus",planStatus);
		modelAndView.setViewName("client/main/planStatus");
		return modelAndView;
	}
}
