package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.PaperDetail;

public interface PaperDetailService {
	
	List<PaperDetail> getPaperDetails(String paperId,int pageIndex, int pageSize);
	int getPaperDetailsCount(String paperId);
	List<PaperDetail> getPaperDetailsByColumnValue(String paperId,String column,String value,int pageIndex,int pageSize);
	int getPaperDetailsCountByColumnValue(String paperId,String column,String value);
	int addPaperDetail(PaperDetail paperDetail);
	int updatePaperDetail(PaperDetail paperDetail);
	int deletePaperDetail(String id);
	int deletePaperDetails(String ids);
	boolean checkPaperDetailQuestionName(String paperId,String questionName);
	List<PaperDetail> getPaperDetailsByPaperId(String paperId);
	int batchInsert(List<PaperDetail> list);
}
