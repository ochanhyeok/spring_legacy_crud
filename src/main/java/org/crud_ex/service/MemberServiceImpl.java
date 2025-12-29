package org.crud_ex.service;

import org.crud_ex.domain.Member;
import org.crud_ex.mapper.MemberMapper;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;

	@Override
	public Member getMember(String userId) {
		return memberMapper.findByUserId(userId);
	}

	@Override
	public void register(Member member) {
		memberMapper.save(member);
	}

	@Override
	public boolean modify(Member member) {
		return memberMapper.update(member) == 1;
	}

	@Override
	public boolean remove(String userId) {
		return memberMapper.delete(userId) == 1;
	}

	@Override
	public boolean checkDuplicate(String userId) {
		return memberMapper.existsByUserId(userId) > 0;
	}
}
