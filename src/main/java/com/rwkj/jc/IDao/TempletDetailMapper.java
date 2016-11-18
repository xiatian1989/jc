package com.rwkj.jc.IDao;

import com.rwkj.jc.domain.TempletDetail;

public interface TempletDetailMapper {
    int deleteByPrimaryKey(String id);

    int insert(TempletDetail record);

    int insertSelective(TempletDetail record);

    TempletDetail selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TempletDetail record);

    int updateByPrimaryKeyWithBLOBs(TempletDetail record);

    int updateByPrimaryKey(TempletDetail record);
}