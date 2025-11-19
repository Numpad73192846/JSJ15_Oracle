-- DDL
CREATE TABLE board (
  no NUMBER NOT NULL,
  title varchar2(100) NOT NULL,
  writer varchar2(100) NOT NULL,
  content varchar2(1000),
  reg_date DATE DEFAULT sysdate NOT NULL,
  upd_date DATE  DEFAULT sysdate NOT NULL,
  views NUMBER  DEFAULT 0 NOT NULL,
  PRIMARY KEY (no)
);

-- 시퀀스
CREATE SEQUENCE SEQ_BOARD
INCREMENT BY 1                  -- 증가값
START WITH 1                    -- 시작값
MINVALUE 1                      -- 최솟값
MAXVALUE 1000000;               -- 최댓값

-- 샘플 데이터
INSERT INTO board (no, title, writer, content) VALUES (SEQ_BOARD.NEXTVAL, '제목 1', '작성자 1', '내용 1');
INSERT INTO board (no, title, writer, content) VALUES (SEQ_BOARD.NEXTVAL, '제목 2', '작성자 2', '내용 2');
INSERT INTO board (no, title, writer, content) VALUES (SEQ_BOARD.NEXTVAL, '제목 3', '작성자 3', '내용 3');
INSERT INTO board (no, title, writer, content) VALUES (SEQ_BOARD.NEXTVAL, '제목 4', '작성자 4', '내용 4');
INSERT INTO board (no, title, writer, content) VALUES (SEQ_BOARD.NEXTVAL, '제목 5', '작성자 5', '내용 5');
INSERT INTO board (no, title, writer, content) VALUES (SEQ_BOARD.NEXTVAL, '제목 6', '작성자 6', '내용 6');
INSERT INTO board (no, title, writer, content) VALUES (SEQ_BOARD.NEXTVAL, '제목 7', '작성자 7', '내용 7');
INSERT INTO board (no, title, writer, content) VALUES (SEQ_BOARD.NEXTVAL, '제목 8', '작성자 8', '내용 8');
INSERT INTO board (no, title, writer, content) VALUES (SEQ_BOARD.NEXTVAL, '제목 9', '작성자 9', '내용 9');
INSERT INTO board (no, title, writer, content) VALUES (SEQ_BOARD.NEXTVAL, '제목 10', '작성자 10', '내용 10');


SELECT * FROM board;

-- ROWNUM을 활용한 페이징 처리

SELECT *
FROM (
    SELECT ROWNUM AS row_num, no, title, content
    FROM board
    WHERE ROWNUM <= 10  -- 원하는 페이지 크기를 여기에 지정합니다.
)
WHERE row_num >= 1; -- 원하는 페이지 번호에 맞게 시작하는 행 번호를 여기에 지정합니다.

-- ROWID

SELECT ROWID
    , employee_id
    , first_name
FROM employees
WHERE department_id = 30;