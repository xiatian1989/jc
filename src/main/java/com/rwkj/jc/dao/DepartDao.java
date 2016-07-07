package com.rwkj.jc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Depart;

public interface DepartDao {
	
    int deleteByPrimaryKey(@Param("tableName") String tableName,@Param("id") String id);

    int insert(@Param("tableName") String tableName,@Param("depart") Depart depart);

    int insertSelective(@Param("tableName") String tableName,@Param("depart") Depart depart);

    Depart selectByPrimaryKey(@Param("tableName") String tableName,@Param("id") String id);
    
    Depart selectByname(@Param("tableName") String tableName,@Param("name") String name);
    
    List<Depart> getDeparts(@Param("tableName") String tableName);

    int updateByPrimaryKeySelective(@Param("tableName") String tableName,@Param("depart") Depart depart);
    
    int updateBydepartNo(@Param("tableName") String tableName,@Param("depart") Depart depart);

    int updateByPrimaryKey(@Param("tableName") String tableName,@Param("depart") Depart depart);
    
    int createNewTable(@Param("tableName") String tableName);
    
    int dropTable(@Param("tableName") String tableName);
    
    int existTable(String tableName);
    
    int getMaxDepartNo(@Param("tableName") String tableName);
    
    List<Depart> getSubDepartsByDepartNo(@Param("tableName") String tableName,@Param("departNo") String departNo);
}