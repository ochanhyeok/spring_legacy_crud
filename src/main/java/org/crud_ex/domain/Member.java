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
public class Member {

	private String userId;
	private String userPw;
	private String userName;
	private String email;
	private LocalDateTime regDate;
}
