package com.yifei.dao;

import com.yifei.bean.HouseType;
import com.yifei.bean.HouseTypeExample;
import com.yifei.bean.RoomExample;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface HouseTypeMapper {
    long countByExample(HouseTypeExample example);

    int deleteByExample(HouseTypeExample example);

    int deleteByPrimaryKey(String hTpye);

    int insert(HouseType record);

    int insertSelective(HouseType record);

    List<HouseType> selectByExample(HouseTypeExample example);
    
    List<HouseType> selectTypeByExample(HouseTypeExample example);

    HouseType selectByPrimaryKey(String hTpye);

    int updateByExampleSelective(@Param("record") HouseType record, @Param("example") HouseTypeExample example);

    int updateByExample(@Param("record") HouseType record, @Param("example") HouseTypeExample example);

    int updateByPrimaryKeySelective(HouseType record);

    int updateByPrimaryKey(HouseType record);
}