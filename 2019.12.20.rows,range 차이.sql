--hash join
SELECT *
FROM dept, emp
WHERE dept.deptno = emp.deptno;
-- dept 먼저 읽는 형태
-- join 컬럼을 hash 함수로 돌려서 해당 해쉬 함수에 해당하는 bucket에 데이터를 넣는다.
-- 10 --> ccc1122 (hashvalue)

-- emp 테이블에 대해 위의 진행을 동일하게 진행
-- 10 --> ccc1122 (hashvalue)

-- 사원번호, 사원이름, 부서번호, 급여, 부서원의 전체 급여합


SELECT COUNT(*) --emp table을 전부 다 스캔하기 전까진 결과를 알 수 없음 (sort merge)
FROM emp;


SELECT empno, ename, deptno, sal,                   --------------SQL응용 PPT.121P
        SUM(sal) OVER (ORDER BY sal 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum, --가장 처음부터 현재행까지
        
        --바로 이전행이랑 현재행까지의 급여합
        SUM(sal) OVER (ORDER BY sal
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW ) c_sum2

FROM emp
ORDER BY sal;

--실습 ana7

SELECT empno, ename, deptno, sal,                   --------------SQL응용 PPT.121P
    
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, ename DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) c_sum

FROM emp;

--ROWS vs RANGE 차이 확인하기
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING ) row_sum,
        SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING ) range_sum,
        SUM(sal) OVER (ORDER BY sal) c_sum  
-- ORDER BY뒤에 아무것도 기입하지 않으면 
-- 자동으로 오라클리에 (RANGE BETWEEN UNBOUNDED PRECEDING)입력해줘서 
-- 위의 값과 동일하게 나온다.
FROM emp;

-- PL/SQL
-- PL/SQL 기본구조
-- DECLARE : 선언부, 변수를 선언하는 부분
-- BEGIN : PL/SQL의 로직이 들어가는 부분
-- EXCEPTION : 예외처리부

-- DBMS_OUTPUT.PUT_LINE 함수가 출력하는 결과를 화면에 보여주도록 활성화
SET SERVEROUTPUT ON;
DECLARE --선언부
-- JAVA : 타입 변수명;
--PL/SQL : 변수명 타입;
BEGIN
    --DEPT 테이블에서 10번 부서의 부서이름, LOC 정보를 조회
    SELECT dname, loc
    INTO 변수1, 변수2
    FROM dept
    WHERE deptno = 10;
    
END;
/ ----> PL/SQL 블록을 실행한다는 뜻
;

DESC dept;
