package com.rwkj.jc.dao;

import com.rwkj.jc.domain.ResultDetail;

public interface ResultDetailDao {
    int deleteByPrimaryKey(String id);

    int insert(ResultDetail record);

    int insertSelective(ResultDetail record);

    ResultDetail selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ResultDetail record);

    int updateByPrimaryKey(ResultDetail record);
}