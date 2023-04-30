package com.ssafy.hotplace.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.hotplace.model.HotplaceDto;
import com.ssafy.util.PageNavigation;

public interface HotplaceService {
//	List<HotplaceDto> listHotplace(Map<String, String> map) throws Exception;
	List<HotplaceDto> listHotplace() throws Exception;
//	PageNavigation makePageNavigation(Map<String, String> map) throws Exception;
//	int findLatestNum() throws Exception;
	int insertHotplace(HotplaceDto hotplaceDto) throws Exception;
}
