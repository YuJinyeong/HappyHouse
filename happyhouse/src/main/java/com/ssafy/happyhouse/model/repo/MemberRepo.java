package com.ssafy.happyhouse.model.repo;

import java.sql.SQLException;
import java.util.Map;

import com.ssafy.happyhouse.model.dto.Member;

public interface MemberRepo {

	public Member select(String userid) throws SQLException;

	public int insert(Member member) throws SQLException;

	public int update(Member member) throws SQLException;

	public int delete(String id) throws SQLException;

	// public int insert(Member member) throws SQLException;
	public Member login(Map<String, String> map) throws Exception;
}
