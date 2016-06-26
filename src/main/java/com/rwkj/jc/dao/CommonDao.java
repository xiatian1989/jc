package com.rwkj.jc.dao;

import org.apache.ibatis.annotations.Param;

public interface CommonDao {
    int createNewTable(@Param("tableName") String tableName);
    int dropTable(@Param("tableName") String tableName);
    int existTable(String tableName);
}