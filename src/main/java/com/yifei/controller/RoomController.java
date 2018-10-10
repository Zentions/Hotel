package com.yifei.controller;

import java.util.ArrayList;
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
import com.yifei.bean.Record;
import com.yifei.bean.Room;
import com.yifei.bean.User;
import com.yifei.service.RoomService;

@Controller
public class RoomController {

	@Autowired
	RoomService roomService;
	
	@ResponseBody
	@RequestMapping(value="/room/{type}",method=RequestMethod.GET)
	public Msg getRoomByType(@PathVariable("type")String type) {
		return Msg.success().add("room", roomService.getRoomIdByTpye(type));
	}
	
	@RequestMapping("/mr")
	public String roomManagement() {
		return "room_management";
	}
	
	@RequestMapping(value="/roominfo/{status}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getRecordWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn,
			@RequestParam(value="room_id",defaultValue="n")String room_id,@PathVariable("status")Integer status) {
		PageHelper.startPage(pn, 5);
		List<Room> rooms = null;
		rooms = roomService.getAlllByStatus(room_id,status);	
		PageInfo pageInfo = new PageInfo(rooms,5);
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	@ResponseBody
	@RequestMapping(value="/roominfo/{ids}",method=RequestMethod.DELETE)
	public Msg deleteRecById(@PathVariable("ids")String ids) {
		if(ids.contains("&")) {
			String [] array_id = ids.split("&");
			List<String> del_ids = new ArrayList<String>();
			for(String id: array_id) {
				del_ids.add(id);
			}
			roomService.deleteBatch(del_ids);
		}else {
			roomService.deleteRecord(ids);
		}
		return Msg.success();
	}
	@RequestMapping(value="/roominfo",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveRoom(@Valid Room room) {
		room.setUsable("T");
		System.out.println(room.getRoomId());
		if(roomService.save(room)==1)return Msg.success();
		else return Msg.failure();
	}
	@RequestMapping(value="/checkRoom/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg checkRoom(@PathVariable("id")String id) {
		if(roomService.checkRoomId(id)==0)return Msg.success().add("usable", true);
		else return Msg.success().add("usable", false);
	}

}
