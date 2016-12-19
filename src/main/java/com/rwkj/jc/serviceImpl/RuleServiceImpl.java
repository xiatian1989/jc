package com.rwkj.jc.serviceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.RuleMapper;
import com.rwkj.jc.domain.Rule;
import com.rwkj.jc.service.RuleService;

@Service("RuleService")
public class RuleServiceImpl implements RuleService {

	@Resource
	private RuleMapper ruleDao;

	public int addRule(Rule rule) {
		return ruleDao.insertSelective(rule);
	}

	public int updateRule(Rule rule) {
		return ruleDao.updateByPrimaryKeySelective(rule);
	}

	public Rule getRuleById(String ruleId) {
		return ruleDao.selectByPrimaryKey(ruleId);
	}

}
