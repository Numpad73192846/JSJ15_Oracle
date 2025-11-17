-- ALOHA 계정 생성

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER ALOHA IDENTIFIED BY 123456;
ALTER USER ALOHA DEFAULT TABLESPACE users;
ALTER USER ALOHA QUOTA UNLIMITED ON users;
GRANT DBA TO ALOHA;

-- 52.
-- MS_STUDENT 테이블을 생성하시오.
-- * 테이블 생성
/*
    CREATE TABLE 테이블명 (
        컬럼명1   타입   [DEFAULT 기본값] [NOT NULL/NULL]  [제약조건],
        컬럼명2   타입   [DEFAULT 기본값] [NOT NULL/NULL]  [제약조건],
        컬럼명3   타입   [DEFAULT 기본값] [NOT NULL/NULL]  [제약조건],
        ...
    );
*/

CREATE TABLE MS_STUDENT (
    ST_NO       NUMBER          NOT NULL PRIMARY KEY,
    NAME        VARCHAR2(20)    NOT NULL,
    CTZ_NO      CHAR(14)        NOT NULL,
    EMAIL       VARCHAR2(100)   NOT NULL UNIQUE,
    ADDRESS     VARCHAR2(1000)  NULL,
    DEPT_NO     NUMBER          NOT NULL,
    MJ_NO       NUMBER          NOT NULL,
    REG_DATE    DATE            DEFAULT sysdate NOT NULL,
    UPD_DATE    DATE            DEFAULT sysdate NOT NULL,
    ETC         VARCHAR2(1000)  DEFAULT '없음' NULL

    -- 기본키 제약조건 별도로 지정
    -- , CONSTRAINT MS_STUDENT_PK       PRIMARY KEY(ST_NO) ENABLE
);

-- UQ(고유키) 추가

ALTER TABLE MS_STUDENT ADD CONSTRAINT MS_STUDENT_UK1 UNIQUE (EMAIL) ENABLE;

-- 테이블 및 컬럼 설명

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메이';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.DEPT_NO IS '부서번호';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 테이블 삭제

DROP TABLE MS_STUDENT;

-- 53.
-- MS_STUDENT 테이블에 성별, 재적, 입학일자, 졸업일자 속성을 추가하시오.

-- 테이블에 속성 추가
-- ALTER TABLE 테이블명 ADD 컬럼명 타입 DEFAULT 기본값 [NOT NULL];

-- 성별 속성 추가

ALTER TABLE MS_STUDENT ADD GENDER CHAR(6) DEFAULT '기타' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';

-- 재적 속성 추가

ALTER TABLE MS_STUDENT ADD STATUS VARCHAR2(10) DEFAULT '대기' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';

-- 입학일자 속성 추가

ALTER TABLE MS_STUDENT ADD ADM_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';

-- 졸업일자 속성 추가

ALTER TABLE MS_STUDENT ADD GRD_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

-- 테이블 구조 조회

DESC MS_STUDENT;

-- 54.
-- MS_STUDENT 테이블의 CTZ_NO 속성을 BIRTH 로 이름을 변경하고
-- 데이터 타입을 DATE 로 수정하시오.
-- 그리고, 설명도 '생년월일'로 변경하시오.

-- CTZ_NI → BIRTH로 이름 변경

ALTER TABLE MS_STUDENT RENAME COLUMN CTZ_NO TO BIRTH;

-- BIRTH의 데이터 타입 설정

ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;

-- 코멘트 추가

COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';

-- 55.
-- MS_STUDENT 테이블의 학부 번호(DEPT_NO) 속성을 삭제하시오.

ALTER TABLE MS_STUDENT DROP COLUMN DEPT_NO;

-- 56.
-- MS_STUDENT 테이블을 삭제하시오.

DROP TABLE MS_STUDENT;

-- 57.
-- 테이블 정의서 대로 학생테이블(MS_STUDENT) 를 생성하시오.

