package com.rwkj.jc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Depart;

public interface DepartDao {
	
    int deleteByPrimaryKey(@Param("tableName") String tableName,String id);

    int insert(@Param("tableName") String tableName,Depart record);

    int insertSelective(@Param("tableName") String tableName,Depart record);

    Depart selectByPrimaryKey(@Param("tableName") String tableName,String id);
    
    Depart selectByname(@Param("tableName") String tableName,String name);
    
    List<Depart> getDeparts(@Param("tableName") String tableName);

    int updateByPrimaryKeySelective(@Param("tableName") String tableName,Depart record);

    int updateByPrimaryKey(@Param("tableName") String tableName,Depart record);
    
    int createNewTable(@Param("tableName") String tableName);
    
    int dropTable(@Param("tableName") String tableName);
    
    int existTable(String tableName);
    
    int getMaxDepartNo(String tableName);
}