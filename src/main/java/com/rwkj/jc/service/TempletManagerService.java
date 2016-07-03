package com.rwkj.jc.service;

import com.github.pagehelper.PageInfo;
import com.rwkj.jc.domain.Templet;

public interface TempletManagerService {
	
	PageInfo<Templet> getTemplets(Integer pageNo,Integer pageSize);
	
	int deleteByPrimaryKey(String id);
	
	int insert(Templet record);
	
	int updateByPrimaryKey(Templet record);
	
	boolean checkTempletTitle(String title);
}
