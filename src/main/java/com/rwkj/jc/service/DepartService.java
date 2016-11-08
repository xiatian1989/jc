package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.Depart;

public interface DepartService {
	int addDepart(Depart depart);
	int updateDepart(Depart depart);
	int deleteDepart(String id);
	boolean checkDepartName(String name);
	Depart selectByPrimaryKey(String id);
	
	List<Depart> getDeparts();
	List<Depart> getDepartsByDepartName(String param);
	List<Depart> getDepartsByParentNo(String parentNo);
	List<Depart> getDepartsByParentNoForPage(String parentNo,int pageIndex, int pageSize);
	List<Depart> getFirstLevelDeparts();
	int getSonCountByParentNo(String parentNo);
	
	boolean checkDepartNo(String departNo);
	Depart getDepartByDepartNo(String departNo);
	
}