CREATE Table MS_STUDENT (
      ST_NO       NUMBER            NOT NULL PRIMARY KEY,
      NAME        VARCHAR2(20)      NOT NULL,
      BIRTH       DATE              NOT NULL,
      EMAIL       VARCHAR2(100)     NOT NULL UNIQUE,
      ADDRESS     VARCHAR2(1000)    NULL,
      MJ_NO       CHAR(4)           NOT NULL,
      GENDER      CHAR(6)           DEFAULT '기타'    NOT NULL,
      STATUS      VARCHAR2(10)      DEFAULT '대기'    NOT NULL,
      ADM_DATE    DATE              NULL,
      GRD_DATE    DATE              NULL,
      REG_DATE    DATE              DEFAULT sysdate   NOT NULL,
      UPD_DATE    DATE              DEFAULT sysdate   NOT NULL,
      ETC         VARCHAR2(1000)    DEFAULT '없음'    NULL
);

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 58.
-- 데이터 삽입 (INSERT)
INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, GENDER,
                          STATUS, ADM_DATE, GRD_DATE, REG_DATE,
                          UPD_DATE, ETC
                        )
VALUES ( '20240001', '최영우', '2005/10/05', 'cyw@univ.ac.kr', '서울', 'I01', '남',
         '재학', '2024/03/01', NULL, sysdate, sysdate, NULL);

INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, GENDER,
                          STATUS, ADM_DATE, GRD_DATE, REG_DATE,
                          UPD_DATE, ETC
                        )
VALUES ( '20110002', '한성호', '1992/10/07', 'hsh@univ.ac.kr', '서울', 'E03', '남',
         '재학', '2011/03/01', NULL, sysdate, sysdate, NULL);

SELECT * FROM MS_STUDENT;

         -- '2024/03/01' -> TO_DATE('2024/03/01', 'YYYY/MM/DD') 도 가능
-- '2024/03/01' : 문자타입이 DATE 으로 내부적으로 변환되서 데이터 추가
-- DB 툴을 이용하여 INSERT 한다면, COMMIT 을 실행해야 LOCK 걸리지 않고 적용됨.
COMMIT;

-- 59.
-- MS_STUDENT 테이블의 데이터를 수정
-- UPDATE
/*
    UPDATE 테이블명
       SET 컬럼1 = 변경할 값,
           컬럼2 = 변경할 값,
           ...
   [WHERE] 조건;
*/
-- * 이름이 '한성호'인 학생의 재적 상태를 '퇴학',
-- 수정일자를 현재 날짜, 특이사항을 '자진 퇴학'으로 수정하시오.

UPDATE MS_STUDENT
   SET STATUS = '퇴학'
       ,UPD_DATE = sysdate
       ,ETC = '자진퇴학'
WHERE NAME = '한성호';

-- 60.
-- MS_STUDENT 테이블에서 학번이 20110002 인 학생을 삭제하시오.

DELETE FROM MS_STUDENT
WHERE ST_NO = '20110002';

-- 61.
-- MS_STUDENT 테이블의 모든 속성을 조회하시오.

SELECT * FROM MS_STUDENT;

-- 62.
-- MS_STUDENT 테이블을 조회하여 MS_STUDENT_BACK 테이블 생성하시오.
-- 백업 테이블 만들기

CREATE TABLE MS_STUDENT_BACK
AS SELECT * FROM MS_STUDENT;

-- 63.
-- MS_STUDENT 테이블의 튜플을 삭제하시오.

-- 데이터 삭제              (ROLLBACK 가능)

DELETE FROM MS_STUDENT;

-- 데이터 및 내부 구조 삭제  (ROLLBACK 불가능)

TRUNCATE TABLE MS_STUDENT;

-- 테이블 구조 삭제

DROP TABLE MS_STUDENT;

-- 64.
-- MS_STUDENT_BACK 테이블의 모든 속성을 조회하여
-- MS_STUDENT 테이블에 삽입하시오.

INSERT INTO MS_STUDENT
SELECT * FROM MS_STUDENT_BACK;

-- 65.
-- MS_STUDENT 테이블의 성별(gender) 속성에 대하여,
-- ('여', '남', '기타') 값만 입력가능하도록 제약조건을 추가하시오.
ALTER TABLE MS_STUDENT
MODIFY GENDER CHECK (GENDER IN ('여', '남', '기타'));

ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STUDENT_GENDER_CHECK
CHECK (GENDER IN ('여', '남', '기타'));

SELECT * FROM MS_STUDENT;

UPDATE MS_STUDENT
SET GENDER = '?'
WHERE ST_NO = '20240001';
-- * 도메인 무결성 보장
-- * CHECK조건으로 지정한 값이 아닌 다른 값을 입력/수정하는 경우
--   데이터가 적용되지 않도록 제약합니다.
-- ORA-02290: "체크 제약조건이 위배되었습니다."

