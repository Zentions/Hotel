package com.yifei.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yifei.bean.HouseType;
import com.yifei.bean.Msg;
import com.yifei.service.HouseTypeService;

@Controller
public class HouseTypeController {

	@Autowired
	HouseTypeService houseTypeService;
	
	@ResponseBody
	@RequestMapping(value="htype",method=RequestMethod.GET)
	public Msg getAllHouseType() {
		return Msg.success().add("type", houseTypeService.getAllHouseType());
	}
	
	@RequestMapping("/mp")
	public String priceManagement() {
		return "priceManagement";
	}
	
	@ResponseBody
	@RequestMapping("/tp")
	public Msg getTypeAndPrice() {
		List<HouseType> list = houseTypeService.getALLTAndP();
		return Msg.success().add("list", list);
	}
	
	@ResponseBody
	@RequestMapping(value="/tp",method=RequestMethod.PUT)
	public Msg modifyPrice(HouseType houseType) {
		houseTypeService.modifyPriceByType(houseType);
		return Msg.success();
	}
	
	@ResponseBody
	@RequestMapping("/price/{type}")
	public Msg getPriceByType(@PathVariable("type")String type) {
		Float price = houseTypeService.getPriceByType(type);
		return Msg.success().add("price", price);
	}
	@ResponseBody
	@RequestMapping(value="/tp",method=RequestMethod.POST)
	public Msg savePrice(HouseType houseType) {
		System.out.println(houseType.gethTpye()+" "+houseType.getPrice());
		houseTypeService.saveHouseType(houseType);
		return Msg.success();
	}
	
	@ResponseBody
	@RequestMapping(value="/tp/{type}",method=RequestMethod.DELETE)
	public Msg deleteHouseType(@PathVariable("type")String type) {
		System.out.println(type);
		houseTypeService.deleteHouseType(type);
		return Msg.success();
	}
}
