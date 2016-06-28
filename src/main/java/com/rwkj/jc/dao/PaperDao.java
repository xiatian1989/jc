package com.rwkj.jc.dao;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Paper;

public interface PaperDao {
	
    int deleteByPrimaryKey(@Param("tableName") String tableName,String id);

    int insert(@Param("tableName") String tableName,Paper record);

    int insertSelective(@Param("tableName") String tableName,Paper record);

    Paper selectByPrimaryKey(@Param("tableName") String tableName,String id);

    int updateByPrimaryKeySelective(@Param("tableName") String tableName,Paper record);

    int updateByPrimaryKey(@Param("tableName") String tableName,Paper record);
    
    int createNewTable(@Param("tableName") String tableName);
    
    int dropTable(@Param("tableName") String tableName);
    
    int existTable(String tableName);
}