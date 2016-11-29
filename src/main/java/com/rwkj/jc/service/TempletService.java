package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.Templet;

public interface TempletService {
	List<Templet> getTemplets(int pageIndex, int pageSize);
	int getTempletsCount();
	List<Templet> getTempletsByColumnValue(String column,String value,int pageIndex,int pageSize);
	int getTempletsCountByColumnValue(String column,String value);
	int addTemplet(Templet templet);
	int updateTemplet(Templet templet);
	int deleteTemplet(String id);
	int deleteTemplets(String ids);
	boolean checkTempletName(String templetTitle);
	Templet getTemepletById(String id);
}
