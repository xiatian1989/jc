package com.rwkj.jc.dao;

import java.util.List;

import com.rwkj.jc.domain.Organization;

public interface OrganizationDao {
	
    int deleteByPrimaryKey(String id);

    int insert(Organization record);

    int insertSelective(Organization record);

    List<Organization> getOrganizationList();
    
    Organization selectByPrimaryKey(String id);
    
    Organization selectByName(String name);

    int updateByPrimaryKeySelective(Organization record);

    int updateByPrimaryKey(Organization record);
}