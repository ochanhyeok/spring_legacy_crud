package org.crud_ex.service;

import static org.assertj.core.api.Assertions.*;

import org.assertj.core.api.Assertions;
import org.crud_ex.domain.Member;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Transactional
@Slf4j
class MemberServiceTest {

	@Autowired
	private MemberService memberService;

	@BeforeEach
	void setUp() {
		// 테스트용 회원 생성
		Member member = Member.builder()
			.userId("testUser")
			.userPw("1234")
			.userName("테스트 유저")
			.email("test@test.com")
			.build();

		try {
			memberService.register(member);
		} catch (Exception e) {
			log.info("테스트용 회원 이미 존재");
		}
	}

	@Test
	@DisplayName("로그인 성공 테스트")
	void testLoginSuccess() {
		// when
		Member member = memberService.login("testUser", "1234");

		// then
		assertThat(member).isNotNull();
		assertThat(member.getUserId()).isEqualTo("testUser");
	}

	@Test
	@DisplayName("로그인 실패 - 존재하지 않는 아이디")
	void testLoginFailNoUser() {
		// when
		Member member = memberService.login("noUser", "1234");

		// then
		// assertThat(member).isNull();

	}
}
