package org.crud_ex.mapper;

import org.crud_ex.domain.Member;

public interface MemberMapper {

	// 회원 조회 (로그인용)
	Member findByUserId(String userId);

	// 회원 가입
	int save(Member member);

	// 회원 정보 수정
	int update(Member member);

	// 회원 탈퇴
	int delete(String userId);

	// 아이디 중복 체크
	int existsByUserId(String userId);
}
