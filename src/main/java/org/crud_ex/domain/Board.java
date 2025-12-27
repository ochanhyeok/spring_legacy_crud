package org.crud_ex.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Board {

	private int bno;
	private String title;
	private String content;
	private String writer;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
}
