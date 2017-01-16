package com.rwkj.jc.task;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import com.rwkj.jc.domain.Plan;
import com.rwkj.jc.service.PlanService;

@Component
public class PlanUpdateTask {
	@Resource
	private PlanService planService;
	
	@Scheduled(cron = "0/59 * * * * ? ") // 间隔一分钟执行
    public void taskCycle() {
        List<Plan> plans = planService.getAllPlans();
        Date date = new Date();
        if(!CollectionUtils.isEmpty(plans)) {
        	for(Plan plan:plans) {
        		if(date.after(plan.getBegintime()) && !plan.getIsstart()) {
        			plan.setIsstart(true);
        			planService.updatePlan(plan);
        		}
        		if(date.after(plan.getEndtime()) && !plan.getIsfinish()) {
        			plan.setIsfinish(true);
        			planService.updatePlan(plan);
        		}
        	}
        	
        }
    }
}
