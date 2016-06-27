package com.rwkj.jc.dao;

import com.rwkj.jc.domain.Result;

public interface ResultDao {
    int deleteByPrimaryKey(String id);

    int insert(Result record);

    int insertSelective(Result record);

    Result selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Result record);

    int updateByPrimaryKey(Result record);
}