package com.rwkj.jc.dao;

import com.rwkj.jc.domain.Paperdetail;

public interface PaperdetailDao {
    int deleteByPrimaryKey(String id);

    int insert(Paperdetail record);

    int insertSelective(Paperdetail record);

    Paperdetail selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Paperdetail record);

    int updateByPrimaryKeyWithBLOBs(Paperdetail record);

    int updateByPrimaryKey(Paperdetail record);
}