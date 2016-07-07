package com.rwkj.jc.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.dao.DepartDao;
import com.rwkj.jc.domain.Depart;
import com.rwkj.jc.service.DepartManagerService;

@Service("DepartManagerService")
public class DepartManagerServiceImpl implements DepartManagerService{

	@Resource
	private DepartDao departDao;
	
	public PageInfo<Depart> getDeparts(String tableName,Integer pageNo, Integer pageSize) {
		
		PageHelper.startPage(pageNo, pageSize);
		List<Depart> departs = departDao.getDeparts(tableName);
		
		List<Depart> allDeparts = this.getDeparts(tableName);
		Map<String,Depart> mapDeparts = new HashMap<String,Depart>();
		for(Depart depart:allDeparts) {
			mapDeparts.put(depart.getDepartNo(), depart);
		}
		for(Depart depart:departs) {
			if(!StringUtils.isNullOrEmpty(depart.getParentNo())) {
				depart.setParentName(mapDeparts.get(depart.getParentNo()).getDepartName());
			}
		}
		PageInfo<Depart> page = new PageInfo<Depart>(departs);
		return page;
	}
	
	public List<Depart> getDeparts(String tableName){
		return departDao.getDeparts(tableName);
	}
	
	public int addDepart(String tableName, Depart depart) {
		return departDao.insert(tableName, depart);
	}

	public int updateDepart(String tableName, Depart depart) {
		
		String nodepath = depart.getNodePath();
		String parentNo = depart.getParentNo();
		
		List<Depart> subDeparts = null;
		if(!StringUtils.isNullOrEmpty(parentNo) && !StringUtils.isNullOrEmpty(nodepath)) {
			Depart parentDepart = new Depart();
			
			parentDepart.setDepartNo(parentNo);
			parentDepart.setIsleaf(false);
			
			departDao.updateBydepartNo(tableName, parentDepart);
			
			subDeparts = departDao.getSubDepartsByDepartNo(tableName, depart.getDepartNo());
			
			for(Depart tempDepart:subDeparts) {
				tempDepart.setNodePath(nodepath+depart.getDepartNo()+"|"+tempDepart.getDepartNo()+"|");
				departDao.updateByPrimaryKeySelective(tableName, tempDepart);
			}
			depart.setNodePath(nodepath+depart.getDepartNo()+"|");
		}
		
		return departDao.updateByPrimaryKeySelective(tableName, depart);
	}

	public int deleteDepart(String tableName, String id) {
		
		Depart depart = departDao.selectByPrimaryKey(tableName, id);
		String departNo = depart.getDepartNo();
		String parentNo = depart.getParentNo();
		String nodepath = depart.getNodePath();
		
		List<Depart> brotherDeparts = departDao.getSubDepartsByDepartNo(tableName, parentNo);
		if(brotherDeparts!= null && brotherDeparts.size()==1) {
			Depart parentDepart = new Depart();
			
			parentDepart.setDepartNo(parentNo);
			parentDepart.setIsleaf(true);
			
			departDao.updateBydepartNo(tableName, parentDepart);
		}
		
		List<Depart> sonDeparts = departDao.getSubDepartsByDepartNo(tableName, departNo);
		if(sonDeparts != null) {
			for(Depart tempDepart:sonDeparts) {
				tempDepart.setParentNo(null);
				tempDepart.setNodePath(tempDepart.getNodePath().replace(nodepath, ""));
				departDao.updateByPrimaryKey(tableName, tempDepart);
			}
		}
		return departDao.deleteByPrimaryKey(tableName, id);
	}

	public boolean checkDepartName(String tableName, String name) {
		if(departDao.selectByname(tableName, name) != null) {
			return true;
		}
		return false;
	}

	public int getMaxDepartNo(String tableName) {
		if(CollectionUtils.isEmpty(departDao.getDeparts(tableName))) {
			return 0;
		}else{
			return departDao.getMaxDepartNo(tableName);
		}
	}
}
