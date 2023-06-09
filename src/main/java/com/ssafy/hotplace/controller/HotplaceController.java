package com.ssafy.hotplace.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ssafy.hotplace.model.HotplaceDto;
import com.ssafy.hotplace.model.service.HotplaceService;
import com.ssafy.user.model.UserDto;
import com.ssafy.util.PageNavigation;
import com.ssafy.util.ParameterCheck;


@Controller
@RequestMapping("/hotplace")
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 50
)
public class HotplaceController {
	private final Logger logger = LoggerFactory.getLogger(HotplaceController.class);
	
	@Value("${file.path.hotplacePath}")
	private String hotplacePath;
	
	private HotplaceService hotplaceService;

	public HotplaceController(HotplaceService hotplaceService) {
		super();
		this.hotplaceService = hotplaceService;
	}

	@GetMapping("/list")
//	public String list(String pgno, Model model) {
	public String list(Model model) {
		try {
			logger.debug("hotplace list");
//			int page = ParameterCheck.notNumberToOne(pgno);
//			Map<String, String> map = new HashMap<>();
//			map.put("page", page + "");
			
//			List<HotplaceDto> list = hotplaceService.listHotplace(map);
			List<HotplaceDto> list = hotplaceService.listHotplace();
			
			model.addAttribute("hotplaces", list);
			
//			for(HotplaceDto hot: list)
//				System.out.println(hot.toString());
			
//			PageNavigation pageNavigation = hotplaceService.makePageNavigation(map);
//			model.addAttribute("navigation", pageNavigation);
			
			return "hotplace/list";
		}
		catch(Exception e) {
			e.printStackTrace();
			return "redirect:/";
		}
	}
	
	@PostMapping("/insert")
	@Transactional
	public String insert(HotplaceDto hotplaceDto, @RequestParam("hotplace-image") MultipartFile file, HttpSession session, RedirectAttributes redirectAttributes) {
		try {
			UserDto userDto = (UserDto) session.getAttribute("userinfo");
			hotplaceDto.setUserId(userDto.getId());
			logger.debug("write hotplaceDto : {}", hotplaceDto);
			
			logger.debug("MultipartFile.isEmpty : {}", file.isEmpty());
			if(!file.isEmpty()) {
//				String today = new SimpleDateFormat("yyMMdd").format(new Date());
//				String saveFolder = hotplacePath + File.separator + today;
				String saveFolder = hotplacePath;
				logger.debug("저장 폴더 : {}", saveFolder);
				File folder = new File(saveFolder);
				if (!folder.exists())
					folder.mkdirs();
				
				String originalFileName = file.getOriginalFilename();
				if (!originalFileName.isEmpty()) {
					String saveFileName = UUID.randomUUID().toString()
							+ originalFileName.substring(originalFileName.lastIndexOf('.'));
					hotplaceDto.setImage(saveFileName);
					logger.debug("원본 파일 이름 : {}, 실제 저장 파일 이름 : {}", file.getOriginalFilename(), saveFileName);
					file.transferTo(new File(folder, saveFileName));
				}
			}
			
			hotplaceService.insertHotplace(hotplaceDto);
			return "redirect:/hotplace/list";
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return "redirect:/hotplace/list";
	}
	
	@GetMapping("/keyword")
	public String keyword() {
		return "hotplace/keyword";
	}
	
	@GetMapping("/view/{num}")
	@ResponseBody
	public ResponseEntity<?> view(@PathVariable("num") String num) throws SQLException {
		HotplaceDto hotplaceDto = hotplaceService.viewHotplace(num);
		
		return new ResponseEntity<HotplaceDto>(hotplaceDto, HttpStatus.OK);
	}
	
	@PostMapping("/update")
	@Transactional
	public String update(HotplaceDto hotplaceDto, @RequestParam("hotplace-update-image") MultipartFile file, HttpSession session, RedirectAttributes redirectAttributes) throws SQLException, IllegalStateException, IOException {
		UserDto userDto = (UserDto) session.getAttribute("userinfo");
		hotplaceDto.setUserId(userDto.getId());
	
		logger.debug("update hotplace: {}", hotplaceDto);
		
		String originalImg = hotplaceService.findOriginalImage(String.valueOf(hotplaceDto.getNum()));
		
		logger.debug("MultipartFile.isEmpty : {}", file.isEmpty());
		if(!file.isEmpty()) {
//			String today = new SimpleDateFormat("yyMMdd").format(new Date());
//			String saveFolder = hotplacePath + File.separator + today;
			String saveFolder = hotplacePath;
			logger.debug("저장 폴더 : {}", saveFolder);
			File folder = new File(saveFolder);
			if (!folder.exists())
				folder.mkdirs();
			
			String originalFileName = file.getOriginalFilename();
			if (!originalFileName.isEmpty()) {
				String saveFileName = UUID.randomUUID().toString()
						+ originalFileName.substring(originalFileName.lastIndexOf('.'));
				hotplaceDto.setImage(saveFileName);
				logger.debug("원본 파일 이름 : {}, 실제 저장 파일 이름 : {}", file.getOriginalFilename(), saveFileName);
				file.transferTo(new File(folder, saveFileName));
			}
		}
		
		hotplaceService.updateHotplace(hotplaceDto);
		return "redirect:/hotplace/list";
	}
	
	@GetMapping("/delete/{num}")
	public String delete(@PathVariable("num") String num) throws SQLException {
		logger.debug("delete hotplace : {}", num);
		
		hotplaceService.deleteHotplace(num);
		
		return "redirect:/hotplace/list";
	}
}
