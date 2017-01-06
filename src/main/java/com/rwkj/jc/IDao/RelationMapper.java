package com.rwkj.jc.IDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Relation;

public interface RelationMapper {
    int deleteByPrimaryKey(String id);

    int insert(Relation record);

    int insertSelective(Relation record);

    Relation selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Relation record);

    int updateByPrimaryKey(Relation record);
    
    List<Relation> getRelations(@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getRelationsCount();
    
    List<Relation> getRelationsByColumnValueForNoSureValue(@Param("column") String column,@Param("value") String value,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getRelationsCountByColumnValueForNoSureValue(@Param("column") String column,@Param("value") String value);
    
    List<Relation> getRelationsByColumnValue(@Param("column") String column,@Param("value") String value,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getRelationsCountByColumnValue(@Param("column") String column,@Param("value") String value);
    
    int deleteRelationByids(@Param("ids") String ids);
    
    int openSMSRelationByid(String planId );
    
    int disabledSMSRelationByid(String planId );
    
    List<Relation> getAllRelations();
    
    List<Relation> getRelationsByPlanId(String planId );
    
    List<Relation> getRelationsByPlanIdAndUserNo(@Param("planId") String planId,@Param("userNo") String userNo);
    
    List<Relation> getRelationsByUserNo(@Param("userNo") String userNo);
    
    int batchInsert(List<Relation> list);
}