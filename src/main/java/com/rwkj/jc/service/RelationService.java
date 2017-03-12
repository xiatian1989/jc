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
    int openSMSRelationByPlanId(String planId);
    int disabledSMSRelationByPlanId(String planId);
    List<Relation> getRelationsByPlanId(String planId);
    List<Relation> getRelationsByPlanIdAndUserNo(String planId,String userNo);
    List<Relation> getRelationsByUserNo(String userNo);
    List<Relation> getRelationsByUserNos(String userNos);
    List<Relation> getRelationsByBeTestedUserNo(String userNo);
    List<Relation> getRelationsByBeTestedUserNoAndPlanId(String userNo,String planId);
    List<Relation> getRelationsByBeTestedUserNos(String userNos);
    List<Relation> getRelationsByBeTestedDepartNo(String departNo);
    Relation getRelationById(String id);
    int updateRelation(Relation relation);
}
