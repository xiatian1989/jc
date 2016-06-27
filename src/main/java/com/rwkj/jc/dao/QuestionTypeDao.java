package com.rwkj.jc.dao;

import com.rwkj.jc.domain.QuestionType;

public interface QuestionTypeDao {
    int deleteByPrimaryKey(String id);

    int insert(QuestionType record);

    int insertSelective(QuestionType record);

    QuestionType selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(QuestionType record);

    int updateByPrimaryKey(QuestionType record);
}