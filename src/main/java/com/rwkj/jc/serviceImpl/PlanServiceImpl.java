package com.rwkj.jc.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.PlanMapper;
import com.rwkj.jc.domain.Plan;
import com.rwkj.jc.service.PlanService;

@Service("PlanService")
public class PlanServiceImpl implements PlanService {

	@Resource
	private PlanMapper planDao;

	public int addPlan(Plan plan) {
		return planDao.insertSelective(plan);
	}

	public int updatePlan(Plan plan) {
		return planDao.updateByPrimaryKeySelective(plan);
	}

	public int deletePlan(String id) {
		return planDao.deleteByPrimaryKey(id);
	}

	public boolean checkPlantitle(String planTitle) {
		Plan plan = planDao.getPlanByPlanTitle(planTitle);
		if(plan != null) {
			return true;
		}
		return false;
	}

	public List<Plan> getPlans(int pageIndex, int pageSize) {
		return planDao.getPlans(pageIndex, pageSize);
	}

	public List<Plan> getPlansByPlanTitle(String planTitle, int pageIndex, int pageSize) {
		return planDao.getPlansByPlanTitle(planTitle, pageIndex, pageSize);
	}

	public int getPlansCount() {
		return planDao.getPlansCount();
	}

	public int getPlansCountByPlanTitle(String planTitle) {
		return planDao.getPlansCountByPlanTitle(planTitle);
	}

	public Plan getPlanByPlanTitle(String planTitle) {
		return planDao.getPlanByPlanTitle(planTitle);
	}

	public List<Plan> getAllPlans() {
		return planDao.getAllPlans();
	}

	public List<Plan> getPlansForNoStart(int pageIndex, int pageSize) {
		return planDao.getPlansForNoStart(pageIndex, pageSize);
	}

	public int getPlansCountForNoStart() {
		return planDao.getPlansCountForNoStart();
	}

	public List<Plan> getPlansByPlanTitleForNoStart(String planTitle, int pageIndex, int pageSize) {
		return planDao.getPlansByPlanTitleForNoStart(planTitle, pageIndex, pageSize);
	}
	
	public List<Plan> getPlansByPlanTitleForFinish(String planTitle, int pageIndex, int pageSize) {
		return planDao.getPlansByPlanTitleForFinish(planTitle, pageIndex, pageSize);
	}

	public int getPlansCountByPlanTitleForNoStart(String planTitle) {
		return planDao.getPlansCountByPlanTitleForNoStart(planTitle);
	}
	
	public int getPlansCountByPlanTitleForFinish(String planTitle) {
		return planDao.getPlansCountByPlanTitleForFinish(planTitle);
	}

	public List<Plan> getPlansForFinish(int pageIndex, int pageSize) {
		return planDao.getPlansForFinish(pageIndex, pageSize);
	}

	public int getPlansCountForFinish() {
		return planDao.getPlansCountForFinish();
	}

	public Plan getPlanById(String id) {
		return planDao.selectByPrimaryKey(id);
	}
}
