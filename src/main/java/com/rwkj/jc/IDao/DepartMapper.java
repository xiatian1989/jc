package com.rwkj.jc.IDao;

import java.util.List;

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
    
    List<Depart> getDepartsByDepartName(String param);
    
    List<Depart> selectSonDepartsByParentNo(String parentNo);
    
    Depart selectByNo(String departNo);
}