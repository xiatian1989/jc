package com.rwkj.jc.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.rwkj.jc.dao.AdminDao;
import com.rwkj.jc.dao.OrganizationDao;
import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.domain.Organization;
import com.rwkj.jc.service.AdminService;

@Service("AdminService")
public class AdminServiceImpl implements AdminService {

	@Resource
	private AdminDao adminDao;
	@Resource
	private OrganizationDao organizationDao;
	
	public Admin getAdminByUserName(String username) {
		return adminDao.selectByUserName(username);
	}

	public List<Admin> getAdminList() {
		return adminDao.getAdmins();
	}

	public int addAdmin(Admin admin) {
		return adminDao.insert(admin);
	}

	public int updateAdmin(Admin admin) {
		return adminDao.updateByPrimaryKeySelective(admin);
	}

	public int deleteAdmin(String id) {
		return adminDao.deleteByPrimaryKey(id);
	}

	public boolean checkAdminName(String name) {
		if(adminDao.selectByUserName(name) != null) {
			return true;
		}
		return false;
	}

	public List<Organization> getOrganizationList() {
		return organizationDao.getOrganizationList();
	}

	public int addOrganization(Organization organization) {
		return organizationDao.insert(organization);
	}

	public int updateOrganization(Organization organization) {
		return organizationDao.updateByPrimaryKeySelective(organization);
		
	}

	public int deleteOrganization(String id) {
		return organizationDao.deleteByPrimaryKey(id);
	}
	
	public boolean checkOrganizationName(String name) {
		Organization organization =  organizationDao.selectByName(name);
		if(organization != null){
			return true;
		}
		return false;
	}

	public int getMaxSequence() {
		if(CollectionUtils.isEmpty(organizationDao.getOrganizationList())) {
			return 0;
		}
		return organizationDao.getMaxSequence();
	}

	public List<Organization> getNoConnectedOrganizationList() {
		return organizationDao.getNoConnectedOrganizationList();
	}

	public Admin selectByPrimaryKey(String id) {
		return adminDao.selectByPrimaryKey(id);
	}

}
