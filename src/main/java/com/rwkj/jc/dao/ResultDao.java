package com.rwkj.jc.dao;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Result;

public interface ResultDao {
    int deleteByPrimaryKey(@Param("tableName") String tableName,String id);

    int insert(@Param("tableName") String tableName,Result record);

    int insertSelective(@Param("tableName") String tableName,Result record);

    Result selectByPrimaryKey(@Param("tableName") String tableName,String id);

    int updateByPrimaryKeySelective(@Param("tableName") String tableName,Result record);

    int updateByPrimaryKey(@Param("tableName") String tableName,Result record);
    
    int createNewTable(@Param("tableName") String tableName);
    
    int dropTable(@Param("tableName") String tableName);
    
    int existTable(String tableName);
}