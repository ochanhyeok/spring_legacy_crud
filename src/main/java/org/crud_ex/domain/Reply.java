package org.crud_ex.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Reply {

	private Long replyId;
	private Long boardId;
	private String reply;
	private String replyer;
	private LocalDateTime regDate;

}
