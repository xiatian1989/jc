package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.Admin;

public interface AdminService {
	Admin getAdminByUserName(String username);
	int addAdmin(Admin admin);
	int updateAdmin(Admin admin);
	int deleteAdmin(String id);
	boolean checkAdminName(String name);
	Admin selectByPrimaryKey(String id);
	
	List<Admin> getAdmins(int pageIndex, int pageSize);
	List<Admin> getAdminsByUserName(String username,int pageIndex, int pageSize);
	int getAdminsCount();
	int getAdminsCountByUserName(String username);
}
