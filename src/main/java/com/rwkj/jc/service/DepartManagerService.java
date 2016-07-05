package com.rwkj.jc.service;

import java.util.List;

import com.github.pagehelper.PageInfo;
import com.rwkj.jc.Bean.DepartBean;
import com.rwkj.jc.domain.Depart;

public interface DepartManagerService {
	
	PageInfo<DepartBean> getDeparts(String tableName,Integer pageNo,Integer pageSize);
	List<Depart> getDeparts(String tableName);
	int addDepart(String tableName,Depart depart);
	int updateDepart(String tableName,Depart depart);
	int deleteDepart(String tableName,String id);
	boolean checkDepartName(String tableName,String name);
	int getMaxDepartNo(String tableName);
}
