package com.ssafy.happyhouse.model.repo;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import com.ssafy.happyhouse.model.dto.Member;
import com.ssafy.util.DBUtil;

public class MemberRepoImpl implements MemberRepo {
	/*
	// 2. 싱글 톤 적용
	public static MemberRepoImpl dao;
	
	
	// 1. 숨기기 
	private MemberRepoImpl()	{
		
	}
	
	//3. 하나만 생성해서 넘겨주기
	public static MemberRepoImpl getDao() {
		if ( dao== null) {
			dao = new MemberRepoImpl();
		}
		return dao;
	}
	
	public Member select(Connection con, String userid) throws SQLException {
		//int a = 1/0;
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		//ystem.out.println(userid);
		// 할일 작성
		String sql = "select * from happyhouse_member where userid=?";

		try {
			// 질의 준비
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);

			// 쿼리
			rset = pstmt.executeQuery();

			if (rset.next()) {
				System.out.println(rset.getString(1) + " / " + rset.getString(2) + " /  " + rset.getString(3) + " / " + rset.getString(4));
				String id = rset.getString(1);
				String passwd = rset.getString(2);
				String name = rset.getString(3);
				String email = rset.getString(4);
				member = new Member(id, passwd, name, email);
			}

		} finally {
			DBUtil.close(pstmt, rset);
		}

		return member;
	}
	
	public int insert(Connection con, Member member) throws SQLException {
	    PreparedStatement pstmt = null;
	    int result = 0;
	    // 할일 작성 - Query
	    String sql = "insert into happyhouse_member values (?,?,?,?)";
	    try {
	        // 질의 준비
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, member.getId());
	        pstmt.setString(2, member.getPasswd());
	        pstmt.setString(3, member.getName());
	        pstmt.setString(4, member.getEmail());

	        // 쿼리 실행 - 쿼리의 타입은??
	        result = pstmt.executeUpdate();
	    } finally {
	        // 자원 반납 처리
	        DBUtil.close(pstmt, null);
	    }
	    return result;
	}
	
	public int update(Connection con, Member member) throws SQLException {
		System.out.println("update Dao 화면 ");
		System.out.println(member.getId());
	    PreparedStatement pstmt = null;
	    int result = 0;
	    // 할일 작성 - Query
	    String sql = "update happyhouse_member set userpasswd = ?, username = ? , email = ? where userid = ?";
	    
	    
	    try {
	        // 질의 준비
	    	
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, member.getPasswd());
	        pstmt.setString(2, member.getName());
	        pstmt.setString(3, member.getEmail());
	        pstmt.setString(4, member.getId());

	        // 쿼리 실행 - 쿼리의 타입은??
	        result = pstmt.executeUpdate();
	    } finally {
	        // 자원 반납 처리
	        DBUtil.close(pstmt, null);
	    }
	    return result;
	}
	public int delete(Connection con, String id ) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;
		// 할일 작성
		String sql = "delete from happyhouse_member where userid = ?";

		try {
			// 질의 준비
			pstmt = con.prepareStatement(sql);

			// 쿼리
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();

		} finally {
			DBUtil.close(pstmt, rset);
		}

		return result;
	}
	*/
	@Override
	public Member select(String userid) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(Member member) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(Member member) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Member login(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		Member result = null;
		return result;
	}

}
