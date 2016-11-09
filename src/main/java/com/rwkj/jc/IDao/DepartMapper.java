package com.rwkj.jc.IDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rwkj.jc.domain.Depart;

public interface DepartMapper {
	
    int deleteByPrimaryKey(String id);

    int insert(Depart record);

    int insertSelective(Depart record);

    Depart selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Depart record);

    int updateByPrimaryKey(Depart record);
    
    Depart selectByName(String departName);
    
    List<Depart> getDeparts();
    
    List<Depart> getFirstLevelDeparts();
    
    List<Depart> getDepartsByDepartName(String param);
    
    List<Depart> selectSonDepartsByParentNo(String parentNo);
    
    int getSonCountByParentNo(String parentNo);
    
    List<Depart> selectSonDepartsByParentNoForPage(@Param("parentNo")String parentNo,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
    
    Depart selectByNo(String departNo);
    
    int deleteByNodepath(String nodePath);
}