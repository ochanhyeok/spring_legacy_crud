package org.crud_ex.service;

import java.util.List;

import org.crud_ex.domain.Board;
import org.crud_ex.domain.SearchCriteria;
import org.crud_ex.mapper.BoardMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class BoardServiceImpl implements BoardService {

	private final BoardMapper boardMapper;

	@Override
	@Transactional(readOnly = true)
	public List<Board> getBoardList() {
		return boardMapper.findAll();
	}

	@Override
	public List<Board> getSearchList(SearchCriteria criteria) {
		log.info("검색 조건:{}", criteria);
		return boardMapper.findBySearch(criteria);
	}

	@Override
	@Transactional(readOnly = true)
	public Board getBoard(Long boardId) {
		// 조회수 증가
		boardMapper.updateViewCnt(boardId);
		return boardMapper.findOne(boardId);
	}

	@Override
	public Long register(Board board) {
		boardMapper.save(board);
		return board.getBoardId();
	}

	@Override
	public boolean modify(Board board) {
		return boardMapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long boardId) {
		return boardMapper.delete(boardId) == 1;
	}

	@Override
	@Transactional(readOnly = true)
	public int getTotalCount() {
		return boardMapper.getTotalCount();
	}
}
