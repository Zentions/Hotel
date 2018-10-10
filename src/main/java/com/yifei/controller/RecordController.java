package com.yifei.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonTypeInfo.Id;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yifei.bean.Msg;
import com.yifei.bean.Record;
import com.yifei.bean.User;
import com.yifei.service.RecordService;
import com.yifei.service.RoomService;
import com.yifei.service.UserService;

@Controller
public class RecordController {

	@Autowired
	RecordService recordService;
	@Autowired
	RoomService roomService;
	@Autowired
	UserService userService;
	
	@RequestMapping("/record/{status}")
	@ResponseBody
	public Msg getRecordWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn,
			@RequestParam(value="phone",defaultValue="n")String phone,@PathVariable("status")Integer status) {
		PageHelper.startPage(pn, 5);
		List<Record> records = null;
		if(status==1) {
			records = recordService.getAlllByStatus("T",phone);
		}else if(status==2){
			records = recordService.getAlllByStatus("F",phone);
		}else {
			records = new ArrayList<Record>();
		}
		PageInfo pageInfo = new PageInfo(records,5);
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	
	@RequestMapping("/view")
	public String getRecord() {
		return "list";
	}
	
	@RequestMapping("/recordAdd")
	public String userAdd() {
		return "record_add";
	}
	
	@RequestMapping("/checkOut")
	public String checkOut() {
		return "check_out";
	}
	
	@ResponseBody
	@RequestMapping(value="/record/{ids}",method=RequestMethod.DELETE)
	public Msg deleteRecById(@PathVariable("ids")String ids) {
		if(ids.contains("&")) {
			String [] array_id = ids.split("&");
			List<Integer> del_ids = new ArrayList<Integer>();
			for(String id: array_id) {
				del_ids.add(Integer.parseInt(id));
			}
			recordService.deleteBatch(del_ids);
		}else {
			recordService.deleteRecord(Integer.parseInt(ids));
		}
		return Msg.success();
	}
	@ResponseBody
	@RequestMapping(value="/record/{id}",method=RequestMethod.PUT)
	public Msg checkoutById(@PathVariable("id")Integer id) {
		recordService.checkout(id);
		return Msg.success();
	}
	@RequestMapping(value="/checkin",method=RequestMethod.POST)
	@ResponseBody
	public Msg CheckIn(@RequestParam(value="pNum")String pNum, @RequestParam(value="rId")String rId,
			@RequestParam(value="startDate")String str_startDate, @RequestParam(value="endDate")String str_endDate) throws ParseException {
		SimpleDateFormat simFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate = simFormat.parse(str_startDate);
		Date endDate = simFormat.parse(str_endDate);
		long date1 = startDate.getTime();
		long date2 = endDate.getTime();
		if(date2-date1<=0) {
			return Msg.failure().add("tip", "Fail to write two correct times!");
		}
		Record record = new Record();
		record.setpNum(pNum);
		record.setrId(rId);
		record.setStartDate(startDate);
		record.setEndDate(endDate);
		record.setStatus("T");
		float price = roomService.getRoomWithPriceById(rId).getHouseType().getPrice();
		record.setTotalPrice(computePrice(pNum,price,date2-date1));
	    recordService.checkIn(record);
		return Msg.success().add("price", price).add("total_price", record.getTotalPrice());
	}


	private Integer computePrice(String pNum,float price,long us) {
		// TODO Auto-generated method stub
		String level = userService.getMenberLevel(pNum);
		float discount = 1;
		if(level.equals("Gold")) {
			discount = 0.9f;
		}else if(level.equals("Silver")) {
			discount = 0.95f;
		}else {
			discount = 1;
		}
		long day = us/86400000;
		Integer total_price = (int) (day*price*discount);
		return total_price;
	}
}
