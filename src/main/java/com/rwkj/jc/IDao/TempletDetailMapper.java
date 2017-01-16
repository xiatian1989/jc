package com.rwkj.jc.IDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.TempletDetail;

public interface TempletDetailMapper {
	
    int deleteByPrimaryKey(String id);

    int insert(TempletDetail record);

    int insertSelective(TempletDetail record);

    TempletDetail selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TempletDetail record);

    int updateByPrimaryKeyWithBLOBs(TempletDetail record);

    int updateByPrimaryKey(TempletDetail record);
    
    List<TempletDetail> getTempletDetails(@Param("templetId")String templetId,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getTempletDetailsCount(@Param("templetId")String templetId);
    
    List<TempletDetail> getTempletDetailsByColumnValue(@Param("templetId")String templetId,@Param("column") String column,@Param("value") String value,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getTempletDetailsCountByColumnValue(@Param("templetId")String templetId,@Param("column") String column,@Param("value") String value);
    
    TempletDetail selectTempletDetailByName(@Param("templetId")String templetId,@Param("name") String name);
    
    int deleteTempletDetailByIds(@Param("ids")String ids);
    
    List<TempletDetail> getTempletDetailsByTempletId(String templetId);
    
    List<TempletDetail> getTempletDetailsByIds(@Param("ids")String ids);
    
    int batchInsert(List<TempletDetail> list);
}