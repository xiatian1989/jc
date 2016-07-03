package com.rwkj.jc.service;

import java.util.List;

import com.github.pagehelper.PageInfo;
import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.domain.Organization;

public interface AdminService {
	Admin getAdminByUserName(String username);
	PageInfo<Admin> getAdminList(Integer pageNo,Integer pageSize);
	int addAdmin(Admin admin);
	int updateAdmin(Admin admin);
	int deleteAdmin(String id);
	boolean checkAdminName(String name);
	PageInfo<Organization> getOrganizationList(Integer pageNo,Integer pageSize);
	List<Organization> getNoConnectedOrganizationList();
	int addOrganization(Organization organization);
	int updateOrganization(Organization organization);
	int deleteOrganization(String id);
	boolean checkOrganizationName(String name);
	int getMaxSequence();
	Admin selectByPrimaryKey(String id);
	boolean initOperationEnvironment(int sequence);
}
