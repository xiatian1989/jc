package com.rwkj.jc.dao;

import com.rwkj.jc.domain.Plan;

public interface PlanDao {
    int deleteByPrimaryKey(String id);

    int insert(Plan record);

    int insertSelective(Plan record);

    Plan selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Plan record);

    int updateByPrimaryKey(Plan record);
}