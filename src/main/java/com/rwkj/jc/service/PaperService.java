package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.Paper;

public interface PaperService {
	
	List<Paper> getPapers(int pageIndex, int pageSize);
	int getPapersCount();
	List<Paper> getPapersByColumnValue(String column,String value,int pageIndex,int pageSize);
	int getPapersCountByColumnValue(String column,String value);
	int addPaper(Paper paper);
	int updatePaper(Paper paper);
	int deletePaper(String id);
	int deletePapers(String ids);
	boolean checkPaperName(String paperTitle);
}
