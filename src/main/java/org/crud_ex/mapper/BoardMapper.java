package org.crud_ex.mapper;

import java.util.List;

import org.crud_ex.domain.Board;

public interface BoardMapper {

	// 목록 조회
	List<Board> findAll();

	// 한 건 조회
	Board findOne(Long boardId);

	// 등록
	int save(Board board);

	// 수정
	int update(Board board);

	// 삭제
	int delete(Long boardId);

	// 총 개수 (페이징 용)
	int getTotalCount();
}
