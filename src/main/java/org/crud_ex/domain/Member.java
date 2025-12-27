package org.crud_ex.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Member {

	private String userId;
	private String userPw;
	private String userName;
	private String email;
	private LocalDateTime regDate;
}
