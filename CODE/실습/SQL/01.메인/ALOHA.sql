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