package com.yifei.bean;

import java.util.Date;

public class Record {
    private Integer id;

    private String rId;

    private String pNum;

    private String status;

    private Date startDate;

    private Date endDate;

    private Integer totalPrice;
    
    private User user;
    
    private Room room;

    
    public Record() {
		super();
	}

	public Record(String rId, String pNum, String status, Date startDate, Date endDate, Integer totalPrice) {
		super();
		this.rId = rId;
		this.pNum = pNum;
		this.status = status;
		this.startDate = startDate;
		this.endDate = endDate;
		this.totalPrice = totalPrice;
	}

	public Record(Integer id, String rId, String pNum, String status, Date startDate, Date endDate,
			Integer totalPrice) {
		super();
		this.id = id;
		this.rId = rId;
		this.pNum = pNum;
		this.status = status;
		this.startDate = startDate;
		this.endDate = endDate;
		this.totalPrice = totalPrice;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getrId() {
        return rId;
    }

    public void setrId(String rId) {
        this.rId = rId == null ? null : rId.trim();
    }

    public String getpNum() {
        return pNum;
    }

    public void setpNum(String pNum) {
        this.pNum = pNum == null ? null : pNum.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Integer getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Integer totalPrice) {
        this.totalPrice = totalPrice;
    }

	@Override
	public String toString() {
		return "Record [id=" + id + ", rId=" + rId + ", pNum=" + pNum + ", status=" + status + ", startDate="
				+ startDate + ", endDate=" + endDate + ", totalPrice=" + totalPrice + ", user=" + user + ", room="
				+ room + "]";
	}
    
}