package org.crud_ex.service;

import java.util.List;

import org.crud_ex.domain.Board;
import org.crud_ex.mapper.BoardMapper;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

	private final BoardMapper boardMapper;

	@Override
	public List<Board> getBoardList() {
		return boardMapper.findAll();
	}

	@Override
	public Board getBoard(Long boardId) {
		return boardMapper.findOne(boardId);
	}

	@Override
	public void register(Board board) {
		boardMapper.save(board);
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
	public int getTotalCount() {
		return boardMapper.getTotalCount();
	}
}
