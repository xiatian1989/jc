package com.rwkj.jc.service;

import java.util.Date;
import java.util.List;

import com.rwkj.jc.domain.TestForMessage;

public interface TestForMessageService {
	int batchInsert(List<TestForMessage> list);
	int deleteTestForMessage(String id);
	List<TestForMessage> getTestForMessages(int pageIndex, int pageSize);
	int getTestForMessagesCount();
	List<TestForMessage> getTestForMessagesByColumnValue(String value,int pageIndex,int pageSize);
	int getTestForMessagesCountByColumnValue(String value);
	int sendMessage(String id,Date date);
}
