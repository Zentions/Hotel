package com.yifei.bean;

import java.util.HashMap;

public class Msg {

	private int code;
	private String msg;
	private HashMap<String, Object> extend = new HashMap<String, Object>();
	
	public static Msg success() {
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("success");
		return result;
	}
	public static Msg failure() {
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("failure");
		return result;
	}
	public Msg add(String tip,Object object) {
		this.extend.put(tip, object);
		return this;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public HashMap<String, Object> getExtend() {
		return extend;
	}
	public void setExtend(HashMap<String, Object> extend) {
		this.extend = extend;
	}
	
	
}
