package com.ssafy.tourist.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.tourist.model.AttractionInfoDto;
import com.ssafy.tourist.model.service.TouristService;

@RequestMapping("/tourist")
public class TouristController {

    private TouristService touristService;

    public TouristController(TouristService touristService) {
		super();
		this.touristService = touristService;
	}
    
    @GetMapping("/region")
    public String region() {
    	return "tourist/region";
    }
    
    @GetMapping("/search")
    public String search(@RequestParam Map<String, Integer> param, Model model) throws SQLException {
    	List<AttractionInfoDto> list = touristService.listTourist(param);
    	
    	model.addAttribute("attractions", list);
    	
    	return "tourist/region";
    }
    
}
