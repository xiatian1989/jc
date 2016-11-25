package com.rwkj.jc.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.PaperDetailMapper;
import com.rwkj.jc.domain.PaperDetail;
import com.rwkj.jc.service.PaperDetailService;

@Service("PaperDetailService")
public class PaperDetailServiceImpl implements PaperDetailService {

	@Resource
	private PaperDetailMapper paperDetailDao;

	public List<PaperDetail> getPaperDetails(String paperId, int pageIndex, int pageSize) {
		return paperDetailDao.getPaperDetails(paperId, pageIndex, pageSize);
	}

	public int getPaperDetailsCount(String paperId) {
		return paperDetailDao.getPaperDetailsCount(paperId);
	}

	public List<PaperDetail> getPaperDetailsByColumnValue(String paperId, String column, String value, int pageIndex,
			int pageSize) {
		return paperDetailDao.getPaperDetailsByColumnValue(paperId, column, value, pageIndex, pageSize);
	}

	public int getPaperDetailsCountByColumnValue(String paperId, String column, String value) {
		return paperDetailDao.getPaperDetailsCountByColumnValue(paperId, column, value);
	}

	public int addPaperDetail(PaperDetail paperDetail) {
		return paperDetailDao.insertSelective(paperDetail);
	}

	public int updatePaperDetail(PaperDetail paperDetail) {
		return paperDetailDao.updateByPrimaryKeySelective(paperDetail);
	}

	public int deletePaperDetail(String id) {
		return paperDetailDao.deleteByPrimaryKey(id);
	}

	public int deletePaperDetails(String ids) {
		return paperDetailDao.deletePaperDetails(ids);
	}

	public boolean checkPaperDetailQuestionName(String paperId, String questionName) {
		PaperDetail paperDetail =  paperDetailDao.selectPaperDetailByName(paperId, questionName);
		if(paperDetail != null){
			return true;
		}
		return false;
	}

	public List<PaperDetail> getPaperDetailsByPaperId(String paperId) {
		return paperDetailDao.getPaperDetailsByPaperId(paperId);
	}

	public int batchInsert(List<PaperDetail> list) {
		return paperDetailDao.batchInsert(list);
	}

}
