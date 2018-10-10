package com.yifei.test;

import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yifei.bean.Record;
import com.yifei.bean.Room;
import com.yifei.dao.RecordMapper;
import com.yifei.dao.RoomMapper;
import com.yifei.dao.UserMapper;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	RoomMapper roomMapper;
	@Autowired
	UserMapper userMapper;
	@Autowired
	RecordMapper recordMapper;
	@Test
    public void testCRUD() {
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		RoomMapper bean = ioc.getBean(RoomMapper.class);
		//System.out.println(roomMapper);
		
	//	roomMapper.insert(new Room("303", "±ê¼ä","T"));
		//roomMapper.insert(new Room("1024", "standard", 191));
		//userMapper.insert(new User("18622362514", "gaozhenbo","370725199610094615", "123456"));
		for(int i=0;i<10;i++) {
			recordMapper.insertSelective(new Record(null, "101", "17806236254", "T", new Date(2018, 9, 10), new Date(2018, 9, 11), 101));
		}
	}
}
