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

	public List<TestForMessage> getTestForMessages(int pageIndex, int pageSize) {
		return testForMessageDao.getTestForMessages(pageIndex, pageSize);
	}

	public int getTestForMessagesCount() {
		return testForMessageDao.getTestForMessagesCount();
	}

	public List<TestForMessage> getTestForMessagesByColumnValue(
			String value, int pageIndex, int pageSize) {
		return testForMessageDao.getTestForMessagesByColumnValue(value, pageIndex, pageSize);
	}

	public int getTestForMessagesCountByColumnValue(String value) {
		return testForMessageDao.getTestForMessagesCountByColumnValue(value);
	}


}
