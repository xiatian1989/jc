package com.rwkj.jc.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.AdminMapper;
import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.service.AdminService;

@Service("AdminService")
public class AdminServiceImpl implements AdminService {

	@Resource
	private AdminMapper adminDao;
	
	public Admin getAdminByUserName(String username) {
		return adminDao.selectByUserName(username);
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
		Admin admin = adminDao.selectByUserName(name);
		if(admin != null){
			return true;
		}else{
			return false;
		}
	}

	public Admin selectByPrimaryKey(String id) {
		return adminDao.selectByPrimaryKey(id);
	}

	public List<Admin> getAdmins(int pageIndex, int pageSize) {
		return adminDao.getAdmins(pageIndex, pageSize);
	}
	
	
	public List<Admin> getAdmins(String username,int pageIndex, int pageSize) {
		return adminDao.getAdmins(pageIndex, pageSize);
	}

	public List<Admin> getAdminsByUserName(String username, int pageIndex, int pageSize) {
		return adminDao.getAdminsByUserName(username, pageIndex, pageSize);
	}

	public int getAdminsCount() {
		return adminDao.getAdminsCount();
	}

	public int getAdminsCountByUserName(String username) {
		return adminDao.getAdminsCountByUserName(username);
	}

	
}
