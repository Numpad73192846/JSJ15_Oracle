-- 1. 시스템 계정 접속

conn system/123456;

-- 2. ALL_USERS에서 HR 계정 조회

SELECT user_id, username
FROM ALL_USERS
WHERE username = 'HR'
;

-- 3. employees테이블 구조를 조회하는 명령

desc employees;

-- * employees테이블의 employee_id, first_name 조회

SELECT *
FROM employees;

-- 4. employees 테이블에서 사원번호, 이름, 성, 이메일, 전화번호, 입사일자, 급여로 조회
-- AS (alias) :출력되는 컬럼명에 별명을 짓는 명령어
-- * 생략가능
-- AS 사원번호      : 별칭 그대로 작성
-- AS "사원 번호"   : 띄어쓰기가 있으면 ""로 감싸서 작성
-- AS '사원 번호'   : (에러)

SELECT employee_id AS "사원 번호"
      ,first_name AS 이름
      ,last_name AS 성
      ,email AS 이메일
      ,phone_number AS 전화번호
      ,hire_date AS 입사일자
      ,salary AS 급여
FROM employees;

-- 5. employees테이블에서 JOB_ID 중복 없이 조회하기

SELECT DISTINCT job_id
FROM EMPLOYEES;

-- 6. 
-- 테이블 EMPLOYEES의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을
-- 조회하는 SQL문을 작성하시오.

SELECT *
FROM employees
WHERE salary > 6000;

-- 7. 
-- 테이블 EMPLOYEES의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을
-- 조회하는 SQL문을 작성하시오.

SELECT *
FROM employees
WHERE salary = 10000;

-- 8.
-- 테이블 EMPLOYEES의 모든 속성들을
-- SALARY를 기준으로 내림차순 정렬하고,
-- FIRST_NAME을 기준으로 오름차순 정렬하여 조회하는 SQL문을 작성하시오.

SELECT *
FROM EMPLOYEES
ORDER BY salary DESC, FIRST_NAME ASC;

-- 정렬
-- ORDER BY 컬럼명 [ASC/DESC];
-- *ASC           : 오름차순
-- *DESC          : 내림차순
-- *(생략)        : 오름차순이 기본값

-- 9.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 조건 연산
-- OR 연산 : ~또는, ~이거나
-- WHERE A OR B

SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT' 
   OR job_id = 'IT_PROG';

-- 10.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE job_id IN ('FI_ACCOUNT' , 'IT_PROG');

-- 11.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 가 아닌
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE job_id NOT IN ('FI_ACCOUNT' , 'IT_PROG');

-- 12.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘IT_PROG’ 이면서 SALARY 가 6000 이상인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE job_id = 'IT_PROG'
  AND salary >= 6000;

-- 13.
-- 테이블 EMPLOYEES 의 FIRST_NAME 이
-- ‘S’로 시작하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- LIKE '';
-- % : 빈 문자열, 1글자 이상의 문자열 대체
-- _ : 1글자 대체

-- 14.
-- 's'로 끝나는

SELECT *
FROM employees
WHERE first_name LIKE '%s';

-- 15.
-- 's'가 중간에 포함되는

SELECT *
FROM employees
WHERE first_name LIKE '%s%';

-- 16.
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 5글자인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE first_name LIKE '_____'; -- 언더바 5개

-- 17.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- 18.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 이 아닌 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

-- 19.
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년 이상인
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오.

-- 1) 문자열 --> 암시적 형변환하여 조회
SELECT *
FROM employees
WHERE hire_date >= '04/01/01';

-- 2) TO_DATE 함수로 변환하여 조회
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('04/01/01', 'YY/MM/DD');

-- 20.
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년도부터 05년도인 
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오.

-- 1) 문자열 --> 암시적 형변환하여 조회
SELECT *
FROM employees
WHERE hire_date >= '04/01/01'
  AND hire_date <= '05/12/31';

-- 2) TO_DATE 함수로 변환하여 조회
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('04/01/01', 'YY/MM/DD')
  AND hire_date >= TO_DATE('05/12/31', 'YY/MM/DD');

