package org.crud_ex.service;

import java.util.List;

import org.crud_ex.domain.Reply;
import org.crud_ex.mapper.ReplyMapper;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService {

	private final ReplyMapper replyMapper;

	@Override
	public List<Reply> getReplyList(Long boardId) {
		return replyMapper.findAll(boardId);
	}

	@Override
	public List<Reply> getMyReplyList(String replyer) {
		return replyMapper.findByReplyer(replyer);
	}

	@Override
	public Reply getReply(Long replyId) {
		return replyMapper.findOne(replyId);
	}

	@Override
	public void register(Reply reply) {
		replyMapper.save(reply);
	}

	@Override
	public boolean modify(Reply reply) {
		return replyMapper.update(reply) == 1;
	}

	@Override
	public boolean remove(Long replyId) {
		return replyMapper.delete(replyId) == 1;
	}

	@Override
	public int getReplyCount(Long boardId) {
		return replyMapper.getCountByBoardId(boardId);
	}
}
