package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.User;

public interface UserService {
	
	int addUser(User user);
	int updateUser(User user);
	int deleteUser(String id);
	Boolean checkUserNoUnique(String userNo);
	List<User> getUserByColumnValue(String column,String value,int pageIndex,int pageSize);
	List<User> getUserByColumnValues(String column,String value,int pageIndex,int pageSize);
	int getUserCountByColumnValue(String column,String value);
	int getUserCountByColumnValues(String column,String value);
	List<User> getAllUsersForPage(int pageIndex,int pageSize);
	List<User> getAllUsers();
	int getAllUsersCount();
	List<User> getUsersByDepartNo(String departNo);
	List<User> getUsersByLeaderNo(String leaderNo);
	User getUserByUserNo(String userNo);
	List<User> getUsersByUserName(String userName);
	User getUserByUserId(String userId);
	Integer deleteConnectionByLeaderNo(String leaderNo);
	int batchInsert(List<User> list);
	User getUserByWebChat(String webChat);
}
