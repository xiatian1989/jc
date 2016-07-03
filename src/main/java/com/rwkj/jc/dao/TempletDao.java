package com.rwkj.jc.dao;

import java.util.List;

import com.rwkj.jc.domain.Templet;

public interface TempletDao {
	
    int deleteByPrimaryKey(String id);

    int insert(Templet record);

    int insertSelective(Templet record);

    Templet selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Templet record);

    int updateByPrimaryKey(Templet record);
    
    List<Templet> getTemplets();
    
    Templet selectByName(String title);
}