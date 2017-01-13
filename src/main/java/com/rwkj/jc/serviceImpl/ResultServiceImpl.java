package com.rwkj.jc.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.ResultMapper;
import com.rwkj.jc.domain.Result;
import com.rwkj.jc.service.ResultService;

@Service("ResultService")
public class ResultServiceImpl implements ResultService {

	@Resource
	private ResultMapper resultDao;

	public int addResult(Result result) {
		return resultDao.insert(result);
	}

	public List<Result> getResults(int pageIndex, int pageSize) {
		return resultDao.getResults(pageIndex, pageSize);
	}

	public int getResultsCount() {
		return resultDao.getResultsCount();
	}

	public List<Result> getResultsByRegion(String column, String value, int pageIndex, int pageSize) {
		return resultDao.getResultsByRegion(column, value, pageIndex, pageSize);
	}

	public int getResultsCountByRegion(String column, String value) {
		return resultDao.getResultsCountByRegion(column, value);
	}

	public int getResultsCountByColumnValue(String column, String value) {
		return resultDao.getResultsCountByColumnValue(column,value);
	}

	public List<Result> getResultsByColumnValue(String column, String value, int pageIndex, int pageSize) {
		return resultDao.getResultsByColumnValue(column, value, pageIndex, pageSize);
	}
	public int getResultsCountByRelationIds(String value) {
		return resultDao.getResultsCountByRelationIds(value);
	}
	
	public List<Result> getResultsByRelationIds(String value, int pageIndex, int pageSize) {
		return resultDao.getResultsByRelationIds(value, pageIndex, pageSize);
	}

	public int ensabledResultByids(String ids) {
		return resultDao.ensabledResultByids(ids);
	}

	public int disabledResultByids(String ids) {
		return resultDao.disabledResultByids(ids);
	}

	public Result getResultById(String id) {
		return resultDao.selectByPrimaryKey(id);
	}

}
