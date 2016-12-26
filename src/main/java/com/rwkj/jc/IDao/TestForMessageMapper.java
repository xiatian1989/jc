package com.rwkj.jc.IDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Relation;
import com.rwkj.jc.domain.TestForMessage;

public interface TestForMessageMapper {
    int deleteByPrimaryKey(String id);

    int insert(TestForMessage record);

    int insertSelective(TestForMessage record);

    TestForMessage selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TestForMessage record);

    int updateByPrimaryKey(TestForMessage record);
    
    int sendMessage(@Param("id") String id,@Param("createTime") String createTime);
    
    int batchInsert(List<Relation> list);
}