-- 66~69.
-- MS_USER, MS_BOARD, MS_FILE, MS_REPLY 테이블을 테이블 정의서에 따라 생성해보세요.

CREATE TABLE MS_USER (
    USER_NO     NUMBER          NOT NULL PRIMARY KEY,
    USER_ID     VARCHAR2(100)   NOT NULL UNIQUE,
    USER_PW     VARCHAR2(200)   NOT NULL,
    USER_NAME   VARCHAR2(200)   NOT NULL,
    BIRTH       DATE            NOT NULL,
    TEL         VARCHAR2(20)    NOT NULL UNIQUE,
    ADDRESS     VARCHAR2(20)    NULL,
    REG_DATE    DATE            DEFAULT sysdate NOT NULL,
    UPD_DATW    DATE            DEFAULT sysdate NOT NULL
);

CREATE TABLE MS_BOARD (
    BOARD_NO     NUMBER          NOT NULL PRIMARY KEY,
    TITLE        VARCHAR2(200)   NOT NULL,
    CONTENT      CLOB            NOT NULL,
    WRITER       VARCHAR2(100)   NOT NULL,
    HIT          NUMBER          NOT NULL,
    LIKE_CNT     NUMBER          NOT NULL,
    DEL_YN       CHAR(2)         NULL,
    DEL_DATE     DATE            NULL,
    REG_DATE     DATE            DEFAULT sysdate NOT NULL,
    UPD_DATE     DATE            DEFAULT sysdate NOT NULL
);

CREATE TABLE MS_FILE (
    FILE_NO      NUMBER          NOT NULL PRIMARY KEY,
    BOARD_NO     NUMBER          NOT NULL,
    FILE_NAME    VARCHAR2(2000)  NOT NULL,
    FILE_DATA    BLOB            NOT NULL,
    REG_DATE     DATE            DEFAULT sysdate NOT NULL,
    UPD_DATE     DATE            DEFAULT sysdate NOT NULL
);

CREATE TABLE MS_REPLY (
    REPLY_NO     NUMBER          NOT NULL PRIMARY KEY,
    BOARD_NO     NUMBER          NOT NULL,
    CONTENT      VARCHAR2(2000)  NOT NULL,
    WRITER       NUMBER          NOT NULL,
    DEL_YN       CHAR(2)         NULL,
    DEL_DATE     DATE            NULL,
    REG_DATE     DATE            DEFAULT sysdate NOT NULL,
    UPD_DATE     DATE            DEFAULT sysdate NOT NULL
);

-- 72.
-- MS_BOARD 의 WRITER 속성을 NUMBER 타입으로 변경하고
-- MS_USER 의 USER_NO 를 참조하는 외래키로 지정하시오.

-- 1)
-- 데이터 타입 변경
-- ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입;

ALTER TABLE MS_BOARD MODIFY WRITER NUMBER;

-- 외래키 지정
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명
-- FOREIGN KEY (외래키컬럼) REFERENCES 참조테이블(기본키);

-- MS_BOARD(WRITER) ----> MS_USER(USER_no)
ALTER TABLE MS_BOARD ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY (WRITER) REFERENCES MS_USER(USER_NO);

-- 2) 외래키 지정 : MS_FILE ( BOARD_NO ) ----> MS_BOARD (BOARD_NO)
-- MS_FILE 테이블의 BOARD_NO 를 외래키로 지정하여
-- MS_BOARD 테이블의 BOARD_NO 를 참조하도록 지정

ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);

-- 3) 외래키 : MS_REPLY (BOARD_NO)  ---->  MS_BOARD (BOARD_NO)

ALTER TABLE MS_REPLY ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);

-- 제약조건 삭제
-- ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;

ALTER TABLE MS_BOARD DROP CONSTRAINT MS_BOARD_WRITER_FK;
ALTER TABLE MS_FILE DROP CONSTRAINT MS_FILE_BOARD_NO_FK;
ALTER TABLE MS_REPLY DROP CONSTRAINT MS_REPLY_BOARD_NO_FK;

-- 73.
-- MS_USER 테이블에 속성을 추가하시오.

ALTER TABLE MS_USER ADD CTZ_NO CHAR(14) NOT NULL UNIQUE;
ALTER TABLE MS_USER ADD GENDER CHAR(6)  NOT NULL;

