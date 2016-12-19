package com.rwkj.jc.service;

import com.rwkj.jc.domain.Rule;

public interface RuleService {
	
	int addRule(Rule rule);
	int updateRule(Rule rule);
	Rule getRuleById(String ruleId);
}
