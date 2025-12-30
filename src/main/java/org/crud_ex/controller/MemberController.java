package org.crud_ex.controller;

import javax.servlet.http.HttpSession;

import org.crud_ex.domain.Member;
import org.crud_ex.service.MemberService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
@Slf4j
public class MemberController {

	private final MemberService memberService;

	// 회원가입 페이지
	@GetMapping("/register")
	public String registerForm() {
		log.info("member register form...");
		return "member/register";
	}

	// 회원가입 처리
	@PostMapping("/register")
	public String register(Member member, RedirectAttributes redirectAttributes) {
		log.info("member register: " + member);
		memberService.register(member);
		redirectAttributes.addFlashAttribute("result", "success");
		return "redirect:/member/login";
	}

	// 아이디 중복 체크 (AJAX)
	@GetMapping("/checkId")
	@ResponseBody
	public String checkId(@RequestParam("userId") String userId) {
		log.info("check userId: " + userId);
		boolean isDuplicate = memberService.checkDuplicate(userId);
		return isDuplicate ? "duplicate" : "available";
	}

	// 로그인 페이지
	@GetMapping("/login")
	public String loginForm() {
		log.info("member login form...");
		return "member/login";
	}

	// 로그인 처리
	@PostMapping("/login")
	public String login(@RequestParam("userId") String userId, @RequestParam("userPw") String userPw,
		HttpSession session, RedirectAttributes redirectAttributes) {
		log.info("로그인 요청: userId={}", userId);

		Member member = memberService.login(userId, userPw);

		if (member == null) {
			redirectAttributes.addFlashAttribute("error", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "redirect:/member/login";
		}

		session.setAttribute("loginUser", member);
		log.info("로그인 성공, 세션 저장 완료: userId={}", userId);

		return "redirect:/board/list";
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		log.info("member logout...");
		session.invalidate();
		return "redirect:/member/login";
	}

	// 회원정보 페이지
	@GetMapping("/info")
	public String info(HttpSession session, Model model) {
		log.info("member info...");
		Member loginUser = (Member)session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/member/login";
		}

		model.addAttribute("member", memberService.getMember(loginUser.getUserId()));
		return "member/info";
	}

	// 회원정보 수정 페이지
	@GetMapping("/modify")
	public String modifyForm(HttpSession session, Model model) {
		log.info("member modify form...");
		Member loginUser = (Member)session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/member/login";
		}

		model.addAttribute("member", memberService.getMember(loginUser.getUserId()));
		return "member/modify";
	}

	// 회원정보 수정 처리
	@PostMapping("/modify")
	public String modify(Member member, HttpSession session, RedirectAttributes redirectAttributes) {
		log.info("member modify: " + member);
		if (memberService.modify(member)) {
			// 세션 정보 업데이트
			session.setAttribute("loginUser", memberService.getMember(member.getUserId()));
			redirectAttributes.addFlashAttribute("result", "success");
		}
		return "redirect:/member/info";
	}

	// 회원탈퇴 처리
	@PostMapping("/remove")
	public String remove(HttpSession session, RedirectAttributes redirectAttributes) {
		log.info("member remove...");
		Member loginUser = (Member)session.getAttribute("loginUser");

		if (loginUser != null && memberService.remove(loginUser.getUserId())) {
			session.invalidate();
			redirectAttributes.addFlashAttribute("result", "탈퇴가 완료되었습니다.");
		}
		return "redirect:/member/login";
	}
}
