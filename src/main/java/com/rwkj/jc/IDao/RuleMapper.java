package com.rwkj.jc.IDao;

import com.rwkj.jc.domain.Rule;

public interface RuleMapper {
    int deleteByPrimaryKey(String id);

    int insert(Rule record);

    int insertSelective(Rule record);

    Rule selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Rule record);

    int updateByPrimaryKey(Rule record);
}