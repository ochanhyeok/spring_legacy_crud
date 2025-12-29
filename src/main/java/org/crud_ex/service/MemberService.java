package org.crud_ex.service;

import org.crud_ex.domain.Member;

public interface MemberService {

	// 회원 조회 (로그인용)
	Member getMember(String userId);

	// 회원 가입
	void register(Member member);

	// 회원 정보 수정
	boolean modify(Member member);

	// 회원 탈퇴
	boolean remove(String userId);

	// 아이디 중복 체크
	boolean checkDuplicate(String userId);
}
