package com.ssafy.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {

	static final String URL = "jdbc:mysql://127.0.0.1:3306/happyhouse?serverTimezone=UTC&useUniCode=yes&characterEncoding=UTF-8";
	static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String ID = "ssafy";
	static final String PASSWORD = "ssafy";

	static {
		try {
			Class.forName(DRIVER);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, ID, PASSWORD);
	}

	public static void close(AutoCloseable obj) {
			try {
				if(obj != null)
					obj.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
	}
	public static void close(PreparedStatement pstmt, ResultSet rset) {
		try {
			// 자원 반납 처리
			if ( rset != null) {
				rset.close();
			}
			if ( pstmt != null) {
				pstmt.close();
				
			}
		}catch( SQLException ignore) {
			
		}
		
	}

	public static void close(Connection con) {
		// TODO Auto-generated method stub
		try {
			if ( con != null) {
				con.close();
			}
		} catch ( SQLException ignore) {
			
		}
	}
}
