package org.crud_ex.mapper;

import java.util.List;

import org.crud_ex.domain.Reply;

public interface ReplyMapper {

	// 특정 게시글의 댓글 목록 조회
	List<Reply> findAll(Long boardId);

	// 내가 작성한 댓글 조회
	List<Reply> findByReplyer(String replyer);

	// 댓글 한 건 조회 (수정/삭제 전 확인용)
	Reply findOne(Long replyId);

	// 댓글 등록
	int save(Reply reply);

	// 댓글 수정
	int update(Reply reply);

	// 댓글 삭제
	int delete(Long replyId);

	// 특정 게시글의 댓글 개수
	int getCountByBoardId(Long boardId);
}
