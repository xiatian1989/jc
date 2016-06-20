package com.rwkj.jc.serviceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.dao.AdminDao;
import com.rwkj.jc.domain.Admin;
import com.rwkj.jc.service.AdminService;

@Service("AdminService")
public class AdminServiceImpl implements AdminService {

	@Resource
	private AdminDao adminDao;
	
	public Admin getAdminByUserName(String username) {
		return adminDao.selectByUserName(username);
	}
}
