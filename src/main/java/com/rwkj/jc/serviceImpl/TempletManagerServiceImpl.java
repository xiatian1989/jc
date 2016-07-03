package com.rwkj.jc.serviceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.rwkj.jc.dao.TempletDao;
import com.rwkj.jc.domain.Templet;
import com.rwkj.jc.service.TempletManagerService;

@Service("TempletManagerService")
public class TempletManagerServiceImpl implements TempletManagerService {

	@Resource	
	private TempletDao templetDao;
	
	public PageInfo<Templet> getTemplets(Integer pageNo,Integer pageSize) {
		PageHelper.startPage(pageNo, pageSize);
		PageInfo<Templet> page = new PageInfo<Templet>(templetDao.getTemplets());
		return page;
	};

	public int deleteByPrimaryKey(String id) {
		return templetDao.deleteByPrimaryKey(id);
	}

	public int insert(Templet record) {
		return templetDao.insert(record);
	}

	public int updateByPrimaryKey(Templet record) {
		return templetDao.updateByPrimaryKeySelective(record);
	}

	public boolean checkTempletTitle(String title) {
		
		if(templetDao.selectByName(title) != null) {
			return true;
		}else {
			return false;
		}
	}
}
