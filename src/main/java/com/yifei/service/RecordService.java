package com.yifei.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yifei.bean.Record;
import com.yifei.bean.RecordExample;
import com.yifei.bean.RecordExample.Criteria;
import com.yifei.dao.RecordMapper;

@Service
public class RecordService {

	@Autowired
	RecordMapper recordMapper;
	
	public List<Record> getAlllByStatus(String status,String phone) {
		RecordExample example = new RecordExample();
		Criteria criteria = example.createCriteria();
		criteria.andStatusEqualTo(status);
		if(!phone.equals("n")) {
			criteria.andPNumEqualTo(phone);
		}
		return recordMapper.selectByExampleWithAllInfo(example);
	}

	public void deleteRecord(Integer id) {
		// TODO Auto-generated method stub
		recordMapper.deleteByPrimaryKey(id);
	}
	

	public void deleteBatch(List<Integer> del_ids) {
		// TODO Auto-generated method stub
		RecordExample example = new RecordExample();
		Criteria criteria = example.createCriteria();
		criteria.andIdIn(del_ids);
		recordMapper.deleteByExample(example);
	}

	public void checkout(Integer id) {
		// TODO Auto-generated method stub
		Record record = new Record();
		record.setId(id);
		record.setStatus("F");
		recordMapper.updateByPrimaryKeySelective(record);
	}
	public void checkIn(Record record) {
		recordMapper.insertSelective(record);
	}
}
