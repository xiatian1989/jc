package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.User;

public interface UserService {
	
	int AddUser(User user);
	int updateUser(User user);
	int deleteUser(String id);
	Boolean checkUserNoUnique(String userNo);
	List<User> getUserByColumnValue(String column,String value,int pageIndex,int pageSize);
	int getUserCountByColumnValue(String column,String value);
	List<User> getAllUsersForPage(int pageIndex,int pageSize);
	List<User> getAllUsers();
	int getAllUsersCount();
	List<User> getUsersByDepartNo(String userNo);
}
