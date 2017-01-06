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
}
