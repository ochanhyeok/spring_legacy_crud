package org.crud_ex.controller;

import java.util.List;

import org.crud_ex.domain.Reply;
import org.crud_ex.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.Builder;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@RequestMapping("/replies")
@Slf4j
@Builder
public class ReplyController {

	private final ReplyService replyService;

	// 댓글 목록 조회
	@GetMapping("/board/{boardId}")
	public ResponseEntity<List<Reply>> getList(@PathVariable("boardId") Long boardId) {
		log.info("getList boardId:{}", boardId);
		return new ResponseEntity<>(replyService.getReplyList(boardId), HttpStatus.OK);
	}

	// 댓글 단건 조회
	@GetMapping("/{replyId}")
	public ResponseEntity<Reply> get(@PathVariable("replyId") Long replyId) {
		log.info("get replyId:{}", replyId);
		return new ResponseEntity<>(replyService.getReply(replyId), HttpStatus.OK);
	}

	// 댓글 등록
	@PostMapping("")
	public ResponseEntity<String> register(@RequestBody Reply reply) {
		log.info("register reply:{}", reply);
		replyService.register(reply);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	// 댓글 수정
	@PutMapping("/{replyId}")
	public ResponseEntity<String> modify(@RequestParam("replyId") Long replyId, @RequestBody Reply reply) {
		log.info("modify replyId:{}", replyId);
		reply.setReplyId(replyId);
		return replyService.modify(reply) ? new ResponseEntity<>("success", HttpStatus.OK) :
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 댓글 삭제
	@DeleteMapping("/{replyId}")
	public ResponseEntity<String> remove(@PathVariable("replyId") Long replyId) {
		log.info("remove replyId:{}", replyId);
		return replyService.remove(replyId) ? new ResponseEntity<>("success", HttpStatus.OK) :
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
