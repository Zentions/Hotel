package com.yifei.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yifei.bean.User;
import com.yifei.bean.UserExample;
import com.yifei.bean.UserExample.Criteria;
import com.yifei.dao.UserMapper;

@Service
public class UserService {

	@Autowired
	UserMapper userMapper;
	
	public int save(User user) {
		// TODO Auto-generated method stub
		try {
			userMapper.insert(user);
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(2);
			return 2;
		}
		
	}

	public User checkUser(String phone) {
		// TODO Auto-generated method stub
		User user = userMapper.selectByPrimaryKey(phone);
		return user;
	}
    
	public String getMenberLevel(String phone) {
		return userMapper.selectByPrimaryKey(phone).getLevel();
	}

	public List<User> getAlllMember(String phone) {
		// TODO Auto-generated method stub
		if(phone.equals("n")) {
			return userMapper.selectByExample(null);
		}else {
			UserExample example = new UserExample();
		    Criteria criteria =  example.createCriteria();
		    criteria.andPhoneNumLike(phone+"%");
		    return userMapper.selectByExample(example);
		}
		
	}

	public void deleteMemberByPhone(String phone) {
		// TODO Auto-generated method stub
		userMapper.deleteByPrimaryKey(phone);
	}

	public void updateMember(User user) {
		// TODO Auto-generated method stub
		userMapper.updateByPrimaryKeySelective(user);
	}
}
