package com.rwkj.jc.IDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.PaperDetail;

public interface PaperDetailMapper {
    int deleteByPrimaryKey(String id);

    int insert(PaperDetail record);

    int insertSelective(PaperDetail record);

    PaperDetail selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(PaperDetail record);

    int updateByPrimaryKeyWithBLOBs(PaperDetail record);

    int updateByPrimaryKey(PaperDetail record);
    
    List<PaperDetail> getPaperDetails(@Param("paperId")String paperId,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getPaperDetailsCount(@Param("paperId")String paperId);
    
    List<PaperDetail> getPaperDetailsByColumnValue(@Param("paperId")String paperId,@Param("column") String column,@Param("value") String value,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getPaperDetailsCountByColumnValue(@Param("paperId")String paperId,@Param("column") String column,@Param("value") String value);
    
    PaperDetail selectPaperDetailByName(@Param("paperId")String paperId,@Param("name") String name);
    
    int deletePaperDetails(String ids);
    
    List<PaperDetail> getPaperDetailsByPaperId(String paperId);
    
    int batchInsert(List<PaperDetail> list);
}