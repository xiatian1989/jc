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

	public List<TempletDetail> getTempletDetails(int pageIndex, int pageSize) {
		return null;
	}

	public int getTempletDetailsCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	public List<TempletDetail> getTempletDetailsByColumnValue(String column, String value, int pageIndex,
			int pageSize) {
		// TODO Auto-generated method stub
		return null;
	}

	public int getTempletDetailsCountByColumnValue(String column, String value) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int addTempletDetail(TempletDetail templetDetail) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateTempletDetail(TempletDetail templetDetail) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int deleteTempletDetail(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int deleteTempletDetails(String ids) {
		// TODO Auto-generated method stub
		return 0;
	}

	public boolean checkTempletDetailQuestionName(String questionName) {
		// TODO Auto-generated method stub
		return false;
	}

	
}