COMMENT ON COLUMN MS_USER.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_USER.GENDER IS '성별';

-- 74.
-- MS_USER 의 GENDER 속성이 ('여', '남', '기타') 값만 갖도록
-- 제약조건을 추가하시오.
-- CHECK 제약조건 추가

ALTER TABLE MS_USER
ADD CONSTRAINT MS_USER_GENDER_CHECK
CHECK (GENDER IN ('여', '남', '기타'));

-- 75.
-- MS_FILE 테이블에 확장자(EXT) 속성을 추가하시오.

ALTER TABLE MS_FILE ADD EXT VARCHAR2(10) NULL;
COMMENT ON COLUMN MS_FILE.EXT IS '확장자';

-- 76.
-- 테이블 MS_FILE 의 FILE_NAME 속성에서 확장자를 추출하여 
-- EXT 속성에 UPDATE 하는 SQL 문을 작성하시오.

MERGE INTO MS_FILE T
USING ( SELECT FILE_NO, FILE_NAME FROM MS_FILE ) F
ON ( T.FILE_NO = F.FILE_NO )
WHEN MATCHED THEN
     UPDATE SET T.EXT = SUBSTR( F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) + 1)
     DELETE WHERE LOWER( SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) + 1))
            NOT IN ('jpeg', 'jpg', 'gif', 'png', 'webp')
    -- WHEN NOT MATCHED THEN 

;

SELECT * FROM MS_FILE;
SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_REPLY;

DELETE FROM MS_FILE;

-- 파일 추가
INSERT INTO MS_FILE (
            FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
)
VALUES (1, 1, '강아지.png', '123', sysdate, sysdate, 'jpg');

INSERT INTO MS_FILE (
            FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
)
VALUES (2, 1, '신청서.pdf', '123', sysdate, sysdate, 'pdf');

-- 게시글 추가
INSERT INTO MS_BOARD (
            BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT,
            DEL_YN, DEL_DATE, REG_DATE, UPD_DATE
)
VALUES (
    1, '제목', '내용', 1, 0, 0, 'N', NULL, sysdate, sysdate
);

-- 유저 추가
INSERT INTO MS_USER (
            USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH,
            TEL, ADDRESS, REG_DATE, UPD_DATE,
            CTZ_NO, GENDER
)
VALUES (1, 'ALOHA', '123456', '김조은', TO_DATE('2003/01/01', 'YYYY/MM/DD'),
        '010-1234-1234', '부평', sysdate, sysdate,
        '030101-3334444', '기타'
);

-- 77.
-- 테이블 MS_FILE 의 EXT 속성이
-- ('jpg', 'jpeg', 'gif', 'png', 'webp') 값을 갖도록 하는 제약조건을 추가하시오.

ALTER TABLE MS_FILE
ADD CONSTRAINT MS_FILE_EXT_CHECK
CHECK ( EXT IN ('jpg', 'jpeg', 'gif', 'png', 'webp'));

-- 제약조건 삭제

ALTER TABLE MS_FILE
DROP CONSTRAINT MS_FILE_EXT_CHECK;

