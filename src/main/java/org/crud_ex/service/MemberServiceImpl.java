package org.crud_ex.service;

import org.crud_ex.domain.Member;
import org.crud_ex.exception.DuplicateUserException;
import org.crud_ex.exception.LoginFailedException;
import org.crud_ex.mapper.MemberMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
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
	private final PasswordEncoder passwordEncoder;

	@Override
	@Transactional(readOnly = true)
	public Member getMember(String userId) {
		return memberMapper.findByUserId(userId);
	}

	@Override
	public void register(Member member) {
		if (checkDuplicate(member.getUserId())) {
			throw new DuplicateUserException("이미 존재하는 아이디입니다.");
		}

		// 비밀번호 암호화
		String encodePassword = passwordEncoder.encode(member.getUserPw());
		member.setUserPw(encodePassword);

		log.info("회원가입: userId{}, 암호화된 비밀번호 길이={}", member.getUserId(), encodePassword.length());
		memberMapper.save(member);
	}

	@Override
	public boolean modify(Member member) {
		// 비밀번호 수정 시에도 암호화
		String encodePassword = passwordEncoder.encode(member.getUserPw());
		member.setUserPw(encodePassword);

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
			throw new LoginFailedException("존재하지 않는 아이디입니다.");
		}

		// 비밀번호 확인
		if (!passwordEncoder.matches(userPw, member.getUserPw())) {
			log.warn("로그인 실패: 비밀번호 불일치 - userId={}", userId);
			throw new LoginFailedException("비밀번호가 일치하지 않습니다.");
		}

		// 로그인 성공
		log.info("로그인 성공: userId={}", userId);
		return member;
	}
}
