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

	public List<Depart> getDeparts() {
		return departDao.getDeparts();
	}
	
	public List<Depart> getDepartsByDepartName(String param){
		return departDao.getDepartsByDepartName(param);
	}

	public List<Depart> getDepartsByParentNo(String parentNo) {
		return departDao.selectSonDepartsByParentNo(parentNo);
	}

	public List<Depart> getFirstLevelDeparts() {
		return departDao.getFirstLevelDeparts();
	}
	
}
