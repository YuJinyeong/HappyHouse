package com.ssafy.happyhouse.model.dto;

public class Member_Interest {
	
	String userid; // happyhouse_member 테이블에서 userid로 접근함.
	String dongcode; // 관심있는 동 코드 정보들
	
	public Member_Interest(String userid, String dongcode) {
		super();
		this.userid = userid;
		this.dongcode = dongcode;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDongcode() {
		return dongcode;
	}
	public void setDongcode(String dongcode) {
		this.dongcode = dongcode;
	}
	@Override
	public String toString() {
		return "Member_Interest [userid=" + userid + ", dongcode=" + dongcode + "]";
	}
	
	
}
