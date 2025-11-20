-- 프로시저
-- 프로시저 생성

CREATE OR REPLACE PROCEDURE pro_print
IS
  -- 선언부
  V_A NUMBER := 10;
  V_B NUMBER := 20;
  V_C NUMBER;
BEGIN
     -- 실행부 
     V_C := V_A + V_B;
     DBMS_OUTPUT.PUT_LINE('V_C : ' || V_C);
END;
/

-- 출력 활성화

SET SERVEROUTPUT ON;

-- 프로시저 실행

EXECUTE pro_print();

-- 프로시저 (파라미터 사용)
-- 파라미터 : 사원번호, 제목, 내용
-- board테이블에 사원명으로 글쓰기를 하는 프로시저
-- DDL
DROP TABLE board;

CREATE TABLE board (
  no NUMBER NOT NULL PRIMARY KEY,
  title varchar2(100) NOT NULL,
  writer varchar2(100) NOT NULL,
  content varchar2(1000),
  reg_date DATE DEFAULT sysdate NOT NULL,
  upd_date DATE  DEFAULT sysdate NOT NULL,
  views NUMBER  DEFAULT 0 NOT NULL
);

-- 시퀀스
DROP SEQUENCE SEQ_BOARD;

CREATE SEQUENCE SEQ_BOARD
INCREMENT BY 1                  -- 증가값
START WITH 1                    -- 시작값
MINVALUE 1                      -- 최솟값
MAXVALUE 1000000;               -- 최댓값

-- 프로시저
CREATE OR REPLACE PROCEDURE pro_emp_write
(
  -- 파라미터
  IN_EMP_ID IN employee.emp_id%TYPE
 ,IN_TITLE IN VARCHAR2 DEFAULT '제목없음'
 ,IN_CONTENT IN VARCHAR2 DEFAULT '내용없음'
)
IS
  -- 선언부
  V_EMP_NAME employee.emp_name%TYPE;
BEGIN
  -- 사원명을 죄회
  SELECT emp_name INTO V_EMP_NAME
  FROM employee
  WHERE emp_id = IN_EMP_ID;
  -- 글 등록
  INSERT INTO board( no, title, writer, content )
  VALUES ( SEQ_BOARD.NEXTVAL, IN_TITLE, V_EMP_NAME, IN_CONTENT );
END;
/

-- 프로시저 실행
EXECUTE pro_emp_write( '200', '제목', '내용' );
EXECUTE pro_emp_write( '200' );

SELECT * FROM BOARD;

-- 프로시저 + 조건문
-- 사원의 업무 이력을 갱신하는 프로시저
CREATE OR REPLACE PROCEDURE pro_app_emp (
  -- 파라미터
  IN_EMP_ID IN employees.employee_id%TYPE     -- 사원번호
 ,IN_JOB_ID IN jobs.job_id%TYPE               -- 직무ID
 ,IN_SRT_DATE IN DATE                         -- 직무 시작일
 ,IN_END_DATE IN DATE                         -- 직무 종료일
)
IS
  -- 선언부
  V_DEPT_ID employees.DEPARTMENT_ID%TYPE;     
  V_CNT NUMBER := 0;
BEGIN
  -- 실행부
  -- 1. 사원정보 조회
  SELECT department_id INTO V_DEPT_ID
  FROM employees
  WHERE employee_id = IN_EMP_ID;

  -- 2. 사원 테이블의 JOB_ID 수정
  -- AC_MGR -> FI_MGR
  UPDATE employees
     SET job_id = IN_JOB_ID
  WHERE employee_id = IN_EMP_ID;

  -- 3. 직무이력 테이블(job_history) 갱신
  -- 현재 날짜에 포함되는 직무이력 확인 : 기존직무
  SELECT COUNT(*) INTO V_CNT
  FROM job_history
  WHERE sysdate BETWEEN start_date AND end_date
    AND employee_id = IN_EMP_ID;

  DBMS_OUTPUT.PUT_LINE('기존직무 개수 : ' || V_CNT );

  -- 해당기간에
  -- 직무 이력이 없으면 새로추가
  IF V_CNT = 0 THEN
    INSERT INTO job_history ( employee_id, start_date, end_date, job_id, department_id)
    VALUES ( IN_EMP_ID, IN_SRT_DATE, IN_END_DATE, IN_JOB_ID, V_DEPT_ID );
 
  -- 직무이력이 있으면 시작일 종료일 변경
  ELSE
    UPDATE JOB_HISTORY
       SET start_date = IN_SRT_DATE
          ,end_date = IN_END_DATE
          ,job_id = IN_JOB_ID
    WHERE EMPLOYEE_ID = IN_EMP_ID;
  END IF;
END;
/

-- 프로시저 실행
EXECUTE pro_app_emp( '200', 'IT_PROG', '2025/11/20', '2026/11/20');
EXECUTE pro_app_emp( '103', 'AC_MGR', '2025/11/20', '2026/11/20');
EXECUTE pro_app_emp( '103', 'IT_PROG', '2027/01/01', '2028/12/31');
EXECUTE pro_app_emp( '103', 'SA_MAN', '2028/01/01', '2030/12/31');

SELECT *
FROM JOB_HISTORY
WHERE EMPLOYEE_ID = 103
ORDER BY START_DATE ASC
;

-- OUT 파라미터로 프로시저 사용하기
CREATE OR REPLACE PROCEDURE PRO_OUT_EMP(
    IN_EMP_ID IN employees.EMPLOYEE_ID%TYPE
   ,OUT_RESULT_STR OUT CLOB
)
IS
  V_EMP EMPLOYEE%ROWTYPE;
  -- %ROWTYPE
  -- 해당 테이블 또는 뷰의 컬럼들을 참조타입으로 선언

