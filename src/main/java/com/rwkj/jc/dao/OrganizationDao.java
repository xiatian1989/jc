package com.rwkj.jc.dao;

import com.rwkj.jc.domain.Organization;

public interface OrganizationDao {
	
    int deleteByPrimaryKey(String id);

    int insert(Organization record);

    int insertSelective(Organization record);

    Organization selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Organization record);

    int updateByPrimaryKey(Organization record);
}