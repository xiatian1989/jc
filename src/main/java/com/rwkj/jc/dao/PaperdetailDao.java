package com.rwkj.jc.dao;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Paperdetail;

public interface PaperdetailDao {
    int deleteByPrimaryKey(@Param("tableName") String tableName,String id);

    int insert(@Param("tableName") String tableName,Paperdetail record);

    int insertSelective(@Param("tableName") String tableName,Paperdetail record);

    Paperdetail selectByPrimaryKey(@Param("tableName") String tableName,String id);

    int updateByPrimaryKeySelective(@Param("tableName") String tableName,Paperdetail record);

    int updateByPrimaryKeyWithBLOBs(@Param("tableName") String tableName,Paperdetail record);

    int updateByPrimaryKey(@Param("tableName") String tableName,Paperdetail record);
    
    int createNewTable(@Param("tableName") String tableName);
    
    int dropTable(@Param("tableName") String tableName);
    
    int existTable(String tableName);
}