package com.rwkj.jc.IDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Paper;

public interface PaperMapper {
    int deleteByPrimaryKey(String id);

    int insert(Paper record);

    int insertSelective(Paper record);

    Paper selectByPrimaryKey(String id);
    
    Paper selectPaperByName(String name);

    int updateByPrimaryKeySelective(Paper record);

    int updateByPrimaryKey(Paper record);
    
    List<Paper> getPapers(@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getPapersCount();
    
    List<Paper> getPapersByColumnValue(@Param("column") String column,@Param("value") String value,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    int getPapersCountByColumnValue(@Param("column") String column,@Param("value") String value);
    
    int deletePaperByids(@Param("ids") String ids);
}