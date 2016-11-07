package com.rwkj.jc.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.DepartMapper;
import com.rwkj.jc.domain.Depart;
import com.rwkj.jc.service.DepartService;

@Service("DepartService")
public class DepartServiceImpl implements DepartService {

	@Resource
	private DepartMapper departDao;

	public int addDepart(Depart depart) {
		return departDao.insert(depart);
	}

	public int updateDepart(Depart depart) {
		return departDao.updateByPrimaryKeySelective(depart);
	}

	public int deleteDepart(String id) {
		return departDao.deleteByPrimaryKey(id);
	}

	public boolean checkDepartName(String name) {
		Depart depart = departDao.selectByName(name);
		if(depart != null){
			return true;
		}else{
			return false;
		}
	}

	public Depart selectByPrimaryKey(String id) {
		return departDao.selectByPrimaryKey(id);
	}

	public List<Depart> getDeparts(int pageIndex, int pageSize) {
		return departDao.getDeparts(pageIndex, pageSize);
	}

	public List<Depart> getDepartsByCondition(String column,String param, int pageIndex, int pageSize) {
		return departDao.getDepartsByCondition(column, param, pageIndex, pageSize);
	}

	public int getDepartsCount() {
		return departDao.getDepartsCount();
	}

	public int getDepartsCountByCondition(String column, String param) {
		// TODO Auto-generated method stub
		return departDao.getDepartsCountByCondition(column, param);
	}
	
}
