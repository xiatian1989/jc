package com.rwkj.jc.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rwkj.jc.IDao.PaperMapper;
import com.rwkj.jc.domain.Paper;
import com.rwkj.jc.service.PaperService;

@Service("PaperService")
public class PaperServiceImpl implements PaperService {

	@Resource
	private PaperMapper paperDao;

	public List<Paper> getPapers(int pageIndex, int pageSize) {
		return paperDao.getPapers(pageIndex, pageSize);
	}

	public int getPapersCount() {
		return paperDao.getPapersCount();
	}

	public List<Paper> getPapersByColumnValue(String column, String value, int pageIndex, int pageSize) {
		return paperDao.getPapersByColumnValue(column, value, pageIndex, pageSize);
	}

	public int getPapersCountByColumnValue(String column, String value) {
		return paperDao.getPapersCountByColumnValue(column, value);
	}

	public int addPaper(Paper paper) {
		return paperDao.insertSelective(paper);
	}

	public int updatePaper(Paper paper) {
		return paperDao.updateByPrimaryKeySelective(paper);
	}

	public int deletePaper(String id) {
		return paperDao.deleteByPrimaryKey(id);
	}

	public int deletePapers(String ids) {
		return paperDao.deletePaperByids(ids);
	}

	public boolean checkPaperName(String paperTitle) {
		Paper paper = paperDao.selectPaperByName(paperTitle);
		if(paper != null){
			return true;
		}
		return false;
	}

}
