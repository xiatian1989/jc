package com.rwkj.jc.dao;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.QuestionType;

public interface QuestionTypeDao {
    int deleteByPrimaryKey(@Param("tableName") String tableName,String id);

    int insert(@Param("tableName") String tableName,QuestionType record);

    int insertSelective(@Param("tableName") String tableName,QuestionType record);

    QuestionType selectByPrimaryKey(@Param("tableName") String tableName,String id);

    int updateByPrimaryKeySelective(@Param("tableName") String tableName,QuestionType record);

    int updateByPrimaryKey(@Param("tableName") String tableName,QuestionType record);
    
    int createNewTable(@Param("tableName") String tableName);
    
    int dropTable(@Param("tableName") String tableName);
    
    int existTable(String tableName);
}