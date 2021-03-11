package com.ssafy.happyhouse.model.dto;

public class HouseBuyDto {
	int no; // 가져올 때 넘버 하나씩 올리면서 셋팅 하고, 객체 전달
	String dong; 
	String buildingName;
	String area;
	String dealamount;
	String floor;
	String buildYear;
	String roadname;
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getBuildingName() {
		return buildingName;
	}
	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getDealamount() {
		return dealamount;
	}
	public void setDealamount(String dealamount) {
		this.dealamount = dealamount;
	}
	public String getFloor() {
		return floor;
	}
	public void setFloor(String floor) {
		this.floor = floor;
	}
	public String getBuildYear() {
		return buildYear;
	}
	public void setBuildYear(String buildYear) {
		this.buildYear = buildYear;
	}
	public String getRoadname() {
		return roadname;
	}
	public void setRoadname(String roadname) {
		this.roadname = roadname;
	}
	
	
	
}
