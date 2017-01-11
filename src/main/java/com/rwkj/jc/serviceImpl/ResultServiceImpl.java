package com.rwkj.jc.serviceImpl;

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

}
