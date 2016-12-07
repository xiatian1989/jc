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
    
    int deleteRelationByids(String ids);
    
    List<Relation> getAllRelations();
    
    int batchInsert(List<Relation> list);
}