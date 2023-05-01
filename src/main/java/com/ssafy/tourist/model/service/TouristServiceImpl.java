package com.ssafy.tourist.model.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.tourist.model.AttractionInfoDto;
import com.ssafy.tourist.model.mapper.TouristMapper;

public class TouristServiceImpl implements TouristService {

	private TouristMapper touristMapper;
	
	public TouristServiceImpl(TouristMapper touristMapper) {
		super();
		this.touristMapper = touristMapper;
	}

	@Override
	public List<AttractionInfoDto> listTourist(Map<String, Integer> param) throws SQLException {
		return touristMapper.listTourist(param);
	}
	
}
