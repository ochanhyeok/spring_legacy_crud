# Spring Legacy CRUD (Board + Member + Reply)

간단한 **Spring Legacy MVC** 기반의 CRUD 연습 프로젝트입니다.  
JSP와 MyBatis, HikariCP, MariaDB를 사용하여 **회원 + 게시판 + 댓글** 3개 테이블을 구현합니다.

---

## 기술 스택

- Java 17
- Spring Framework 5 (Spring MVC, Spring JDBC)
- MyBatis
- HikariCP (Connection Pool)
- MariaDB
- JSP / JSTL
- Maven
- Apache Tomcat 9
- IntelliJ IDEA

---

## 주요 기능

### 1. 회원(Member)

- 회원 가입
- 로그인 / 로그아웃
- 내 정보 조회

### 2. 게시판(Board)

- 게시글 목록 조회 (페이징)
- 게시글 상세 조회
- 게시글 등록
- 게시글 수정
- 게시글 삭제 (작성자만)

### 3. 댓글(Reply)

- 특정 게시글에 대한 댓글 목록 조회
- 댓글 등록
- 댓글 수정
- 댓글 삭제 (작성자만)

---

## DB 테이블 설계 (예시)