-- 3) BETWEEN AND 연산으로 조회
SELECT *
FROM employees
WHERE hire_date BETWEEN TO_DATE('04/01/01', 'YY/MM/DD')
                    AND TO_DATE('05/12/31', 'YY/MM/DD');

-- 21.
-- 12.45, -12.45 보다 크거나 같은 정수 중 제일 작은 수를 
-- 계산하는 SQL 문을 각각 작성하시오.
-- * dual ?
-- : 산술 연산, 함수 결과 등을 확인해볼 수 있는 임시 테이블

SELECT CEIL(12.45), CEIL(-12.45)
FROM dual;

-- 22.
-- 12.55와 -12.55 보다 작거나 같은 정수 중 가장 큰 수를 
-- 계산하는 SQL 문을 각각 작성하시오.

SELECT FLOOR(12.55), FLOOR(-12.55)
FROM dual;

-- 23.
-- ROUND(값, 자리수)
-- : 지정한 값을, 해당 자리수에서 반올림하는 함수
-- a a a a a.bbbb
-- ...  -2-1.0123

-- 0.54 를 소수점 아래 첫째 자리에서 반올림하시오.
SELECT ROUND(0.54, 0) FROM dual;

-- 0.54 를 소수점 아래 둘째 자리에서 반올림하시오.
SELECT ROUND(0.54, 1) FROM dual;

-- 125.67 을 일의 자리에서 반올림하시오.
SELECT ROUND(125.67, -1) FROM dual;

-- 125.67 을 십의 자리에서 반올림하시오.
SELECT ROUND(125.67, -2) FROM dual;

-- 24.
-- 각 소문제에 제시된 두 수를 이용하여 나머지를 구하는 SQL문을 작성하시오.
-- MOD( A, B )
-- : A를 B로 나눈 나머지를 구하는 함수

-- 3을 8로 나눈 나머지
SELECT MOD(3, 8) FROM dual;

-- 30을 4로 나눈 나머지
SELECT MOD(30, 4) FROM dual;

-- 25. 제곱수 구하기
-- POWER( A, B )
-- : A 의 B 제곱을 구하는 함수

-- 2의 10 제곱을 구하시오.
SELECT POWER(2, 10)
FROM dual;

-- 2의 31제곱을 구하시오.
SELECT POWER(2, 31)
FROM dual;

-- 26. 제곱근 구하기
-- SQRT( A )
-- : A의 제곱근을 구하는 함수
--   A는 양의 정수와 실수만 사용 가능

-- 2의 제곱근을 구하시오.
SELECT SQRT(2)
FROM daul;

-- 100의 제곱근을 구하시오.
SELECT SQRT(100)
FROM daul;

-- 27.
-- TRUNC(실수, 자리수) 
-- : 해당 수를 절삭하는 함수

-- 527425.1234 소수점 아래 첫째 자리에서 절삭
SELECT TRUNC(527425.1234, 0) FROM dual;

-- 527425.1234 소수점 아래 둘째 자리에서 절삭
SELECT TRUNC(527425.1234, 1) FROM dual;

-- 527425.1234 일의 자리에서 절삭
SELECT TRUNC(527425.1234, -1) FROM dual;

-- 527425.1234 일의 자리에서 절삭
SELECT TRUNC(527425.1234, -2) FROM dual;

-- 28. 절댓값 구하기
-- ABS( A )
-- : 값 A 의 절댓값을 구하여 변환하는 함수

-- -20 의 절댓값을 구하기
SELECT ABS(-20) FROM dual;

-- -12.456 의 절댓값을 구하기
SELECT ABS(-12.456) FROM dual;

-- 29.
-- <예시>와 같이 문자열을 대문자, 소문자, 첫글자만 대문자로 
-- 변환하는 SQL문을 작성하시오.
-- 원문 : 'AlOhA WoRlD~!'

SELECT 'AlOhA WoRlD~!' AS 원문
       ,UPPER('AlOhA WoRlD~!') AS 대문자
       ,LOWER('AlOhA WoRlD~!') AS 소문자
       ,INITCAP('AlOhA WoRlD~!') AS "첫 글자만 대문자"
