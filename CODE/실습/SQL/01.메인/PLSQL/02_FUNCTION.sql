-- 114. 사원번호로 부서명을 구하는 함수를 정의하는 PL/SQL을 작성하시오.

CREATE OR REPLACE FUNCTION get_dept_title( p_emp_id NUMBER )
RETURN VARCHAR2
IS
  out_title    department.DEPT_TITLE%TYPE;      -- 부서명
BEGIN
     SELECT dept_title
     INTO out_title
     FROM employee e
         ,department d
     WHERE e.dept_code = d.dept_id
       AND e.EMP_ID = p_emp_id;        -- 사원번호(파라미터)
     RETURN out_title;
END;
/

-- SELECT문에서 함수 실행

SELECT emp_name 사원명
      ,get_dept_title( emp_id ) 부서명
FROM employee;

-- 블록에서 함수 실행

DECLARE
       result department.dept_title%TYPE;
BEGIN
     result := get_dept_title( 200 );
     DBMS_OUTPUT.PUT_LINE(result);
END;
/

-- 함수 생성2
-- 세후 급여

CREATE OR REPLACE FUNCTION sal_tax (
      in_salary IN NUMBER
)
RETURN NUMBER
IS
  tax NUMBER := 0.10;
  result NUMBER;
BEGIN
     result := TRUNC( in_salary - (in_salary * tax), 2);
     RETURN result;
END;
/

SELECT emp_id, emp_name
      ,salary 세전급여
      ,sal_tax( salary ) 세후급여
FROM employee;

-- 매니저 사원 구분 함수

CREATE OR REPLACE FUNCTION get_emp_type( p_emp_id NUMBER )
RETURN VARCHAR2
IS
    result VARCHAR2(10);
BEGIN
    -- 직원 타입 조회
    SELECT
        CASE
            WHEN EXISTS (SELECT 1 FROM employee WHERE manager_id = p_emp_id)
            THEN '매니저'
            ELSE '사원'
        END
    INTO result
    FROM dual;
    RETURN result;
END;
/

SELECT emp_id
      ,emp_name
      ,get_dept_title( emp_id ) 부서명
      ,get_emp_type( emp_id ) 구분
FROM employee;