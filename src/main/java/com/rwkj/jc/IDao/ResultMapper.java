package com.rwkj.jc.IDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Result;

public interface ResultMapper {
    int deleteByPrimaryKey(String id);

    int insert(Result record);

    int insertSelective(Result record);

    Result selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Result record);

    int updateByPrimaryKey(Result record);
    
    List<Result> getResults(@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getResultsCount();
    
    List<Result> getResultsByRegion(@Param("column") String column,@Param("value") String value,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getResultsCountByRegion(@Param("column") String column,@Param("value") String value);
    
    int getResultsCountByColumnValue(@Param("column") String column,@Param("value") String value);
    
    List<Result> getResultsByColumnValue(@Param("column") String column,@Param("value") String value,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getResultsCountByRelationIds(@Param("value") String value);
    
    List<Result> getResultsByRelationIds(@Param("value") String value,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    List<Result> getResultsByRelationIdsNoPage(@Param("value") String value);
    
    int ensabledResultByids(@Param("ids") String ids);
    
    int disabledResultByids(@Param("ids") String ids);
}