package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.Relation;

public interface TestForMessageService {
	int batchInsert(List<Relation> list);
	int deleteTestForMessage(String id);
}
