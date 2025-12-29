package org.crud_ex.service;

import java.util.List;

import org.crud_ex.domain.Board;

public interface BoardService {

	// 목록 조회
	List<Board> getBoardList();

	// 상세 조회
	Board getBoard(Long boardId);

	// 등록
	void register(Board board);

	// 수정
	boolean modify(Board board);

	// 삭제
	boolean remove(Long boardId);

	// 총 개수
	int getTotalCount();
}
