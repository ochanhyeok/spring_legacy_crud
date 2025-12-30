package org.crud_ex.service;

import java.util.List;

import org.crud_ex.domain.Reply;
import org.crud_ex.mapper.ReplyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class ReplyServiceImpl implements ReplyService {

	private final ReplyMapper replyMapper;

	@Override
	@Transactional(readOnly = true)
	public List<Reply> getReplyList(Long boardId) {
		return replyMapper.findByBoardId(boardId);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Reply> getMyReplyList(String replyer) {
		return replyMapper.findByReplyer(replyer);
	}

	@Override
	@Transactional(readOnly = true)
	public Reply getReply(Long replyId) {
		return replyMapper.findOne(replyId);
	}

	@Override
	public Long register(Reply reply) {
		replyMapper.save(reply);
		return reply.getReplyId();
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
	@Transactional(readOnly = true)
	public int getReplyCount(Long boardId) {
		return replyMapper.getCountByBoardId(boardId);
	}
}
