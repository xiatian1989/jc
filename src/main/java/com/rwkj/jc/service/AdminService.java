package com.rwkj.jc.service;

import com.rwkj.jc.domain.Admin;

public interface AdminService {
	Admin getAdminByUserName(String username);
}
