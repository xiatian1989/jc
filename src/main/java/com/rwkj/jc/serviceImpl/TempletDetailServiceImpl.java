package com.rwkj.jc.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.TempletDetailMapper;
import com.rwkj.jc.domain.TempletDetail;
import com.rwkj.jc.service.TempletDetailService;

@Service("TempletDetailService")
public class TempletDetailServiceImpl implements TempletDetailService {

	@Resource
	private TempletDetailMapper templetDetailDao;

	public List<TempletDetail> getTempletDetails(String templetId,int pageIndex, int pageSize) {
		return templetDetailDao.getTempletDetails(templetId, pageIndex, pageSize);
	}

	public int getTempletDetailsCount(String templetId) {
		return templetDetailDao.getTempletDetailsCount(templetId);
	}

	public List<TempletDetail> getTempletDetailsByColumnValue(String templetId,String column, String value, int pageIndex,
			int pageSize) {
		return templetDetailDao.getTempletDetailsByColumnValue(templetId, column, value, pageIndex, pageSize);
	}

	public int getTempletDetailsCountByColumnValue(String templetId,String column, String value) {
		return templetDetailDao.getTempletDetailsCountByColumnValue(templetId, column, value);
	}

	public int addTempletDetail(TempletDetail templetDetail) {
		return templetDetailDao.insert(templetDetail);
	}

	public int updateTempletDetail(TempletDetail templetDetail) {
		return templetDetailDao.updateByPrimaryKeySelective(templetDetail);
	}

	public int deleteTempletDetail(String id) {
		return templetDetailDao.deleteByPrimaryKey(id);
	}

	public int deleteTempletDetails(String ids) {
		return templetDetailDao.deleteTempletByids(ids);
	}

	public boolean checkTempletDetailQuestionName(String templetId,String questionName) {
		TempletDetail templetDetail = templetDetailDao.selectTempletDetailByName(templetId,questionName);
		if(templetDetail != null){
			return true;
		}else{
			return false;
		}
	}

	
}