FROM dual;

-- 30.
-- <예시>와 같이 문자열의 글자 수와 바이트 수를 
-- 출력하는 SQL문을 작성하시오.
-- LENGTH('문자열')  : 글자 수
-- LENGTHB('문자열') : 바이트 수

-- * 영문, 숫자, 빈칸  : 1 byte
SELECT LENGTH('ALOHA WORLD') AS "글자 수"
      ,LENGTHB('ALOHA WORLD') AS "바이트 수"
FROM dual;

-- * 한글             : 3 byte
SELECT LENGTH('알로하 월드') AS "글자 수"
      ,LENGTHB('알로하 월드') AS "바이트 수"
FROM dual;

-- 31.
-- 두 문자열을 연결하기
-- CONCAT(문자열1, 문자열2)
-- : 두 문자열을 연결하여 반환하는 함수

SELECT CONCAT('ALOHA', 'WORLD') AS 함수
      ,'ALOHA' || 'WORLD' AS 기호
FROM dual;

-- 32.
-- 문자열 부분 출력하기
-- SUBSTR(문자열, 시작번호, 글자수)
-- SUBSTRB(문자열, 시작번호, 바이트수)
-- 'www.alohaclass.kr'

-- 영문
SELECT SUBSTR('www.alohaclass.kr', 1, 3) AS "1"
      ,SUBSTR('www.alohaclass.kr', 5, 10) AS "2"
      ,SUBSTR('www.alohaclass.kr', -2, 2) AS "3"
FROM dual;

SELECT SUBSTRB('www.alohaclass.kr', 1, 3) AS "1"
      ,SUBSTRB('www.alohaclass.kr', 5, 10) AS "2"
      ,SUBSTRB('www.alohaclass.kr', -2, 2) AS "3"
FROM dual;

-- 한글
SELECT SUBSTR('www.알로하클래스.com', 1, 3) AS "1"
      ,SUBSTR('www.알로하클래스.com', 5, 6) AS "2"
      ,SUBSTR('www.알로하클래스.com', -3, 3) AS "3"
FROM dual;

SELECT SUBSTRB('www.알로하클래스.com', 1, 3) AS "1"
      ,SUBSTRB('www.알로하클래스.com', 5, 18) AS "2"
      ,SUBSTRB('www.알로하클래스.com', -3, 3) AS "3"
FROM dual;

-- 33. 
-- 문자열에서 특정 문자의 위치를 구하는 함수
-- INSTR( 문자열, 찾을 문자, 시작 번호, 순서 )
-- ex) 'ALOHACLASS'
-- 해당 문자열에서 첫글자 부터 찾아서, 2번째 A의 위치를 구하시오.
-- INSTR('ALOHACLASS', 'A', 1)
-- : 해당 문자열에서 'A' 를 1번 위치부터 찾아서 가장 처음 만나는 A의 위치를 반환
-- INSTR('ALOHACLASS', 'A', 1, 2)
-- : 해당 문자열에서 'A', 1번 위치부터 찾아서 2번째 나온 A 위치 반환

SELECT INSTR('ALOHACLASS', 'A', 1, 1) AS "1번째 A"
      ,INSTR('ALOHACLASS', 'A', 1, 2) AS "2번째 A"
      ,INSTR('ALOHACLASS', 'A', 1, 3) AS "3번째 A"
      ,INSTR('ALOHACLASS', 'A', 1, 4) AS "4번째 A"
FROM dual;

-- 34.
-- 문자열을 왼쪽/오른쪽에 출력하고, 빈공간을 특정 문자로 채우는 함수
-- LPAD( 문자열, 칸의 수, 채울 문자 )
-- : 문자열에 지정한 칸을 확보하고, 왼쪽에 특정 문자로 채움
-- RPAD( 문자열, 칸의 수, 채울 문자 )
-- : 문자열에 지정한 칸을 확보하고, 오른쪽에 특정 문자로 채움
-- 'ALOHACLASS'

SELECT LPAD('ALOHACLASS', 20,'#') AS "왼쪽"
      ,RPAD('ALOHACLASS', 20,'#') AS "오른쪽"
