package org.crud_ex.domain;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Reply {

	private Long replyId;
	private Long boardId;
	private String content;
	private String replyer;
	private LocalDateTime regDate;

}
