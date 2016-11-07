package com.rwkj.jc.IDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Depart;

public interface DepartMapper {
	
    int deleteByPrimaryKey(String id);

    int insert(Depart record);

    int insertSelective(Depart record);

    Depart selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Depart record);

    int updateByPrimaryKey(Depart record);
    
    Depart selectByName(String departName);
    
    List<Depart> getDeparts(@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    List<Depart> getDepartsByCondition(@Param("column") String column,@Param("param") String param,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getDepartsCount();
    
    int getDepartsCountByCondition(@Param("column") String column,@Param("param") String param);
}