package com.rwkj.jc.dao;

import java.util.List;

import com.rwkj.jc.domain.Admin;

public interface AdminDao {
	
	List<Admin> getAdmins();
	
    int deleteByPrimaryKey(String id);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(String id);
    
    Admin selectByUserName(String username);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);
}