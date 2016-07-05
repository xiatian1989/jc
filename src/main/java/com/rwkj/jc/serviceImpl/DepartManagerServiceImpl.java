package com.rwkj.jc.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.Bean.DepartBean;
import com.rwkj.jc.dao.DepartDao;
import com.rwkj.jc.domain.Depart;
import com.rwkj.jc.service.DepartManagerService;

@Service("DepartManagerService")
public class DepartManagerServiceImpl implements DepartManagerService{

	@Resource
	private DepartDao departDao;
	
	public PageInfo<DepartBean> getDeparts(String tableName,Integer pageNo, Integer pageSize) {
		
		PageHelper.startPage(pageNo, pageSize);
		List<Depart> departs = departDao.getDeparts(tableName);
		List<DepartBean> departBeans = new ArrayList<DepartBean>();
		DepartBean departBean = null;
		Map<String,DepartBean> mapDepartBean = new HashMap<String,DepartBean>();
		for(Depart depart:departs) {
			departBean = new DepartBean();
			BeanUtils.copyProperties(depart, departBean);
			mapDepartBean.put(departBean.getDepartNo(), departBean);
			departBeans.add(departBean);
		}
		for(DepartBean tempDepartBean:departBeans) {
			if(!StringUtils.isNullOrEmpty(tempDepartBean.getParentNo())) {
				tempDepartBean.setParentName(mapDepartBean.get(tempDepartBean.getParentNo()).getDepartName());
			}
		}
		PageInfo<DepartBean> page = new PageInfo<DepartBean>(departBeans);
		return page;
	}
	
	public List<Depart> getDeparts(String tableName){
		return departDao.getDeparts(tableName);
	}
	
	public int addDepart(String tableName, Depart depart) {
		return departDao.insert(tableName, depart);
	}

	public int updateDepart(String tableName, Depart depart) {
		return departDao.updateByPrimaryKeySelective(tableName, depart);
	}

	public int deleteDepart(String tableName, String id) {
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
