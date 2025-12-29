package org.crud_ex.mapper;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import lombok.extern.slf4j.Slf4j;

// Spring 테스트 엔진 활성화
@ExtendWith(SpringExtension.class)
// 스프링 컨테이너에 어떤 설정파일을 읽을지 알려줌
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class BoardMapperTest {

	@Autowired
	private BoardMapper boardMapper;

	@Test
	public void findAll() {
		boardMapper.findAll().forEach(board -> {
			log.info("Board ID: " + board.getBoardId());
			log.info("Title: " + board.getTitle());
			log.info("Writer: " + board.getWriter());
			log.info("RegDate: " + board.getRegDate());
		});


	}

	@Test
	public void findOne() {
	}
}