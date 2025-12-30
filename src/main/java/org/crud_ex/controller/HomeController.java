package org.crud_ex.controller;

import javax.servlet.http.HttpSession;

import org.crud_ex.domain.Member;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	@GetMapping("/")
	public String home(HttpSession session) {
		// 로그인 상태 확인
		Member loginUser = (Member)session.getAttribute("loginUser");

		if (loginUser != null) {
			return "redirect:/board/list";
		} else {
			return "redirect:/member/login";
		}
	}
}
