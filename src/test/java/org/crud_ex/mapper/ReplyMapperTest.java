package org.crud_ex.mapper;

import static org.assertj.core.api.Assertions.*;

import java.util.List;

import org.crud_ex.domain.Member;
import org.crud_ex.domain.Reply;
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
class ReplyMapperTest {

	@Autowired
	private ReplyMapper replyMapper;
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private BoardMapper boardMapper;

	@BeforeEach
	void setUp() {
		// 테스트용 Member 생성
		Member member = Member.builder()
			.userId("testUser")
			.userPw("1234")
			.userName("테스트유저")
			.email("test@test.com")
			.build();

		// 이미 존재하는지 확인 후 생성
		try {
			memberMapper.save(member);
			log.info("테스트용 Member 생성: {}", member.getUserId());
		} catch (Exception e) {
			log.info("테스트용 Member 이미 존재");
		}
	}

	@Test
	@DisplayName("댓글 등록 테스트")
	void testSave() {
		// given
		Reply reply = Reply.builder()
			.boardId(1L)
			.content("테스트 댓글입니다.")
			.replyer("testUser")
			.build();

		// when
		int result = replyMapper.save(reply);

		// then
		assertThat(result).isEqualTo(1);
		assertThat(reply.getReplyId()).isNotNull();
		log.info("등록된 replyId: {}", reply.getReplyId());
	}

	@Test
	@DisplayName("댓글 단건 조회")
	void testFindOne() {
		// given
		Reply reply = Reply.builder()
			.boardId(1L)
			.content("조회 테스트")
			.replyer("testUser")
			.build();
		replyMapper.save(reply);

		// when
		Reply find = replyMapper.findOne(reply.getReplyId());

		// then
		assertThat(find).isNotNull();
		assertThat(find.getContent()).isEqualTo("조회 테스트");
		assertThat(find.getReplyer()).isEqualTo("testUser");
	}

	@Test
	@DisplayName("댓글 수정 테스트")
	void testUpdate() {
		// given
		Reply reply = Reply.builder()
			.boardId(1L)
			.content("수정 전")
			.replyer("testUser")
			.build();

		replyMapper.save(reply);

		// when
		Reply updateReply = Reply.builder()
			.replyId(reply.getReplyId())
			.content("수정 후")
			.build();

		int result = replyMapper.update(updateReply);

		// then
		assertThat(result).isEqualTo(1);
		Reply updated = replyMapper.findOne(reply.getReplyId());
		assertThat(updated.getContent()).isEqualTo("수정 후");
		log.info("수정 완료: {}", updated.getContent());
	}

	@Test
	@DisplayName("댓글 삭제 테스트")
	void testDelete() {
		// given
		Reply reply = Reply.builder()
			.boardId(1L)
			.content("삭제 테스트")
			.replyer("testUser")
			.build();
		replyMapper.save(reply);
		Long replyId = reply.getReplyId();

		// when
		int result = replyMapper.delete(replyId);

		// then
		assertThat(result).isEqualTo(1);
		Reply deleted = replyMapper.findOne(replyId);
		assertThat(deleted).isNull();
		log.info("삭제 완료: replyId={}", replyId);
	}

	@Test
	@DisplayName("특정 게시글의 댓글 목록 조회")
	void testFindByBoardId() {
		// given
		Reply reply1 = Reply.builder()
			.boardId(1L)
			.content("댓글 1")
			.replyer("testUser")
			.build();

		Reply reply2 = Reply.builder()
			.boardId(1L)
			.content("댓글 2")
			.replyer("testUser")
			.build();

		replyMapper.save(reply1);
		replyMapper.save(reply2);

		// when
		List<Reply> replies = replyMapper.findByBoardId(1L);

		// then
		assertThat(replies).hasSizeGreaterThanOrEqualTo(2) // 기존 데이터도 있을 수 있음 DB(insert)
			.extracting(Reply::getReplyer)
			.contains("testUser");

		log.info("조회된 댓글 수: {}", replies.size());
	}

	@Test
	@DisplayName("특정 작성자의 댓글 조회")
	void testFindByReplyer() {
		// given
		Reply reply1 = Reply.builder()
			.boardId(1L)
			.content("작성자 댓글 1")
			.replyer("testUser")
			.build();

		Reply reply2 = Reply.builder()
			.boardId(1L)
			.content("작성자 댓글 2")
			.replyer("testUser")
			.build();

		replyMapper.save(reply1);
		replyMapper.save(reply2);

		// when
		List<Reply> replies = replyMapper.findByReplyer("testUser");

		// then
		assertThat(replies).hasSizeGreaterThanOrEqualTo(2)
			.allMatch(reply -> reply.getReplyer().equals("testUser"));

		log.info("testUser의 댓글 수: {}", replies.size());
	}

	@Test
	@DisplayName("특정 게시글의 댓글 수")
	void testGetCountByBoardId() {
		// given
		Reply reply1 = Reply.builder()
			.boardId(1L)
			.content("댓글 1")
			.replyer("testUser")
			.build();

		Reply reply2 = Reply.builder()
			.boardId(1L)
			.content("댓글 2")
			.replyer("testUser")
			.build();

		Reply reply3 = Reply.builder()
			.boardId(1L)
			.content("댓글 3")
			.replyer("testUser")
			.build();

		replyMapper.save(reply1);
		replyMapper.save(reply2);
		replyMapper.save(reply3);

		// when
		int count = replyMapper.getCountByBoardId(1L);

		// then
		assertThat(count).isGreaterThanOrEqualTo(3);
		log.info("게시글 1L의 댓글 수: {}", count);
	}
}
