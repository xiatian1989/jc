package com.rwkj.jc.service;

import java.util.List;

import com.rwkj.jc.domain.Relation;

public interface RelationService {
	
	List<Relation> getRelationsByColumnValueForNoSureValue(String column,String value,int pageIndex,int pageSize);
	List<Relation> getRelationsByColumnValue(String column,String value,int pageIndex,int pageSize);
	int getRelationsCountByColumnValueForNoSureValue(String column,String value);
	int getRelationsCountByColumnValue(String column,String value);
	List<Relation> getRelations(int pageIndex,int pageSize);
	int getRelationsCount();
	List<Relation> getAllRelations();
	int batchInsert(List<Relation> list);
	int deleteRelation(String ids);
    int openSMSRelationByid(String id);
    int disabledSMSRelationByid(String id);
    List<Relation> getRelationsByPlanId(String planId);
}
