package com.rwkj.jc.dao;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.ResultDetail;

public interface ResultDetailDao {
    int deleteByPrimaryKey(@Param("tableName") String tableName,String id);

    int insert(@Param("tableName") String tableName,ResultDetail record);

    int insertSelective(@Param("tableName") String tableName,ResultDetail record);

    ResultDetail selectByPrimaryKey(@Param("tableName") String tableName,String id);

    int updateByPrimaryKeySelective(@Param("tableName") String tableName,ResultDetail record);

    int updateByPrimaryKey(@Param("tableName") String tableName,ResultDetail record);
    
    int createNewTable(@Param("tableName") String tableName);
    
    int dropTable(@Param("tableName") String tableName);
    
    int existTable(String tableName);
}