package org.crud_ex.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Reply {

	private Long rno;
	private Long bno;
	private String reply;
	private String replyer;
	private LocalDateTime regDate;

}
