package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.Result;

public interface ResultService {
	
	int addResult(Result result);
	
	List<Result> getResults(int pageIndex,int pageSize);
	    
	int getResultsCount();
	    
	List<Result> getResultsByRegion(String column,String value,int pageIndex,int pageSize);
	
	int getResultsCountByRegion(String column,String value);
	
	int getResultsCountByColumnValue(String column,String value);
	
	List<Result> getResultsByColumnValue(String column,String value,int pageIndex,int pageSize);
	
	int ensabledResultByids(String ids);
	
	int disabledResultByids(String ids);
}
