package com.yifei.bean;

public class Room {
    private String roomId;

    private String type;

    private String usable;

    private HouseType houseType;
    
    
    public HouseType getHouseType() {
		return houseType;
	}

	public void setHouseType(HouseType houseType) {
		this.houseType = houseType;
	}

	public Room() {
		super();
	}

	public Room(String roomId, String type, String usable) {
		super();
		this.roomId = roomId;
		this.type = type;
		this.usable = usable;
	}

	public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId == null ? null : roomId.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getUsable() {
        return usable;
    }

    public void setUsable(String usable) {
        this.usable = usable == null ? null : usable.trim();
    }
}