package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.TempletDetail;

public interface TempletDetailService {
	
	List<TempletDetail> getTempletDetails(String templetId,int pageIndex, int pageSize);
	int getTempletDetailsCount(String templetId);
	List<TempletDetail> getTempletDetailsByColumnValue(String templetId,String column,String value,int pageIndex,int pageSize);
	int getTempletDetailsCountByColumnValue(String templetId,String column,String value);
	int addTempletDetail(TempletDetail templetDetail);
	int updateTempletDetail(TempletDetail templetDetail);
	int deleteTempletDetail(String id);
	int deleteTempletDetails(String ids);
	boolean checkTempletDetailQuestionName(String templetId,String questionName);
	List<TempletDetail> getTempletDetailsByTempletId(String templetId);
	int batchInsert(List<TempletDetail> list);
	List<TempletDetail> getTempletDetailByIds(String ids);
}
