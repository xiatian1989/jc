package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.TestForMessage;

public interface TestForMessageService {
	int batchInsert(List<TestForMessage> list);
	int deleteTestForMessage(String id);
}
