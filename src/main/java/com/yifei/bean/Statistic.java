package com.yifei.bean;

public class Statistic {

	private String RoomType;
	
	private int PeopleNum;
	
	private int TotalMoney;

	public Statistic(String roomType, int peopleNum, int totalMoney) {
		super();
		RoomType = roomType;
		PeopleNum = peopleNum;
		TotalMoney = totalMoney;
	}

	public Statistic() {
		super();
	}

	public String getRoomType() {
		return RoomType;
	}

	public void setRoomType(String roomType) {
		RoomType = roomType;
	}

	public int getPeopleNum() {
		return PeopleNum;
	}

	public void setPeopleNum(int peopleNum) {
		PeopleNum = peopleNum;
	}

	public int getTotalMoney() {
		return TotalMoney;
	}

	public void setTotalMoney(int totalMoney) {
		TotalMoney = totalMoney;
	}
	
	
}
