package com.yifei.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yifei.bean.HouseType;
import com.yifei.dao.HouseTypeMapper;

@Service
public class HouseTypeService {

	@Autowired
	HouseTypeMapper houseTypeMapper;
	
	public List<HouseType> getHouseTypeInformation(){
		return houseTypeMapper.selectByExample(null);
	}
	
	public List<HouseType> getAllHouseType(){
		List<HouseType> list=houseTypeMapper.selectTypeByExample(null);
		return list;
	}

	public List<HouseType> getALLTAndP() {
		// TODO Auto-generated method stub
		return houseTypeMapper.selectByExample(null);
	}

	public void modifyPriceByType(HouseType houseType) {
		// TODO Auto-generated method stub
		 houseTypeMapper.updateByPrimaryKeySelective(houseType);
	}

	public Float getPriceByType(String type) {
		// TODO Auto-generated method stub
		HouseType houseType = houseTypeMapper.selectByPrimaryKey(type);
		return houseType.getPrice();
	}

	public void saveHouseType(HouseType houseType) {
		// TODO Auto-generated method stub
	    houseTypeMapper.insertSelective(houseType);
	}

	public void deleteHouseType(String type) {
		// TODO Auto-generated method stub
		houseTypeMapper.deleteByPrimaryKey(type);
	}
}
