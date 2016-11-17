package com.rwkj.jc.IDao;

import com.rwkj.jc.domain.Templet;

public interface TempletMapper {
	
    int deleteByPrimaryKey(String id);

    int insert(Templet record);

    int insertSelective(Templet record);

    Templet selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Templet record);

    int updateByPrimaryKey(Templet record);
}