FROM dual;

-- 주민등록번호 뒷자리 첫 자리를 제외한 나머지 문자를 *로 마스킹하시오.

SELECT RPAD( SUBSTR('020905-3123456', 1, 8), 14,'#') AS 주민번호
FROM dual;

-- 35.
-- HIRE_DATE 입사일자를 날짜형식을 지정하여 출력하시오.
-- 형식 : 2024-03-04 (월) 12:34:56
-- TO_CHAR( 데이터, '날짜/숫자 형식' )
-- : 특정 데이터를 문자열 형식으로 변환하는 함수

SELECT first_name AS 이름
      ,TO_CHAR(hire_date, 'YYYY-MM-DD (DY) HH:MI:SS') AS 입사일자
      ,hire_date
FROM employees;

-- 36.
-- SALARY 급여를 통화형식으로 지정하여 출력하시오.

SELECT first_name AS 이름
      ,TO_CHAR(salary, '$999,999,999') AS 급여
      ,salary
FROM employees;

-- 37.
-- TO_DATE( 데이터 )
-- : 문자형 데이터를 날짜형 데이터로 변환하는 함수

SELECT '20251114' 문자
      ,TO_DATE('20251114', 'YYYYMMDD') AS 날짜1
      ,TO_DATE('2025/11/14', 'YYYY/MM/DD') AS 날짜2
      ,TO_DATE('2025-11-14', 'YYYY-MM-DD') AS 날짜3
      ,TO_DATE('2025.11.14', 'YYYY.MM.DD') AS 날짜4
FROM dual;

-- 38.
-- TO_NUMBER( 데이터 )
-- : 문자형 데이터를 숫자형 데이터로 변환하는 함수

SELECT '1,200,000' 문자
      ,TO_NUMBER('1,200,000', '999,999,999') AS 숫자
FROM dual;

-- 39.
-- 어제, 오늘, 내일 날짜를 출력하시오.
-- sysdate : 현재 날짜/시간 정보를 가지고 있는 키워드
-- 2023/05/22 - YYYY/MM/DD 형식으로 출력
-- 날짜 데이터 --> 문자 데이터 변환

SELECT sysdate FROM dual;

SELECT sysdate-1 AS 어재
      ,sysdate AS 오늘
      ,sysdate+1 AS 내일
FROM dual;

-- 40.
-- 사원의 근무달수와 근속연수를 구하시오.
-- MONTHS_BETWEEN( A, B )
-- - 날짜 A부터 B까지 개월 수 차이를 반환하는 함수
--   (단, A > B 즉, A가 더 최근 날짜로 지정해야 양수로 반환)

SELECT first_name 이름
      ,TO_CHAR( hire_date, 'YYYY.MM.DD') 입사일자
      ,TO_CHAR( sysdate, 'YYYY.MM.DD') 오늘
      ,TRUNC (MONTHS_BETWEEN( sysdate, hire_date ))  || '개월' 근무달수
      ,TRUNC (MONTHS_BETWEEN( sysdate, hire_date ) / 12)  || '년' 근속연수
FROM employees;

-- 41.
-- 오늘로부터 6개월 후의 날짜를 구하시오.
-- ADD_MONTHS( 날짜, 개월 수 )
-- : 지정한 날짜로부터 해당 개월 수를 후의 날짜를 반환하는 함수

SELECT sysdate 오늘
      ,ADD_MONTHS( sysdate, 6) "6개월 후"
      ,ADD_MONTHS( sysdate, -6) "6개월 전"
FROM dual;

SELECT '2025/10/20' 개강
      ,ADD_MONTHS( '2025/10/20', 6) 종강
FROM dual;

-- 42.
-- 오늘 이후 돌아오는 토요일을 구하시오.
-- NEXT_DAY( 날짜, 요일 )
-- : 지정한 날짜 이후 돌아오는 요일을 반환하는 함수
-- 일 월 화 수 목 금 토
-- 1  2  3  4  5 6  7

SELECT sysdate 오늘
      ,NEXT_DAY( sysdate, 7 ) "다음 토요일"
