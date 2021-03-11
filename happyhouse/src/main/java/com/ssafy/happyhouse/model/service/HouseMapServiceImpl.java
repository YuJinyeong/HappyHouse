package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.repo.HouseMapRepoImpl;

@Service
public class HouseMapServiceImpl implements HouseMapService {
	
	private static HouseMapService houseMapService;
	
	private HouseMapServiceImpl() {}
	
	public static HouseMapService getHouseMapService() {
		if(houseMapService == null)
			houseMapService = new HouseMapServiceImpl();
		return houseMapService;
	}

	@Override
	public List<SidoGugunCodeDto> getSido() throws Exception {
		return HouseMapRepoImpl.getHouseMapDao().getSido();
	}

	@Override
	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception {
		return HouseMapRepoImpl.getHouseMapDao().getGugunInSido(sido);
	}

	@Override
	public List<HouseInfoDto> getDongInGugun(String gugun) throws Exception {
		return HouseMapRepoImpl.getHouseMapDao().getDongInGugun(gugun);
	}

	@Override
	public List<HouseInfoDto> getAptInDong(String dong) throws Exception {
		return HouseMapRepoImpl.getHouseMapDao().getAptInDong(dong);
	}
	@Override
	public List<HouseDealDto> getApt2InApt(String apt,String jibun) throws Exception {
		return HouseMapRepoImpl.getHouseMapDao().getApt2InApt(apt,jibun);
	}

}
