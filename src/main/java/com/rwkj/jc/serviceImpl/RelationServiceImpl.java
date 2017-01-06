package com.rwkj.jc.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.RelationMapper;
import com.rwkj.jc.domain.Relation;
import com.rwkj.jc.service.RelationService;

@Service("RelationService")
public class RelationServiceImpl implements RelationService {

	@Resource
	private RelationMapper relationDao;

	public List<Relation> getRelationsByColumnValueForNoSureValue(String column, String value, int pageIndex,
			int pageSize) {
		return relationDao.getRelationsByColumnValueForNoSureValue(column, value, pageIndex, pageSize);
	}

	public List<Relation> getRelationsByColumnValue(String column, String value, int pageIndex, int pageSize) {
		return relationDao.getRelationsByColumnValue(column, value, pageIndex, pageSize);
	}

	public int getRelationsCountByColumnValueForNoSureValue(String column, String value) {
		return relationDao.getRelationsCountByColumnValueForNoSureValue(column, value);
	}

	public int getRelationsCountByColumnValue(String column, String value) {
		return relationDao.getRelationsCountByColumnValue(column, value);
	}

	public List<Relation> getRelations(int pageIndex, int pageSize) {
		return relationDao.getRelations(pageIndex, pageSize);
	}

	public int getRelationsCount() {
		return relationDao.getRelationsCount();
	}

	public List<Relation> getAllRelations() {
		return relationDao.getAllRelations();
	}

	public int batchInsert(List<Relation> list) {
		return relationDao.batchInsert(list);
	}

	public int deleteRelation(String ids) {
		return relationDao.deleteRelationByids(ids);
	}

	public int openSMSRelationByPlanId(String id) {
		return relationDao.openSMSRelationByid(id);
	}

	public int disabledSMSRelationByPlanId(String id) {
		return relationDao.disabledSMSRelationByid(id);
	}

	public List<Relation> getRelationsByPlanId(String planId) {
		return relationDao.getRelationsByPlanId(planId);
	}

	public List<Relation> getRelationsByPlanIdAndUserNo(String planId, String userNo) {
		return relationDao.getRelationsByPlanIdAndUserNo(planId, userNo);
	}

	public List<Relation> getRelationsByUserNo(String userNo) {
		return null;
	}
}
