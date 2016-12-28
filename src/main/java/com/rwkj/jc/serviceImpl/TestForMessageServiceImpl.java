package com.rwkj.jc.serviceImpl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.TestForMessageMapper;
import com.rwkj.jc.domain.TestForMessage;
import com.rwkj.jc.service.TestForMessageService;

@Service("TestForMessageService")
public class TestForMessageServiceImpl implements TestForMessageService {
	
	@Resource
	private TestForMessageMapper testForMessageDao;

	public int batchInsert(List<TestForMessage> list) {
		return testForMessageDao.batchInsert(list);
	}

	public int deleteTestForMessage(String planId) {
		return testForMessageDao.deleteByPlanId(planId);
	}
	
	public int sendMessage(String id,Date updateTime) {
		return testForMessageDao.sendMessage(id, updateTime);
	}

}