FROM dual;

-- 43.
-- 오늘 날짜와 해당 월의 월초, 월말 일자를 구하시오.
-- 월초 : TRUNC( 날짜, 'MM' )
-- 월말 : LAST_DAY( 날짜 )
/*
      날짜 데이터 : XXXXXXX.YYYYYYYY
      1970년1월1일 00시00분00초00ms
      지난 일자를 정수로 계산, 시간 정보는 소수부분으로 계산
      TRUNC( XXXXXXX.YYYYYYYY ) --> XXXXXXX
      정수 부분인 년월일만 남는다.
      마찬가지로, 월 단위를 기준으로 절삭하면 월초를 구할 수 있다.
*/

SELECT sysdate 오늘
      ,TRUNC( sysdate, 'MM' ) 월초
      ,LAST_DAY( sysdate ) 월말
FROM dual;

-- 44.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT 를 중복없이 검색하되, 
-- NULL 이면 0으로 조회하고 내림차순으로 정렬하는 SQL 문을 작성하시오.
-- DISTINCT : 중복 없이 조회
-- NVL( 값, 대체할 값 ) : 해당 값이 NULL 이면 지정된 값으로 변환하는 함수
-- * ORDER BY 의 정렬기준 컬럼은, SELECT 에서 선택한 컬럼만 사용 가능하다.

SELECT DISTINCT NVL(COMMISSION_PCT, 0) "커미션(%)"
FROM employees
ORDER BY "커미션(%)" DESC;

/*
  SELECT 컬럼
  FROM 테이블
  WHERE 조건
  GROUP BY 그룹기준
  ORDER BY 정렬기준

  * SELEFT 실행순서
  - FROM ➡️ WHERE ➡️ GROUP BY ➡️ HAVING ➡️ SELECT ➡️ ORDER BY
  1. 테이블을 선택한다
  2. 조건에 맞는 데이터를 선택한다
  3. 그룹기준을 지정한다
  4. 그룹별로 그룹조건에 맞는 데이터를 선택한다
  5. 조회할 컬럼을 선택한다
  6. 조회된 결과를 정렬기준에 따라 정렬
*/

-- 45.
-- EMPLOYEES 의 FIRST_NAME, SALARY, COMMISSION_PCT 속성을 이용하여 
-- 급여, 커미션, 최종급여를 조회하시오. 최종급여를 기준으로 내림차순 정렬하시오.
-- * 최종급여 = 급여 + (급여 * 커미션)
-- * NVL2( 값, NULL 아닐 때 값, NULL 일 때 값 )
-- * NULL 과 값을 연산한 결과는 NULL 이다.

SELECT first_name 이름
      ,salary 급여
      ,commission_pct
      ,NVL(commission_pct, 0) 커미션
      ,NVL2(commission_pct, salary + (salary * commission_pct), salary) 최종급여
      ,salary + NVL2(commission_pct, (salary * commission_pct), 0) 최종급여
FROM employees;

-- * COALESCE
-- employees 테이블에서
-- 직원의 이메일이 NULL 이면 전화번호(phone_)number를
-- 전화번호도 NULL이면 이름(first_name)을 출력하시오.

SELECT employee_id
      ,COALESCE(email, phone_number, first_name) 연락처
FROM employees; 

-- * LNNVL
-- employees 테이블에서 커미션이 0.2 이상이 아닌 직원을 조회하시오.

SELECT *
FROM employees
WHERE LNNVL(commission_pct >= 0.2);

-- * NILLIF
-- employees 테이블의 커미션이 있는 사원만 출력하시오.
-- (* 최종급여와 급여가 같으면 : 커미션 없음)
-- (* 최종급여와 급여가 같으면 : 커미션 있음)

SELECT first_name
      ,(salary + (salary * commission_pct)) 최종급여
FROM employees
WHERE NULLIF( (salary + (salary * commission_pct) ), salary ) IS NULL;

-- 46.
-- DEPARTMENTS 테이블을 참조하여, 사원의 이름과 부서명을 출력하시오.
-- DECODE( 컬럼명, 조건값1, 반환값1, 조건값2, 반환값2, ... )
-- : 지정한 컬럼의 값이 조건값에 일치하면 바로 뒤의 반환값을 출력하는 함수
-- 사원 테이블  : department_id (부서번호)

