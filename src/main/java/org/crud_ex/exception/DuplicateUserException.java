package org.crud_ex.exception;

public class DuplicateUserException extends RuntimeException {

	public DuplicateUserException(String message) {
		super(message);
	}
}
