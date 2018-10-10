package com.yifei.bean;

public class User {
    private String phoneNum;

    private String name;

    private String identification;

    private String pass;

    private String level;

    
    public User() {
		super();
	}

	public User(String phoneNum, String name, String identification, String pass, String level) {
		super();
		this.phoneNum = phoneNum;
		this.name = name;
		this.identification = identification;
		this.pass = pass;
		this.level = level;
	}

	public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum == null ? null : phoneNum.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getIdentification() {
        return identification;
    }

    public void setIdentification(String identification) {
        this.identification = identification == null ? null : identification.trim();
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass == null ? null : pass.trim();
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level == null ? null : level.trim();
    }
}