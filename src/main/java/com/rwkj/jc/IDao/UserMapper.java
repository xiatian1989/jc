package com.rwkj.jc.IDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.User;

public interface UserMapper {
	
    int deleteByPrimaryKey(String id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    User getUserByUserNo(String userNo);
    
    User getUserByWebChat(String webChat);
    
    List<User> getUsersByUserName(String userName);
    
    List<User> getUserByColumnValue(@Param("column") String column,@Param("value") String value,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    List<User> getUserByColumnValues(@Param("column") String column,@Param("value") String value,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getUserCountByColumnValue(@Param("column") String column,@Param("value") String value);
    
    int getUserCountByColumnValues(@Param("column") String column,@Param("value") String value);
    
    List<User> getAllUsersForPage(@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getAllUsersCount();
    
    List<User> getAllUsers();
    
    List<User> getUsersByDepartNo(String departNo);
    
    List<User> getUsersByLeaderNo(String leaderNo);
    
    Integer deleteConnectionByLeaderNo(String leaderNo);
    
    int batchInsert(List<User> list);
}