package com.rwkj.jc.IDao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.TestForMessage;

public interface TestForMessageMapper {
	
    int deleteByPrimaryKey(String id);
    
    int deleteByPlanId(String planId);

    int insert(TestForMessage record);

    int insertSelective(TestForMessage record);

    TestForMessage selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TestForMessage record);

    int updateByPrimaryKey(TestForMessage record);
    
    int sendMessage(@Param("id") String id,@Param("createTime") Date createTime);
    
    int batchInsert(List<TestForMessage> list);	
    
    List<TestForMessage> getTestForMessages(@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getTestForMessagesCount();
    
    List<TestForMessage> getTestForMessagesByColumnValue(@Param("value") String value,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getTestForMessagesCountByColumnValue(@Param("value") String value);
}