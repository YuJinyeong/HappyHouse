package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dto.Member;
import com.ssafy.happyhouse.model.repo.MemberRepo;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private SqlSession sqlSession;

	// login 완료
	public Member login(Map<String, String> map) throws Exception {
		// 원ㄹㅐDb거쳐서 연동
		String id = map.get("id");
		String pass = map.get("passwd");
		// connection : auto closeable , AutoClose 를 상속받고 있어요.
		if (id == null || pass == null)
			throw new Exception();

		Member member = sqlSession.getMapper(MemberRepo.class).login(map);
		return member;
	}

	@Override
	public Member selectService(String id) throws SQLException {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(MemberRepo.class).select(id);
	}

	@Override
	public int register(Member member) throws Exception {
		int result =0 ;
		try {
			if (member.getId() == null || member.getPasswd() == null || member.getName() == null
					|| member.getName() == null) {
				throw new Exception();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		result = sqlSession.getMapper(MemberRepo.class).insert(member);
		return result;
	}

	@Override
	public int edit(Member member) throws SQLException {
		// TODO Auto-generated method stub
		int result =0 ;
		result = sqlSession.getMapper(MemberRepo.class).update(member);
		return result;
	}

	@Override
	public int delete(String id) throws SQLException {
		// TODO Auto-generated method stub
		int result =0 ;
		result = sqlSession.getMapper(MemberRepo.class).delete(id);
		return result;
	}

}
