package com.ssafy.happyhouse.model.repo;

import java.util.List;

import com.ssafy.happyhouse.model.dto.HouseBuyDto;

public interface HouseBuyRepo {

	List<HouseBuyDto> getHouseBuyInfo(String Dong) throws Exception;

}
