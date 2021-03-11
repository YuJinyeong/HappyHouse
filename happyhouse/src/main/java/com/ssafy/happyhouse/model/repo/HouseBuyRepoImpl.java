package com.ssafy.happyhouse.model.repo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ssafy.happyhouse.model.dto.HouseBuyDto;
import com.ssafy.util.DBUtil;

public class HouseBuyRepoImpl implements HouseBuyRepo {
	private static HouseBuyRepo houseBuyDao;

	private HouseBuyRepoImpl() {
	}

	public static HouseBuyRepo getHouseMapDao() {
		if (houseBuyDao == null)
			houseBuyDao = new HouseBuyRepoImpl();
		return houseBuyDao;
	}

	@Override
	public List<HouseBuyDto> getHouseBuyInfo(String Dong) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<HouseBuyDto> list = new ArrayList<HouseBuyDto>();
		try {
			conn = DBUtil.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT buildingName, area, dealamount, floor, buildYear, roadname\n");
			sql.append("from housebuy_seoul \n");
			sql.append("where sigungu like concat('%',?) \n");
			sql.append("ORDER BY dealamount");
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, Dong);
			rs = pstmt.executeQuery();
			int idx =1;
			while(rs.next()) {
				HouseBuyDto dto = new HouseBuyDto();
				dto.setNo(idx++);
				dto.setDong(Dong);
				dto.setBuildingName(rs.getString("buildingName"));
				dto.setArea(rs.getString("area"));
				dto.setDealamount(rs.getString("dealamount"));
				dto.setFloor(rs.getString("floor"));
				dto.setBuildYear(rs.getString("buildYear"));
				dto.setRoadname(rs.getString("roadname"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
			DBUtil.close(conn);
		}
		return list;
	}
	
	
}
