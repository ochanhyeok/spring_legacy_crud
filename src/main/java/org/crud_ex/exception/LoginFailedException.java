package org.crud_ex.exception;

// 로그인 실패 예외
public class LoginFailedException extends RuntimeException{

	public LoginFailedException(String message) {
		super(message);
	}
}
