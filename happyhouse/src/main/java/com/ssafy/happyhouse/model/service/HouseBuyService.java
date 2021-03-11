package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.HouseBuyDto;

public interface HouseBuyService {
	List<HouseBuyDto> getHouseBuyInfo(String Dong) throws Exception;
}
