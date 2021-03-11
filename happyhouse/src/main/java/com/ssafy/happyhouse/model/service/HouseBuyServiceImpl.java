package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dto.HouseBuyDto;
import com.ssafy.happyhouse.model.repo.HouseBuyRepoImpl;

@Service
public class HouseBuyServiceImpl implements HouseBuyService{

private static HouseBuyService houseBuyService;
	
	private HouseBuyServiceImpl() {}
	
	public static HouseBuyService getHouseBuyService() {
		if(houseBuyService == null)
			houseBuyService = new HouseBuyServiceImpl();
		return houseBuyService;
	}
	
	@Override
	public List<HouseBuyDto> getHouseBuyInfo(String Dong) throws Exception {
		return HouseBuyRepoImpl.getHouseMapDao().getHouseBuyInfo(Dong);
	}

}
