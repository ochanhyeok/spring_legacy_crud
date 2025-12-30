package org.crud_ex.controller;

import org.crud_ex.domain.Board;
import org.crud_ex.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
@Slf4j
public class BoardController {

	private final BoardService boardService;

	// 목록
	@GetMapping("/list")
	public String list(Model model) {
		log.info("board list...");
		model.addAttribute("list", boardService.getBoardList());
		return "board/list";
	}

	// 등록 페이지
	@GetMapping("/register")
	public String registerForm() {
		log.info("board register form...");
		return "board/register";
	}

	// 등록 처리
	@PostMapping("/register")
	public String register(Board board, RedirectAttributes redirectAttributes) {
		log.info("board register:{}", board);
		boardService.register(board);
		redirectAttributes.addFlashAttribute("result", board.getBoardId());
		return "redirect:/board/list";
	}

	// 상세 조회
	@GetMapping("/get")
	public String get(@RequestParam("boardId") Long boardId, Model model) {
		log.info("board get:{}", boardId);
		model.addAttribute("board", boardService.getBoard(boardId));
		return "board/get";
	}

	// 수정 페이지
	@GetMapping("/modify")
	public String modifyForm(@RequestParam("boardId") Long boardId, Model model) {
		log.info("board modify form:{}", boardId);
		model.addAttribute("board", boardService.getBoard(boardId));
		return "board/modify";
	}

	// 수정 처리
	@PostMapping("/modify")
	public String modify(Board board, RedirectAttributes redirectAttributes) {
		log.info("board modify:{}", board);
		if (boardService.modify(board)) {
			redirectAttributes.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}

	// 삭제 처리
	@PostMapping("/remove")
	public String remove(@RequestParam("boardId") Long boardId, RedirectAttributes redirectAttributes) {
		log.info("board remove:{}", boardId);
		if (boardService.remove(boardId)) {
			redirectAttributes.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
}
