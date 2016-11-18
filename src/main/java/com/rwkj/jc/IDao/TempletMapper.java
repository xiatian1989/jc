package com.rwkj.jc.IDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Templet;

public interface TempletMapper {
	
    int deleteByPrimaryKey(String id);

    int insert(Templet record);

    int insertSelective(Templet record);

    Templet selectByPrimaryKey(String id);
    
    Templet selectTempletByName(String name);

    int updateByPrimaryKeySelective(Templet record);

    int updateByPrimaryKey(Templet record);
    
    List<Templet> getTemplets(@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getTempletsCount();
    
    List<Templet> getTempletsByColumnValue(@Param("column") String column,@Param("value") String value,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getTempletsCountByColumnValue(@Param("column") String column,@Param("value") String value);
    
    int deleteTempletByids(@Param("ids") String ids);
}