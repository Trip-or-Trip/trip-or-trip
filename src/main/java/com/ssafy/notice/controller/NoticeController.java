package com.ssafy.notice.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.notice.model.NoticeDto;
import com.ssafy.notice.model.service.NoticeService;
import com.ssafy.user.model.UserDto;
import com.ssafy.util.PageNavigation;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private ServletContext servletContext;
	
	private NoticeService noticeService;
	
	@Autowired
	public NoticeController(NoticeService noticeService) {
		super();
		this.noticeService = noticeService;
	}

	@GetMapping("list")
	private ModelAndView list(@RequestParam Map<String, String> map) {
		ModelAndView mav = new ModelAndView();
		List<NoticeDto> list;
		try {
			list = noticeService.listArticle(map);
			mav.addObject("articles", list);
			
			PageNavigation pageNavigation = noticeService.makePageNavigation(map);
			mav.addObject("navigation", pageNavigation);
			
			mav.addObject("pgno", map.get("pgno"));
			mav.addObject("key", map.get("key"));
			mav.addObject("word", map.get("word"));
			
			mav.setViewName("notice/list");
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("msg", "글목록 출력 중 문제 발생!!!");
			mav.setViewName("error/error");
			return mav;
		}
	}
	
	@GetMapping("/view")
	private String view(@RequestParam("articleno") int articleNo, @RequestParam Map<String, String> map, Model model) {
		try {
			NoticeDto noticeDto = noticeService.getArticle(articleNo);
			noticeService.updateHit(articleNo);
			model.addAttribute("article", noticeDto);
			
			PageNavigation pageNavigation = noticeService.makePageNavigation(map);
			model.addAttribute("navigation", pageNavigation);
			
			model.addAttribute("pgno", map.get("pgno"));
			model.addAttribute("key", map.get("key"));
			model.addAttribute("word", map.get("word"));
			
			return "/notice/view";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "글내용 출력 중 문제 발생!!!");
			return "/error/error";
		}
	}

	@GetMapping("/write")
	private String write(@RequestParam Map<String, String> map, Model model) {
		//TODO: Interceptor 에 해당 메서드 추가해줘야함!! 로그인 한 멤버만 글 작성 가능
		PageNavigation pageNavigation;
		try {
			pageNavigation = noticeService.makePageNavigation(map);
			model.addAttribute("navigation", pageNavigation);
			
			model.addAttribute("pgno", map.get("pgno"));
			model.addAttribute("key", map.get("key"));
			model.addAttribute("word", map.get("word"));
			
			return "/notice/write";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "게시글 작성 페이지 이동 중 에러 발생!");
			return "error/error";
		}
		
	}
	
	@PostMapping("/write")
	private String write(NoticeDto noticeDto, HttpSession session, Model model) {
		//TODO: Interceptor 에 해당 메서드 추가해줘야함!! 로그인 한 멤버만 글 작성 가능
		UserDto userDto = (UserDto) session.getAttribute("userinfo");
		noticeDto.setUserId(userDto.getId());
		System.out.println(noticeDto.toString());
		try {
			noticeService.writeArticle(noticeDto);
			return "redirect:/notice/list?pgno=1&key=&word="; //게시글 작성 후 list의 첫번째 페이지로 이동
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "글 작성 중 에러 발생!");
			return "/error/error";
		}
		
	}

	@GetMapping("/modify")
	private String modify(@RequestParam("articleno") int articleNo, Model model) {
		//TODO: Interceptor 에 해당 메서드 추가해줘야함!! 로그인 한 멤버만 글 수정 가능
		try {
			NoticeDto noticeDto = noticeService.getArticle(articleNo);
			model.addAttribute("article", noticeDto);
			return "/notice/modify";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "게시글 수정 페이지 로드 중 에러 발생");
			return "/error/error";
		}
		
	}
	
	@PostMapping("/modify")
	private String modify(@RequestParam("articleno") int articleNo, NoticeDto noticeDto, Model model) {
		//TODO: Interceptor 에 해당 메서드 추가해줘야함!! 로그인 한 멤버만 글 수정 가능
		try {
			// 게시글 변경
			noticeDto.setId(articleNo);
			noticeService.modifyArticle(noticeDto);
			return "redirect:/notice/view?articleno="+articleNo+"&pgno=1&key=&word=";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "게시글 수정 중 에러 발생");
			return "/error/error";
		}
		
	}

	@GetMapping("/delete")
	private String delete(@RequestParam("articleno") int articleNo, HttpSession session, Model model) {
		//TODO: Interceptor 에 해당 메서드 추가해줘야함!! 로그인 한 멤버만 글 삭제 가능(게시글작성자랑 동일한 경우에만)
		UserDto userDto = (UserDto) session.getAttribute("userinfo");
		try {
			NoticeDto noticeDto = noticeService.getArticle(articleNo);
			if(noticeDto.getUserId().equals(userDto.getId()) || userDto.getId().equals("admin")) {
				noticeService.deleteArticle(articleNo);
				// 게시글 변경 후 응답처리?
				return "redirect:/noitce/list?pgno=1&key=&word=";
			}else {
				model.addAttribute("msg", "본인의 게시글만 삭제 가능합니다.");
				return "error/error";
			}
		} catch (Exception e1) {
			e1.printStackTrace();
			model.addAttribute("msg", "게시글이 삭제되었거나 존재하지 않습니다.");
			return "error/error";
		}
		
	}

}