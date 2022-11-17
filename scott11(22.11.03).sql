CREATE TABLE board_ex(
	seq 	number,			-- 글번호
	title	varchar2(50), 	-- 제목
	writer  varchar2(30), 	-- 작성자
	content varchar2(200),	-- 내용
	regdate date,			-- 게시일
	cnt		number,			-- 조회수
	pass    varchar2(20), 	-- 비밀번호
	CONSTRAINT pk_board_seq PRIMARY KEY(seq)
);
	
CREATE SEQUENCE seq_board;
	

update board_ex set cnt = CNT + 1 where seq = 1;


SELECT *
FROM GUESTTB
WHERE MESSAGE_ID IN (SELECT MESSAGE_ID FROM (SELECT rownum AS rnum, message_id 
												FROM (SELECT message_id FROM GUESTTB ORDER BY message_id DESC))
					WHERE rnum>=? AND rnum<=?)
ORDER BY MESSAGE_ID DESC;


-- hint 예시 --
SELECT * FROM tbl_board ORDER BY bno DESC;	-- 일반
SELECT /*+ INDEX_DESC (tbl_board tbl_board_pk)*/ * FROM tbl_board;	-- hint


select /*+ INDEX_DESC (board_ex )*/ rownum, * 
from board_ex;


CREATE TABLE board_mvc(
	seq 	number,			-- 글번호
	title	varchar2(50), 	-- 제목
	writer  varchar2(30), 	-- 작성자
	content varchar2(200),	-- 내용
	regdate date,			-- 게시일
	cnt		number,			-- 조회수
	pass    varchar2(20), 	-- 비밀번호
	CONSTRAINT pk_board_mvc_seq PRIMARY KEY(seq)
);

CREATE SEQUENCE seq_board_mvc;


INSERT INTO BOARD_MVC VALUES (seq_board_mvc.nextval, 2, 2, 2, sysdate, 0, 2);

INSERT INTO BOARD_MVC VALUES (seq_board_mvc.nextval, 3, 3, 3, sysdate, 0, 3);




CREATE table comment_tab(
	comment_no number Primary Key,
	user_id varchar2(30),
	comment_content varchar2(1024),
	reg_date date
);

drop table comment_tab;

INSERT into comment_tab values(1, 1, 1, sysdate);
INSERT into comment_tab values(2, 2, 2, sysdate);
INSERT into comment_tab values(3, 3, 3, sysdate);

commit;




CREATE TABLE board(
	seq 	 number,
	title	 varchar2(50), 
	writer     varchar2(30), 
	content   varchar2(200),
	regdate   date,
	cnt	number
);

CREATE SEQUENCE board_seq;






create table member (
	userid		varchar(50),
	userpass	varchar(100),
	username	varchar(100)
);


------------------------------------------------
SELECT *
FROM BOARD
WHERE TITLE LIKE '%%'
ORDER BY SEQ DESC

----------------------


create table upLoadtemp(
	 b_id number(5) primary key, -- 글번호 
	 b_name varchar2(20),-- 글쓴이 
	 b_email varchar2(50),-- 글쓴이 메일 주소 
	 b_title varchar2(80),-- 글 제목 
	 b_content varchar2(3000),-- 글 내용 
	 b_pwd varchar2(12),-- 비밀번호 
	 b_date date,-- 글쓴날짜 
	 b_count number(5) default 0,-- 조회횟수 
     b_fname varchar2(100), --파일이름
     b_realfname varchar2(100),
     b_fsize number  --파일용량
);


-- 2. 시퀀스 생성
create sequence uploadtemp_bid_seq;


------------------------------------------------------------------
-- 2022-11-15 화요일

create table tx_member(
 num number primary key,
 id varchar2(50) unique,
 password varchar2(50) not null,
 name varchar2(50) not null,
 address varchar2(50) not null
);

create sequence member_tx_seq increment by 1 start with 1;

create table tx_customer(
num number primary key,
ssn varchar2(50) constraint customer_ssn_nn not null,
name varchar2(50) not null,
address varchar2(50) not null,
constraint customer_ssn_uq unique(ssn)
);

create sequence customer_tx_seq increment by 1 start with 1;


---------------------------------------------------------------------
-- 2022-11-16 수요일

 -- 오라클
 CREATE TABLE REPLY 
   (RNO NUMBER, 
	BNO NUMBER NOT NULL ,
	REPLY VARCHAR2(1000) NOT NULL, 
	REPLYER VARCHAR2(50) NOT NULL, 
	REPLYDATE DATE DEFAULT sysdate,  
    CONSTRAINT PK_REPLY PRIMARY KEY (RNO),
 	CONSTRAINT FK_REPLY_BOARD FOREIGN KEY (BNO) REFERENCES BOARD(SEQ) 
   );

create sequence reply_seq;

-- primary key가 없어서 설정함
ALTER Table BOARD ADD CONSTRAINT PK_SEQ PRIMARY KEY (SEQ);
