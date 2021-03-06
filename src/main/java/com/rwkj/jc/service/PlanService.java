package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.Plan;

public interface PlanService {
	
	int addPlan(Plan plan);
	int updatePlan(Plan plan);
	int deletePlan(String id);
	boolean checkPlantitle(String planTitle);
	
	List<Plan> getPlans(int pageIndex, int pageSize);
	List<Plan> getPlansForNoStart(int pageIndex, int pageSize);
	List<Plan> getPlansForFinish(int pageIndex, int pageSize);
	List<Plan> getPlansByPlanTitle(String planTitle,int pageIndex, int pageSize);
	List<Plan> getPlansByPlanTitleForNoStart(String planTitle,int pageIndex, int pageSize);
	List<Plan> getPlansByPlanTitleForFinish(String planTitle,int pageIndex, int pageSize);
	int getPlansCount();
	int getPlansCountForNoStart();
	int getPlansCountForFinish();
	int getPlansCountByPlanTitle(String planTitle);
	int getPlansCountByPlanTitleForNoStart(String planTitle);
	int getPlansCountByPlanTitleForFinish(String planTitle);
	
	Plan getPlanByPlanTitle(String planTitle);
	
	List<Plan> getAllPlans();
	
	Plan getPlanById(String id);
}
