package com.rwkj.jc.IDao;

import com.rwkj.jc.domain.Result;

public interface ResultMapper {
    int deleteByPrimaryKey(String id);

    int insert(Result record);

    int insertSelective(Result record);

    Result selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Result record);

    int updateByPrimaryKey(Result record);
}