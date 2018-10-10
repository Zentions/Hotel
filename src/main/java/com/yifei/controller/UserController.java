package com.yifei.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yifei.bean.Msg;
import com.yifei.bean.Room;
import com.yifei.bean.User;
import com.yifei.service.UserService;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	
	@RequestMapping(value="/user",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveUser(@Valid User user,BindingResult result) {
		if(result.hasErrors()) {
			List<FieldError> list = result.getFieldErrors();
			Map<String, Object> map = new HashMap<String, Object>();
			for(FieldError error:list) {
				System.out.println(error.getField());
				System.out.println(error.getDefaultMessage());
				map.put(error.getField(), error.getDefaultMessage());
			}
			return Msg.failure().add("error", map);
		}
		if(userService.save(user)==1)return Msg.success();
		else return Msg.failure();
	}
	
	@RequestMapping("/userAdd")
	public String userAdd() {
		return "user_add";
	}
	
	@RequestMapping("/checkUser")
	@ResponseBody
	public Msg checkUser(@RequestParam("phone")String phone) {
		User user = userService.checkUser(phone);
		if(user!= null) {
			return Msg.success().add("exit", true).add("name", user.getName()).add("level",user.getLevel());
		}else {
			return Msg.success().add("exit", false);
		}
	}
	
	@RequestMapping("/mm")
	public String menberManagement() {
		return "menberManagement";
	}
	@RequestMapping(value="/member",method=RequestMethod.GET)
	@ResponseBody
	public Msg getRecordWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn,
			         @RequestParam(value="phone")String phone) {
		PageHelper.startPage(pn, 5);
		List<User> user_list = null;
		user_list = userService.getAlllMember(phone);	
		PageInfo pageInfo = new PageInfo(user_list,5);
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	@RequestMapping(value="/member/{phone}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteMember(@PathVariable("phone")String phone) {
		userService.deleteMemberByPhone(phone);
		return Msg.success();
	}
	
	@ResponseBody
	@RequestMapping(value="/member/{phoneNum}",method=RequestMethod.PUT)
	public Msg updateMemberLevel(User user) {
		System.out.println(user.getPhoneNum());
		System.out.println(user.getLevel());
		userService.updateMember(user);
		return Msg.success();
	}
}
