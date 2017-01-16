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
	
	public int addUser(User user) {
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

	public User getUserByUserNo(String userNo) {
		return userDao.getUserByUserNo(userNo);
	}

	public List<User> getUsersByUserName(String userName) {
		return userDao.getUsersByUserName(userName);
	}

	public List<User> getUserByColumnValues(String column, String value, int pageIndex, int pageSize) {
		return userDao.getUserByColumnValues(column, value, pageIndex, pageSize);
	}

	public int getUserCountByColumnValues(String column, String value) {
		return userDao.getUserCountByColumnValues(column, value);
	}

	public List<User> getUsersByLeaderNo(String leaderNo) {
		return userDao.getUsersByLeaderNo(leaderNo);
	}

	public User getUserByUserId(String userId) {
		return userDao.selectByPrimaryKey(userId);
	}

	public Integer deleteConnectionByLeaderNo(String leaderNo) {
		return userDao.deleteConnectionByLeaderNo(leaderNo);
	}

	public int batchInsert(List<User> list) {
		return userDao.batchInsert(list);
	}

	public User getUserByWebChat(String webChat) {
		return userDao.getUserByWebChat(webChat);
	}

}
