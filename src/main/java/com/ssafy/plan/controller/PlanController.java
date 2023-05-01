package com.ssafy.plan.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ssafy.plan.model.PlaceDto;
import com.ssafy.plan.model.PlanDto;
import com.ssafy.plan.model.service.PlanService;
import com.ssafy.user.model.UserDto;
import com.ssafy.util.PageNavigation;
import com.ssafy.util.ParameterCheck;

@Controller
@RequestMapping("/plan")
public class PlanController {
	
	private final Logger logger = LoggerFactory.getLogger(PlanController.class);
	
	@Autowired
	private ServletContext servletContext;
	
	private PlanService planService;

	@Autowired
	public PlanController(PlanService planService) {
		super();
		this.planService = planService;
	}

	@GetMapping("mvplanlist")
	private ModelAndView mvPlanList(@RequestParam Map<String, String> map)
			throws ServletException, IOException {
		//TODO: userinfo가 되어있어야 접속 가능 : Intercpetor 추가해줘야 함
		ModelAndView mav = new ModelAndView();
		
		List<PlanDto> list;
		try {			
			list = planService.selectPlan(map);
			mav.addObject("articles", list);

			PageNavigation pageNavigation = planService.makePageNavigation(map);
			mav.addObject("navigation", pageNavigation);

			mav.addObject("pgno", map.get("pgno"));
			mav.addObject("key", map.get("key"));
			mav.addObject("word", map.get("word"));
			
			mav.setViewName("tourist/list");
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("/");
			return mav;
		}
	}
	
	/** 여행 계획 작성 페이지로 이동
	 * GetMapping으로 받아 이동한다.
	 * Interceptor에 본 메서드 추가하여, 로그인한 유저만 plan을 작성할 수 있게끔 한다.
	 * */
	@GetMapping("mvplan")
	private String mvPlan(@RequestParam Map<String, String> map, Model model) 
			throws ServletException, IOException {
		// TODO: userinfo가 되어있어야 접속 가능 : Intercpetor 추가해줘야 함
		// 목록으로 돌아가기를 누루면 해당 페이지로 회기해야 하므로 pgno, key, word를 들고 다녀야 한다
		model.addAttribute("pgno", map.get("pgno"));
		model.addAttribute("key", map.get("key"));
		model.addAttribute("word", map.get("word"));
		
		return "/tourist/plan";
	}

	/** form 에서 여행 계획을 저장한다고 submit을 할 때 호출 됨 */
	/*
	 * 파라미터로 넘어온 정보들로 여행 계획 데이터베이스에 저장 [여행지 계획] - 등록자(id) - 등록일 - 계획 이름 - 계획 id -
	 * 출발일 - 도착일 - 계획 상세
	 */
	@PostMapping("save")
	private String save(PlanDto planDto, PlaceDto[] placeDtos, HttpSession session, RedirectAttributes redirectAttributes) 
			throws ServletException, IOException {
		// TODO: 로그인 되어 있는지 확인 : Interceptor 사용해서 처리
		System.out.println(planDto.toString());
		System.out.println(placeDtos[0].toString());
		try {
			UserDto userDto = (UserDto) session.getAttribute("userinfo");
			planDto.setUserId(userDto.getId());

			// 1. 여행지 계획 담기
			planService.insertPlan(planDto);
			// 2. 여행지 정보 담기
			// 여행지 계획의 plan_id 가져오기
//			int planId = planService.selectPlanId(memberDto.getId(), title);
			for (PlaceDto placeDto : placeDtos) {
//				PlaceDto placeDto = new PlaceDto();
//				placeDto.setPlaceId(Integer.parseInt(placeIds[i]));
////				placeDto.setPlanId(planId);
//				placeDto.setName(names[i]);
//				placeDto.setAddress(addrs[i]);
//				placeDto.setLat(BigDecimal.valueOf(Double.parseDouble(lats[i])));
//				placeDto.setLng(BigDecimal.valueOf(Double.parseDouble(lngs[i])));
//				placeDto.setImageUrl(imageUrls[i]);
				planService.insertPlace(placeDto);
			}

			// POST 방식은 redirect로 보내야함 -> 그러면 get만 불러와서 새로고침해도 새로 저장되지 않음
			return "redirect:/plan/mvplan";
		} catch (Exception e) {
			e.printStackTrace();
			// list 페이지로 이동
			return "/";
		}
		
	}
	
	/** 여행 계획 상세보기 */ 
	@GetMapping("/view")
	private String view(@RequestParam("articleno") int articleNo, @RequestParam Map<String, String> map, Model model ) 
			throws ServletException, IOException {
		// 로그인 되어 있는지 확인 : Interceptor 사용해서 처리
		
		try {
			planService.updateHit(articleNo);
			PlanDto planDto = planService.selectPlanOne(articleNo);
			model.addAttribute("article", planDto);
			
			List<PlaceDto> list = planService.selectPlace(articleNo);
			model.addAttribute("places", list);
			
			List<PlaceDto> fastDistanceList = planService.selectFastDistancePlace(articleNo);
			model.addAttribute("fastPlaces", fastDistanceList);
			
			model.addAttribute("pgno", map.get("pgno"));
			model.addAttribute("key", map.get("key"));
			model.addAttribute("word", map.get("word"));
			
			return "/tourist/view";
		} catch (SQLException e) {
			e.printStackTrace();
			model.addAttribute("msg", "여행지 경로 출력 중 오류 발생!");
			return "/index";
		}
	}

}
