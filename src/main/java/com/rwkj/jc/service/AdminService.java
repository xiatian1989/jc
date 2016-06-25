package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.domain.Organization;

public interface AdminService {
	Admin getAdminByUserName(String username);
	List<Admin> getAdminList();
	int addAdmin(Admin admin);
	int updateAdmin(Admin admin);
	int deleteAdmin(String id);
	boolean checkAdminName(String name);
	List<Organization> getOrganizationList();
	int addOrganization(Organization organization);
	int updateOrganization(Organization organization);
	int deleteOrganization(String id);
	boolean checkOrganizationName(String name);
	int getMaxSequence();
}
