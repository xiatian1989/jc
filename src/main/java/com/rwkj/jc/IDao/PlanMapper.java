package com.rwkj.jc.IDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Plan;

public interface PlanMapper {
    int deleteByPrimaryKey(String id);

    int insert(Plan record);

    int insertSelective(Plan record);

    Plan selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Plan record);

    int updateByPrimaryKey(Plan record);
    
    List<Plan> getPlans(@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    List<Plan> getPlansForNoStart(@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
	List<Plan> getPlansByPlanTitle(@Param("planTitle")String planTitle,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
	
	List<Plan> getPlansByPlanTitleForNoStart(@Param("planTitle")String planTitle,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
	
	int getPlansCount();
	
	int getPlansCountForNoStart();
	
	int getPlansCountByPlanTitle(@Param("planTitle")String planTitle);
	
	Plan getPlanByPlanTitle(String planTitle);
	
	int getPlansCountByPlanTitleForNoStart(@Param("planTitle")String planTitle);
	
	List<Plan> getAllPlans();
}