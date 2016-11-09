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

	public List<Depart> getDepartsByParentNoForPage(String parentNo,
			int pageIndex, int pageSize) {
		return departDao.selectSonDepartsByParentNoForPage(parentNo, pageIndex, pageSize);
	}

	public int getSonCountByParentNo(String parentNo) {
		return departDao.getSonCountByParentNo(parentNo);
	}

	public Depart getDepartByDepartNo(String departNo) {
		return departDao.selectByNo(departNo);
	}

	public boolean checkDepartName(String departName) {
		if(departDao.selectByName(departName) != null){
			return true;
		}else{
			return false;
		}
	}

	public boolean checkDepartNo(String departNo) {
		if(departDao.selectByNo(departNo) != null){
			return true;
		}else{
			return false;
		}
	}
	
}
