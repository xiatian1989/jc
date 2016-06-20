package com.rwkj.jc.dao;

import com.rwkj.jc.domain.Admin;

public interface AdminDao {
	
    int deleteByPrimaryKey(String id);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(String id);
    
    Admin selectByUserName(String username);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);
}