BEGIN
    SELECT * INTO V_EMP
    FROM EMPLOYEE
    WHERE EMP_ID = IN_EMP_ID;
    OUT_RESULT_STR := V_EMP.EMP_ID || '/' || 
                      V_EMP.emp_name || '/' || 
                      V_EMP.SALARY;
END;
/

-- OUT 파라미터가 있는 프로시저 사용하기
DECLARE
  OUT_RESULT_STR CLOB;
BEGIN
  PRO_OUT_EMP( '200', OUT_RESULT_STR );
  DBMS_OUTPUT.PUT_LINE( OUT_RESULT_STR );
END;
/

-- 프로시저 OUT 파라미터 2개 이상 사용하기
CREATE OR REPLACE PROCEDURE PRO_OUT_MUL (
  IN_EMP_ID IN EMPLOYEE.EMP_ID%TYPE
 ,OUT_DEPT_CODE OUT EMPLOYEE.DEPT_CODE%TYPE
 ,OUT_JOB_CODE OUT EMPLOYEE.JOB_CODE%TYPE
)
IS
  V_EMP EMPLOYEE%ROWTYPE;
BEGIN
  SELECT * INTO V_EMP
  FROM EMPLOYEE
  WHERE EMP_ID = IN_EMP_ID;

  OUT_DEPT_CODE := V_EMP.DEPT_CODE;
  OUT_JOB_CODE := V_EMP.JOB_CODE;
END;
/

-- 프로시저 호출
-- 1) : EXECUTE 프로시저명( 인자1, 인자2 );
-- 2) OUT파라미터 : PL/SQL 블록 안에서 호출

-- OUT 파라미터가 있어서 블록안에서 호출해야한다.
-- EXECUTE PRO_OUT_MUL( 1, 2, 3 );

DECLARE
  OUT_DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
  OUT_JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
BEGIN
  PRO_OUT_MUL( '200', OUT_DEPT_CODE, OUT_JOB_CODE );
  DBMS_OUTPUT.PUT_LINE( OUT_DEPT_CODE );
  DBMS_OUTPUT.PUT_LINE( OUT_JOB_CODE );
END;
/

-- 프로시저 예외처리
CREATE OR REPLACE PROCEDURE PRO_PRINT_EMP (
  IN_EMP_ID IN EMPLOYEE.EMP_ID%TYPE
)
IS
  STR_EMP_INFO CLOB;
  V_EMP EMPLOYEE%ROWTYPE;
BEGIN
  SELECT * INTO V_EMP
  FROM EMPLOYEE
  WHERE EMP_ID = IN_EMP_ID;
  -- CHR(10) : 줄바꿈(엔터)
  STR_EMP_INFO := '사원정보' || CHR(10) ||
                  '사원명: ' || V_EMP.EMP_NAME || CHR(10) ||
                  '이메일: ' || V_EMP.EMAIL || CHR(10) ||
                  '전화번호: ' || V_EMP.PHONE;
  DBMS_OUTPUT.PUT_LINE(STR_EMP_INFO);

  -- 예외처리부
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      STR_EMP_INFO := '존재하지 않는 사원ID 입니다.';
      DBMS_OUTPUT.PUT_LINE(STR_EMP_INFO);
END;
/

EXECUTE PRO_PRINT_EMP( '200' );
-- 존재하지 않는 사원번호(예외발생)
EXECUTE PRO_PRINT_EMP( '9999' );


-- 115. 사원 번호를 입력하면, 해당 사원을 아래 <조건>에 따라 승진시키는 프로시저를 완성하시오.
/*
      <조건>
      프로시저명 : PROMOTE_EMPLOYEE( 사원번호 );  
      아래는 각 직급별 근속연수이다. 아래 조건에 맞추어 사원을 승진시키시오.
      부사장 16~20년   
      부장 14~15년
      차장 11~13년
      과장 7~10년
      대리 4~6년
      사원 1~3년
*/

CREATE OR REPLACE PROCEDURE PROMOTE_EMPLOYEE (
  P_EMP_ID IN NUMBER
)
AS
  -- 근속연수
  V_YEAR_OF_WORK NUMBER;
  V_JOB_CODE VARCHAR2(2);
BEGIN
  SELECT TRUNC( MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12)
  INTO V_YEAR_OF_WORK
  FROM EMPLOYEE
WHERE EMP_ID = P_EMP_ID;

  IF V_YEAR_OF_WORK > 15 THEN V_JOB_CODE := 'J2';
  ELSIF V_YEAR_OF_WORK > 13 THEN V_JOB_CODE := 'J3';
  ELSIF V_YEAR_OF_WORK > 10 THEN V_JOB_CODE := 'J4';
  ELSIF V_YEAR_OF_WORK > 6 THEN V_JOB_CODE := 'J5';
  ELSIF V_YEAR_OF_WORK > 3 THEN V_JOB_CODE := 'J6';
  ELSE
    DBMS_OUTPUT.PUT_LINE('승진 대상 사원이 아닙니다.');
  RETURN;
  END IF;

  UPDATE EMPLOYEE
  SET JOB_CODE = V_JOB_CODE
  WHERE EMP_ID = P_EMP_ID;

  DBMS_OUTPUT.PUT_LINE(P_EMP_ID || '사원을' || 
                       V_JOB_CODE || '직급으로 승진시켰습니다.');
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('존재하지 않는 사원 번호입니다.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('예외 발생 : ' || SQLERRM);
END;
/

EXECUTE PROMOTE_EMPLOYEE( 215 );

SELECT * FROM EMPLOYEE WHERE EMP_ID = 215;
