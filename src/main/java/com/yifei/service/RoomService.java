package com.yifei.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yifei.bean.Record;
import com.yifei.bean.Room;
import com.yifei.bean.RoomExample;
import com.yifei.bean.RoomExample.Criteria;
import com.yifei.dao.RoomMapper;

@Service
public class RoomService {

	@Autowired
	RoomMapper roomMapper;
	
	public List<Room> getRoomIdByTpye(String type){
		RoomExample example = new RoomExample();
		Criteria criteria = example.createCriteria();
		criteria.andTypeEqualTo(type);
		criteria.andUsableEqualTo("T");
		List<Room> list = roomMapper.selectByExample(example);
		return list;
		
	}
	public Room getRoomWithPriceById(String id) {
		return roomMapper.selectWithPriceByPrimaryKey(id);
	}
	public List<Room> getAlllByStatus(String room_id, Integer status) {
		// TODO Auto-generated method stub
		RoomExample example = new RoomExample();
		Criteria criteria = example.createCriteria();
		if(room_id.equals("n")) {
			if(status==0) {
				return roomMapper.selectByExample(null);
			}else if(status==1) {
				criteria.andUsableEqualTo("T");
				return roomMapper.selectByExample(example);
				
			}else if(status==2) {
				criteria.andUsableEqualTo("F");
				return roomMapper.selectByExample(example);
				
			}else {
				return null;
			}
		}else {
			criteria.andRoomIdEqualTo(room_id);
			return roomMapper.selectByExample(example);
		}
		
		
	}
	public void deleteBatch(List<String> del_ids) {
		// TODO Auto-generated method stub
		RoomExample example = new RoomExample();
		Criteria criteria = example.createCriteria();
		criteria.andRoomIdIn(del_ids);
		roomMapper.deleteByExample(example);
	}
	public void deleteRecord(String room_id) {
		// TODO Auto-generated method stub
		roomMapper.deleteByPrimaryKey(room_id);
	}
	public int save(Room room) {
		// TODO Auto-generated method stub
		try {
			roomMapper.insertSelective(room);
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(2);
			return 2;
		}
	}
	public long checkRoomId(String id) {
		// TODO Auto-generated method stub
		RoomExample example = new RoomExample();
		Criteria criteria = example.createCriteria();
		criteria.andRoomIdEqualTo(id);
		return roomMapper.countByExample(example);
	}
}
