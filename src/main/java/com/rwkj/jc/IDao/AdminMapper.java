package com.rwkj.jc.IDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Admin;

public interface AdminMapper {
	
    int deleteByPrimaryKey(String id);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(String id);
    
    Admin selectByUserName(String username);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);
    
    List<Admin> getAdmins(@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getAdminsCount();
    
    List<Admin> getAdminsByUserName(@Param("username")String username,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getAdminsCountByUserName(String username);
}