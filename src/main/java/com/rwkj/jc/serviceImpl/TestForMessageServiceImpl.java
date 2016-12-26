package com.rwkj.jc.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.TestForMessageMapper;
import com.rwkj.jc.domain.Relation;
import com.rwkj.jc.service.TestForMessageService;

@Service("TestForMessageService")
public class TestForMessageServiceImpl implements TestForMessageService {
	
	@Resource
	private TestForMessageMapper testForMessageDao;

	public int batchInsert(List<Relation> list) {
		return 0;
	}

	public int deleteTestForMessage(String id) {
		return testForMessageDao.deleteByPrimaryKey(id);
	}

}
