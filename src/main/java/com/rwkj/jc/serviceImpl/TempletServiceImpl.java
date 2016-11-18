package com.rwkj.jc.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.TempletMapper;
import com.rwkj.jc.domain.Templet;
import com.rwkj.jc.service.TempletService;

@Service("TempletService")
public class TempletServiceImpl implements TempletService {

	@Resource
	private TempletMapper templetDao;

	public List<Templet> getTemplets(int pageIndex, int pageSize) {
		return templetDao.getTemplets(pageIndex, pageSize);
	}

	public int getTempletsCount() {
		return templetDao.getTempletsCount();
	}

	public List<Templet> getTempletsByColumnValue(String column, String value, int pageIndex, int pageSize) {
		return templetDao.getTempletsByColumnValue(column, value, pageIndex, pageSize);
	}

	public int getTempletsCountByColumnValue(String column, String value) {
		return templetDao.getTempletsCountByColumnValue(column, value);
	}

	public int addTemplet(Templet templet) {
		return templetDao.insertSelective(templet);
	}

	public int updateTemplet(Templet templet) {
		return templetDao.updateByPrimaryKeySelective(templet);
	}

	public int deleteTemplet(String id) {
		return templetDao.deleteByPrimaryKey(id);
	}

	public boolean checkTempletName(String templetTitle) {
		Templet templet = templetDao.selectTempletByName(templetTitle);
		if(templet != null) {
			return true;
		}
		return false;
	}

	public int deleteTemplets(String ids) {
		return templetDao.deleteTempletByids(ids);
	}
	
}
