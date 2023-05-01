package com.ssafy.tourist.model.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.tourist.model.AttractionInfoDto;

public interface TouristMapper {
	/**
	 * sido_code와 gugun_code로 관광지 리스트 불러오는 메소드
	 */
	List<AttractionInfoDto> listTourist(Map<String, Integer> param) throws SQLException;
//	    List<AttractionInfoDto> getTouristList(int sidoCode, int gugunCode, int contentTypeId) throws SQLException;
//	List<AttractionInfoDto> listTourist(int sidoCode, int gugunCode, int contentTypeId) throws SQLException;
}