INSERT INTO MS_FILE
(FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
VALUES
(3, 1, '고양이.webp', '123', '2025/11/17', '2025/11/17', 'webp');

INSERT INTO MS_FILE
(FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
VALUES
(4, 1, '문서.pdf', '123', '2025/11/17', '2025/11/17', 'pdf');

-- 78.
-- MS_USER, MS_BOARD, MS_FILE, MS_REPLY 테이블의
-- 모든 데이터를 삭제하는 명령어를 작성하시오.

-- DDL - TRUNCATE

TRUNCATE TABLE MS_USER;
TRUNCATE TABLE MS_BOARD;
TRUNCATE TABLE MS_FILE;
TRUNCATE TABLE MS_REPLY;

-- DML - DELETE

DELETE FROM MS_USER;
DELETE FROM MS_BOARD;
DELETE FROM MS_FILE;
DELETE FROM MS_REPLY;

-- DELETE vs TRUNCATE
-- * DELETE - 데이터 조작어(DML)
-- - 한 행 단위로 데이터를 삭제한다.
-- - WHERE 조건절을 기준으로 일부 삭제 가능.
-- - COMMIT, ROLLBACK 을 이용하여 변경사항을 
--   적용하거나 되돌릴 수 있음.
-- * TRUNCATE - 데이터 정의어(DDL)
-- - 모든 행을 삭제한다.
-- - 삭제된 데이터를 되돌릴 수 없음

-- 79.
-- 테이블의 속성을 삭제하시오.
-- * MS_BOARD 테이블의 WRITER 속성
-- * MS_FILE 테이블의 BOARD_NO 속성
-- * MS_REPLY 테이블의 BOARD_NO 속성

ALTER TABLE MS_BOARD DROP COLUMN WRITER;
ALTER TABLE MS_FILE  DROP COLUMN BOARD_NO;
ALTER TABLE MS_REPLY DROP COLUMN BOARD_NO;

-- 80.
-- 각 테이블에 속성들을 추가한 뒤, 외래키로 지정하시오.
-- 해당 외래키에 대하여 참조 테이블의 데이터 삭제 시,
-- 연결된 속성의 값도 삭제하는 옵션도 지정하시오.

-- 1)
-- MS_BOARD의 WRITER속성 추가

ALTER TABLE MS_BOARD ADD WRITER NUMBER NOT NULL;
-- WRITER 속성을 외래키로 지정
-- + 참조 테이블 데이터 삭제 시, 염쇄적으로 삭제하는 옵션 지정
ALTER TABLE MS_BOARD
ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY(WRITER) REFERENCES MS_USER(USER_NO)
ON DELETE CASCADE;

-- 2)
-- MS_FILE의 BOARD_NO속성 추가

ALTER TABLE MS_FILE ADD BOARD_NO NUMBER NOT NULL;
-- BOARD_NO 속성을 외래키로 지정
-- + 참조 테이블 데이터 삭제 시, 염쇄적으로 삭제하는 옵션 지정
ALTER TABLE MS_FILE
ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY(BOARD_NO) REFERENCES MS_USER(BOARD_NO)
ON DELETE CASCADE;


-- 3)
-- MS_REPLY의 BOARD_NO속성 추가

ALTER TABLE MS_REPLY ADD BOARD_NO NUMBER NOT NULL;
-- BOARD_NO 속성을 외래키로 지정
-- + 참조 테이블 데이터 삭제 시, 염쇄적으로 삭제하는 옵션 지정
ALTER TABLE MS_REPLY
ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY(BOARD_NO) REFERENCES MS_USER(BOARD_NO)
ON DELETE CASCADE;

-- ** 외래키가 참조하는 참조컬럼의 데이터 삭제 시, 동작할 옵션 지정
-- ON DELETE [NO ACTION, RESTRICT, CASCADE, SET NULL]
-- * NO ACTION      :   아무 행위도 안 함.
-- * RESTRICT       :   자식 테이블의 데이터가 존재하면, 삭제 안 함.
-- * CASCADE        :   자식 테이블의 데이터도 함께 삭제 
-- * SET NULL       :   자식 테이블의 데이터를 NULL 로 지정

-- 데이터 추가
-- 유저 추가
INSERT INTO MS_USER(
                USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH,
                TEL, ADDRESS, REG_DATE, UPD_DATE,
                CTZ_NO, GENDER
                )
VALUES ( 1, 'ALOHA', '123456', '김조은', TO_DATE('2003/01/01', 'YYYY/MM/DD'),
         '010-1234-1234', '부평', sysdate, sysdate,
         '030101-3334444', '기타');
-- 게시글 추가
INSERT INTO MS_BOARD (
                BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT,
                DEL_YN, DEL_DATE, REG_DATE, UPD_DATE
                )
VALUES (
        1, '제목', '내용', 1, 0, 0, 'N', NULL, sysdate, sysdate
        );
-- 댓글 추가
INSERT INTO MS_REPLY ( REPLY_NO,  CONTENT, WRITER, DEL_YN, REG_DATE, UPD_DATE, BOARD_NO )
VALUES (1, '댓글내용', '김조은', 'N', '2024/09/05', '2024/09/05', 1);
-- 파일 추가
INSERT INTO MS_FILE ( 
            FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
            )
VALUES (1, 1, '강아지.png', '123', sysdate, sysdate, 'jpg' );

INSERT INTO MS_FILE ( 
            FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
            )
VALUES (2, 1, 'main.html', '123', sysdate, sysdate, 'jpg' );

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;
SELECT * FROM MS_REPLY;

DELETE FROM MS_USER WHERE USER_NO = 1;
