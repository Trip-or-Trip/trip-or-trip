package com.ssafy.user.controller;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ssafy.mail.model.MailDto;
import com.ssafy.user.model.UserDto;
import com.ssafy.user.model.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	private final Logger logger = LoggerFactory.getLogger(UserController.class);

	private UserService userService;
//	private RSAUtil rsaUtil;

	private static String RSA_WEB_KEY = "_RSA_WEB_Key_"; // 개인키 session key
	private static String RSA_INSTANCE = "RSA"; // rsa transformation

	public UserController(UserService userService) {
		super();
		this.userService = userService;
	}

	/**
	 * 복호화
	 */
	private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
		Cipher cipher = Cipher.getInstance(RSA_INSTANCE);
		byte[] encryptedBytes = hexToByteArray(securedValue);
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
		String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의
		return decryptedValue;
	}

	/**
	 * 16진 문자열을 byte 배열로 변환
	 */
	public byte[] hexToByteArray(String hex) {
		if (hex == null || hex.length() % 2 != 0) {
			return new byte[] {};
		}

		byte[] bytes = new byte[hex.length() / 2];
		for (int i = 0; i < hex.length(); i += 2) {
			byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
			bytes[(int) Math.floor(i / 2)] = value;
		}
		return bytes;
	}

	/**
	 * rsa 공개키, 개인키 생성
	 */
	public Map<String, String> initRsa(HttpSession session) {
		KeyPairGenerator generator;
		try {
			generator = KeyPairGenerator.getInstance(RSA_INSTANCE);
			generator.initialize(1024);

			KeyPair keyPair = generator.genKeyPair();
			KeyFactory keyFactory = KeyFactory.getInstance(RSA_INSTANCE);
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();
			
			if(session.getAttribute(RSA_WEB_KEY) != null) {
				session.removeAttribute(RSA_WEB_KEY);
			}
			session.setAttribute(RSA_WEB_KEY, privateKey);

			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			String publicKeyModulus = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);

			Map<String, String> map = new HashMap<String, String>();
			map.put("RSAModulus", publicKeyModulus); // rsa modulus 를 request 에 추가
			map.put("RSAExponent", publicKeyExponent); // rsa exponent 를 request 에 추가
			
			return map;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@GetMapping("signin")
	public String signin(HttpSession session, Model model) {
		Map<String, String> map = initRsa(session);
		model.addAttribute("RSAModulus", map.get("RSAModulus"));
		model.addAttribute("RSAExponent", map.get("RSAExponent"));
		
		logger.debug("encode ready : {}, {}", map.get("RSAModulus"), map.get("RSAExponent"));
		
		return "user/signin";
	}

	@PostMapping("signin")
	public String signin(UserDto userDto, @RequestParam Map<String, String> map, HttpSession session, RedirectAttributes redirectAttributes) {
		logger.debug("signin user: {}", userDto.toString());
		
		PrivateKey privateKey = (PrivateKey) session.getAttribute(RSA_WEB_KEY);
		String id = "", password = "";
		
		// 복호화
//		try {
//			id = decryptRsa(privateKey, userDto.getId());
//			password = decryptRsa(privateKey, userDto.getPassword());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
//		logger.debug("signin user encode: {}, {}", userDto.getId(), userDto.getPassword());
//		logger.debug("signin user decode: {}, {}", id, password);		
		id = userDto.getId();
		password = userDto.getPassword();
		
		try {
			UserDto user = userService.signinUser(id, password);
			if (user != null) {
				session.setAttribute("userinfo", user);
				return "redirect:/";
			}
//			else {
//				redirectAttributes.addAttribute("msg", "로그인을 실패했습니다. 다시 시도해 주세요.");
//				return "redirect:/user/signin";
//			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "로그인을 실패했습니다. 다시 시도해 주세요.");
		return "redirect:/user/signin";
	}
	
	@GetMapping("/signout")
	public String signout(HttpSession session) {
		session.removeAttribute("userinfo");
		return "redirect:/";
	}
	
	@GetMapping("/signup")
	public String signup() {
		return "user/signup";
	}
	
	@PostMapping("/signup")
	public String signup(UserDto userDto, @RequestParam Map<String, String> map, HttpSession session, RedirectAttributes redirectAttributes) {
		logger.debug("signup user: {}", userDto.toString());
		
//		PrivateKey privateKey = (PrivateKey) session.getAttribute(RSA_WEB_KEY);
		String id = "", password = "", name = "", email = "";
		
		// 복호화
//		try {
//			id = decryptRsa(privateKey, userDto.getId());
//			password = decryptRsa(privateKey, userDto.getPassword());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
//		logger.debug("signin user encode: {}, {}", userDto.getId(), userDto.getPassword());
//		logger.debug("signin user decode: {}, {}", id, password);		
		
		try {
			int result = userService.signupUser(userDto);
			if(result == 1) {
				redirectAttributes.addFlashAttribute("msg", "회원가입이 정상적으로 완료됐습니다.");
				return "redirect:/";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "회원가입을 실패했습니다. 다시 시도해 주세요.");
		return "redirect:/user/signup";
	}
	
	@GetMapping("/idcheck/{id}")
	@ResponseBody
	public String idcheck(@PathVariable("id") String id) throws Exception {
		logger.debug("idCheck userid : {}", id);
		int cnt = userService.idCheck(id);
		return cnt + "";
	}
	
	@GetMapping("/delete/{id}")
	public String delete(@PathVariable("id") String id, HttpSession session, RedirectAttributes redirectAttributes) throws Exception {
		logger.debug("delete user : {}", id);
		int result = userService.deleteUser(id);
		if(result == 1) {
			redirectAttributes.addFlashAttribute("msg", "회원 탈퇴가 정상적으로 완료됐습니다.");
			session.invalidate();
		}
		else {
			redirectAttributes.addFlashAttribute("msg", "회원 탈퇴 중 문제가 생겼습니다. 다시 시도해 주세요.");
		}
		return "redirect:/";
	}
	
	@PostMapping("/update")
	public String update(UserDto userDto, RedirectAttributes redirectAttributes) throws Exception {
		logger.debug("update user: {}", userDto.toString());
		
		int result = userService.updateUser(userDto);
		if(result == 1) {
			redirectAttributes.addFlashAttribute("msg", "회원 정보 수정이 정상적으로 완료됐습니다.");
		}
		else {
			redirectAttributes.addFlashAttribute("msg", "회원 정보 수정 중 문제가 생겼습니다. 다시 시도해 주세요.");
		}
		return "redirect:/";
	}
	
	@GetMapping("/password")
	public String password() {
		return "user/password";
	}
	
	@GetMapping("/password/{name}/{emailId}/{emailDomain}")
	@Transactional
	public String password(@PathVariable("name") String name, @PathVariable("emailId") String emailId, @PathVariable("emailDomain") String emailDomain, RedirectAttributes redirectAttributes) throws SQLException {
		logger.debug("find password : {}, {}, {}", name, emailId, emailDomain);
		
		UserDto userDto = userService.findUser(name, emailId, emailDomain);
		
		if(userDto == null) {
			redirectAttributes.addFlashAttribute("msg", "입력하신 정보와 일치하는 사용자가 없습니다. 다시 시도해 주세요.");
			return "redirect:/user/password";
		}
		else {
			MailDto mailDto = userService.createMailAndChangePassword(userDto.getId(), name, emailId, emailDomain);
			userService.sendEmail(mailDto);
			redirectAttributes.addFlashAttribute("msg", "입력하신 이메일로 임시 비밀번호를 발송했습니다.");
			return "redirect:/user/signin";
		}
	}
}
