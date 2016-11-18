package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.TempletDetail;

public interface TempletDetailService {
	
	List<TempletDetail> getTempletDetails(int pageIndex, int pageSize);
	int getTempletDetailsCount();
	List<TempletDetail> getTempletDetailsByColumnValue(String column,String value,int pageIndex,int pageSize);
	int getTempletDetailsCountByColumnValue(String column,String value);
	int addTempletDetail(TempletDetail templetDetail);
	int updateTempletDetail(TempletDetail templetDetail);
	int deleteTempletDetail(String id);
	int deleteTempletDetails(String ids);
	boolean checkTempletDetailQuestionName(String questionName);
}
