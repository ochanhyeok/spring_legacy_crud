package org.crud_ex.service;

import org.crud_ex.domain.Member;
import org.crud_ex.mapper.MemberMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;

	@Override
	@Transactional(readOnly = true)
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
	@Transactional(readOnly = true)
	public boolean checkDuplicate(String userId) {
		return memberMapper.existsByUserId(userId) > 0;
	}

	@Override
	@Transactional(readOnly = true)
	public Member login(String userId, String userPw) {
		log.info("로그인 시도: userId={}", userId);

		// 회원 조회
		Member member = memberMapper.findByUserId(userId);

		// 아이디 존재 여부 확인
		if (member == null) {
			log.warn("로그인 실패: 존재하지 않는 아이디 - userId={}", userId);
			return null;
		}

		// 비밀번호 확인
		if (!member.getUserPw().equals(userPw)) {
			log.warn("로그인 실패: 비밀번호 불일치 - userId={}", userId);
			return null;
		}

		// 로그인 성공
		log.info("로그인 성공: userId={}", userId);
		return member;
	}
}
