package org.crud_ex.service;

import java.util.List;

import org.crud_ex.domain.Reply;

public interface ReplyService {

	// 특정 게시글의 댓글 목록 조회
	List<Reply> getReplyList(Long boardId);

	// 내가 작성한 댓글 조회
	List<Reply> getMyReplyList(String replyer);

	// 댓글 단건 조회
	Reply getReply(Long replyId);

	// 댓글 등록
	void register(Reply reply);

	// 댓글 수정
	boolean modify(Reply reply);

	// 댓글 삭제
	boolean remove(Long replyId);

	// 특정 게시글의 댓글 개수
	int getReplyCount(Long boardId);
}
