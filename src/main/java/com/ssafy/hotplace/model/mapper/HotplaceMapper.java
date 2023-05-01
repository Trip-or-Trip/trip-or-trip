package com.ssafy.hotplace.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.hotplace.model.HotplaceDto;

@Mapper
public interface HotplaceMapper {
//	List<HotplaceDto> listHotplace(Map<String, Object> param) throws Exception;
	List<HotplaceDto> listHotplace() throws Exception;
//	int getTotalHotplaceCount(Map<String, Object> param) throws Exception;
//	int findLatestNum() throws Exception;
	int insertHotplace(HotplaceDto hotplaceDto) throws Exception;
}
