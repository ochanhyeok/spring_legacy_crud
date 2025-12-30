package org.crud_ex.service;

import org.crud_ex.domain.Member;
import org.crud_ex.domain.Reply;
import org.crud_ex.mapper.MemberMapper;
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
public class ReplyServiceTest {

	@Autowired
	private ReplyService replyService;

	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private MemberService memberService;

	@BeforeEach
	void setUp() {
		// 테스트용 Member 생성
		Member member = Member.builder()
			.userId("testUser")
			.userPw("1234")
			.userName("테스트유자")
			.email("test@test.com")
			.build();

		try {
			memberService.register(member);
			log.info("테스트용 Member 생성: {}", member.getUserId());
		} catch (Exception e) {
			log.info("테스트용 Member 이미 존재");
		}
	}

	@Test
	@DisplayName("댓글 등록 서비스 테스트")
	void testRegister() {
		// given
		Reply reply = Reply.builder()
			.boardId(1L)
			.content("서비스 테스트 댓글")
			.replyer("testUser")
			.build();

		// when
		Long registerId = replyService.register(reply);
	}
}
