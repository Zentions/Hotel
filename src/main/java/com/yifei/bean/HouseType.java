package com.yifei.bean;

public class HouseType {
    private String hTpye;

    private Float price;

    public String gethTpye() {
        return hTpye;
    }

    
    public HouseType() {
		super();
	}

	public HouseType(String hTpye, Float price) {
		super();
		this.hTpye = hTpye;
		this.price = price;
	}


	public void sethTpye(String hTpye) {
        this.hTpye = hTpye == null ? null : hTpye.trim();
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }
}