SELECT first_name 이름
      ,department_id 부서번호
      ,DECODE( department_id, 10, 'Administration',
                              20, 'Marketing',
                              30, 'Purchasing',
                              40, 'Human Resources',
                              50, 'Shipping',
                              60, 'IT',
                              70, 'Public Relations',
                              80, 'Sales',
                              90, 'Executive',
                             100, 'Finance',
                             110,	'Accounting',
                             120,	'Treasury',
                             130,	'Corporate Tax',
                             140,	'Control And Credit',
                             150,	'Shareholder Services',
                             160,	'Benefits',
                             170,	'Manufacturing',
                             180,	'Construction',
                             190,	'Contracting',
                             200,	'Operations',
                             210,	'IT Support',
                             220,	'NOC',
                             230,	'IT Helpdesk',
                             240,	'Government Sales',
                             250,	'Retail Sales',
                             260,	'Recruiting',
                             270,	'Payroll'
      ) 부서명
FROM employees;

SELECT *
FROM departments;

-- 47.
-- CASE 문
-- : 조건식을 만족할 때, 출력할 값을 지정하는 구문

SELECT first_name 이름
      ,department_id 부서번호
      ,CASE
          WHEN department_id = 10 THEN 'Administration'
          WHEN department_id = 20 THEN 'Marketing'
          WHEN department_id = 30 THEN 'Purchasing'
          WHEN department_id = 40 THEN 'Human Resources'
          WHEN department_id = 50 THEN 'Shipping'
          WHEN department_id = 60 THEN 'IT'
          WHEN department_id = 70 THEN 'Public Relations'
          WHEN department_id = 80 THEN 'Sales'
          WHEN department_id = 90 THEN 'Executive'
          WHEN department_id = 100 THEN 'Finance'
          ELSE '부서없음'
      END 부서명
FROM employees;

-- GREATEST/LEAST
-- employees 테이블에서 사원의
-- 최종급여, 급여, 보너스25% 중 가장 큰 값과
-- 최종급여, 급여, 보너스25% 중 가장 작은 값을 출력하시오.

SELECT first_name
      ,GREATEST((salary + (salary * NVL(commission_pct, 0))), salary, (salary + (salary * 0.25))) 최대
      ,LEAST((salary + (salary * NVL(commission_pct, 0))), salary, (salary + (salary * 0.25))) 최소
FROM employees;

-- 그룹함수
-- 48.
-- EMPLOYEES 테이블로 부터 전체 사원 수를 구하시오.
-- COUNT( 컬럼명 )
-- : 컬럼을 지정하여 NULL 을 제외한 데이터 개수를 반환하는 함수
-- * NULL 이 없는 데이터라면 어떤 컬럼을 지정하더라도 개수가 같으므로,
--   일반적으로 COUNT(*) 로 개수를 구한다.

-- COUNT(*) : NULL 도 포함하여 개수를 구함.

SELECT COUNT(*) 사원수
FROM employees;

-- COUNT(컬럼) : NULL 도 제외하고 개수를 구함.

SELECT COUNT(commission_pct) "성과급이 있는 사원수"
FROM employees;

-- 49.
-- 사원들의 최고급여와 최저급여를 구하시오.

SELECT MAX(salary) 최고급여
      ,MIN(salary) 최저급여
FROM employees;

-- 50.
-- 사원들의 급여 합계와 평균을 구하시오.

SELECT SUM(salary) 급여합계
      ,ROUND(salary) 급여평균
FROM employees;

-- 51.
-- 사원들의 급여 표준편차와 분산을 구하시오.

SELECT ROUND( STDDEV(salary), 2 ) 급여표준편차
      ,ROUND( VARIANCE(salary), 2) 급여분산
FROM employees;

-- * 부서별 사원 수를 구하시오

SELECT department_id 
      ,COUNT(*) 사원수
FROM employees
GROUP BY department_id
ORDER BY department_id;

