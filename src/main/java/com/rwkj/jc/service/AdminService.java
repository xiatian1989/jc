package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.domain.Organization;

public interface AdminService {
	Admin getAdminByUserName(String username);
	List<Admin> getAdminList();
	List<Organization> getOrganizationList();
	int addOrganization(Organization organization);
	int updateOrganization(Organization organization);
	int deleteOrganization(String id);
	boolean checkOrganizationName(String name);
}
