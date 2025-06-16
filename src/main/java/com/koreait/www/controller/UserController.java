package com.koreait.www.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.www.domain.UserVO;
import com.koreait.www.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/user/*")
@RequiredArgsConstructor
@Controller
public class UserController {

	private final UserService usv;
	private final BCryptPasswordEncoder bcEncoder;

	@GetMapping("/register")
	public void register() {
	}

	@PostMapping("/register")
	public String register(UserVO uvo) {

		log.info(">>>> user vo >> {}", uvo);

		uvo.setPwd(bcEncoder.encode(uvo.getPwd()));
		int isOk = usv.insert(uvo);
		return "redirect:/";
	}

	@GetMapping("/login")
	public void login() {
	}

	@PostMapping("/login")
	public String login(HttpServletRequest request, RedirectAttributes re) {

		log.info(">>>> email >> {}", request.getAttribute("email").toString());
		log.info(">>>> errorMessage >> {}", request.getAttribute("errorMessage"));
		re.addFlashAttribute("email", request.getAttribute("email"));
		re.addFlashAttribute("errorMessage", request.getAttribute("errorMessage"));

		return "redirect:/user/login";
	}

	@GetMapping("/modify")
	public void modify() {
	}

	@PostMapping("/modify")
	public String modify(UserVO uvo, RedirectAttributes re, HttpServletRequest request, HttpServletResponse response) {
		log.info(">>>> modify uvo >> {}", uvo);
		int isOk = 0;
		if (uvo.getPwd().isEmpty() || uvo.getPwd().length() == 0) {

			isOk = usv.modifyPwdEmpty(uvo);

		} else {

			uvo.setPwd(bcEncoder.encode(uvo.getPwd()));
			isOk = usv.modify(uvo);
		}

		logout(request, response);

		String msg = (isOk > 0) ? "ok" : "fail";
		re.addFlashAttribute("modify_msg", msg);

		return "redirect:/";
	}

	@GetMapping("/remove")
	public String remove(Principal principal, RedirectAttributes re, HttpServletRequest request,
			HttpServletResponse response) {
		String email = principal.getName();
		int isOk = usv.delete(email);
		logout(request, response);
		String msg = (isOk > 0) ? "ok" : "fail";
		re.addFlashAttribute("remove_msg", msg);
		return "redirect:/";
	}

	@GetMapping("/list")
	public void list(Model m) {
		List<UserVO> userList = usv.getList();
		m.addAttribute("userList", userList);

	}

	private void logout(HttpServletRequest request, HttpServletResponse response) {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		new SecurityContextLogoutHandler().logout(request, response, authentication);
	}

}
