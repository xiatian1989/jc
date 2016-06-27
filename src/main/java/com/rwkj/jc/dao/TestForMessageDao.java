package com.rwkj.jc.dao;

import com.rwkj.jc.domain.TestForMessage;

public interface TestForMessageDao {
    int deleteByPrimaryKey(String id);

    int insert(TestForMessage record);

    int insertSelective(TestForMessage record);

    TestForMessage selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TestForMessage record);

    int updateByPrimaryKey(TestForMessage record);
}