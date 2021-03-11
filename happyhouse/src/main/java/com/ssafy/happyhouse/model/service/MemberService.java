package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.Map;

import com.ssafy.happyhouse.model.dto.Member;

public interface MemberService {

	public Member login(Map<String, String> map) throws Exception;
	public Member selectService(String id) throws SQLException;
	public int register(Member member) throws Exception;
	public int edit(Member member) throws SQLException ;
	public int delete(String id) throws SQLException ;
	
}
