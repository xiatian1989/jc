package com.rwkj.jc.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.UserMapper;
import com.rwkj.jc.domain.User;
import com.rwkj.jc.service.UserService;

@Service("UserService")
public class UserServiceImpl implements UserService {

	@Resource
	private UserMapper userDao;
	
	public int AddUser(User user) {
		return userDao.insertSelective(user);
	}

	public int updateUser(User user) {
		return userDao.updateByPrimaryKeySelective(user);
	}

	public int deleteUser(String id) {
		return userDao.deleteByPrimaryKey(id);
	}

	public Boolean checkUserNoUnique(String userNo) {
		User user = userDao.getUserByUserNo(userNo);
		if(user == null){
			return false;
		}
		return true;
	}

	public List<User> getUserByColumnValue(String column, String value,int pageIndex,int pageSize) {
		return userDao.getUserByColumnValue(column, value, pageIndex, pageSize);
	}

	public int getUserCountByColumnValue(String column, String value) {
		return userDao.getUserCountByColumnValue(column, value);
	}

	public List<User> getAllUsersForPage(int pageIndex,int pageSize) {
		return userDao.getAllUsersForPage(pageIndex, pageSize);
	}

	public int getAllUsersCount() {
		return userDao.getAllUsersCount();
	}

	public List<User> getUsersByDepartNo(String departNo) {
		return userDao.getUsersByDepartNo(departNo);
	}

	public List<User> getAllUsers() {
		return userDao.getAllUsers();
	}

}
