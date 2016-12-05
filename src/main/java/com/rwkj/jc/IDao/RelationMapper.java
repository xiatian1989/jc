package com.rwkj.jc.IDao;

import com.rwkj.jc.domain.Relation;

public interface RelationMapper {
    int deleteByPrimaryKey(String id);

    int insert(Relation record);

    int insertSelective(Relation record);

    Relation selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Relation record);

    int updateByPrimaryKey(Relation record);
}