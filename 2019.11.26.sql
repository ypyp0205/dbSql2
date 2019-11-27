--날짜관련 함수
--ROUND, TRUNC
--(MONTHS_BETWEEN) ADD_MONTHS, NEXT_DAY
--LAST_DAY : 해당 날짜가 속한 월의 마지막 일자(DATE)

--월 :1, 3, 5, 7, 8, 10, 12 : 31일
-- : 2 -윤년 여부 28, 29
-- : 4, 6, 9, 11 : 30일




SELECT SYSDATE, LAST_DAY (SYSDATE)
FROM dual;

-- '201912' --> date 타입으로 변경하기
--해당 날짜의 마지막 날짜로 이동
--일자 필드만 추출하기
--DATE --> 일자컬럼 (DD)만 추출
--DATE --> 문자열(DD)
--TO_CHAR(DATE, '포맷')
--DATE : LAST_DAY(TO_DATE('201912', 'yyyymm'))
--포멧 : 'DD'

SELECT :yyyymm param,
        TO_CHAR(LAST_DATE(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')dt  
FROM dual;

--SYSDATE를 YYYY/MM/DD 포맷의 문자열로 변경 (DATE -> CHAR)
--'2019/11/26' 문자열 --> DATE
SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYY/MM/DD' ), 'YYYY/MM/DD')
FROM dual;
--YYYY-MM-DD HH24:MI:SS 문자열로 변경
SELECT TO_CHAR(TO_DATE(TO_CHAR(SYSDATE, 'YYYY/MM/DD' ), 'YYYY/MM/DD'), 'YYYY-MM-DD HH24:MI:SS')
FROM dual;


--EMPNO    NOT NULL NUMBER(4)
--HIREDATE          DATE    
DESC emp;

--empno가 7369인 직원 정보 조회 하기
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';  ----------외우자 많이 쓰인다고한다.



SELECT *
FROM TABLE(dbms_xplan.display);


Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     2 |    74 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     2 |    74 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';  ----------외우자 많이 쓰인다고한다.



SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     2 |    74 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     2 |    74 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_CHAR("EMPNO")='7369')
   
SELECT 7300 + '69'
FROM dual;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = 7300 + '69';  ----------외우자 많이 쓰인다고한다.



SELECT *
FROM TABLE(dbms_xplan.display);


Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     2 |    74 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     2 |    74 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_NUMBER(TO_CHAR("EMPNO"))=7369)



--
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


--DATE타입의 묵시적 형변환은 사용을  권하지 않음
--YY -> 19
--RR --> 50 / 19, 20
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('81/06/01', 'RR/MM/DD');   ---------일할때 이걸 많이 썻다함
--WHERE hiredate >= 81/06/01';

SELECT TO_DATE('50/05/05', 'RR/MM/DD'),
       TO_DATE('49/05/05', 'RR/MM/DD'),
       TO_DATE('50/05/05', 'YY/MM/DD'),
       TO_DATE('49/05/05', 'YY/MM/DD')
FROM dual;        


--숫자 --> 문자열
--문자열 --> 숫자
--숫자 : 1000000  --> 1,000,000.00 (한국)
--숫자 : 1000000  --> 1.000.000,00 (독일)
--날짜 포맷 : YYYY, MM, DD, HH24, MI, SS
--숫자 포맷 : 숫자 표현 : 9, 자리맞춤을 위한 0표시 : 0, 화폐단위 : L 1000자리 구분:, 소수점 : .
--숫자 -> 문자열 TO_CHAR(숫자, '포맷')
--숫자 포맷이 길어질경우 숫자 자릿수를 충분히 표현
SELECT empno, ename, sal, TO_CHAR(sal, 'L009,999') fm_sal
FROM emp;


SELECT TO_CHAR(100000000000, '999,999,999,999,999')
FROM dual;

--NULL 처리 함수 : NVL, NVL2, NULLIF, COALESCE

--NVL(expr1, expr2,) : 함수 인자 두개
--expr1이 NULL이면 expr2를 반환
--expr1이 NULL이 아니면 expr1을 반환
SELECT empno, ename, comm, NVL(comm, -1) nvl_comm 
FROM emp;

--NVL2(expr1, expr2, expr3)
--expr1 IS NOT NULL expr2리턴
--expr1 IS NULL expr3리턴
SELECT empno, ename, comm, NVL2(comm, 1000, -500) nvl_comm ,
       NVL2(comm, comm, -500) nvl_comm --NVL과 동일한 결과     
FROM emp;

--NULLIF(expr1, expr2)
--expr1 = expr2 NULL을 리턴
--expr1 != expr2 expr1을 리턴
--comm이 NULL일떄 comm + 500 : NULL
--NULLIF(NULL, NULL) : NULL
--comm이 NULL이 아닐때 comm + 500 : comm + 500
--NULLIF(comm, comm + 500) : comm

SELECT empno, ename, comm, NULLIF(comm, comm + 500) nullif_comm
       
FROM emp;


--COALESCE(expr1, expr2, expr3 ......)
--인자중에 첫번째로 등장하는 NULL이 아닌 exprN을 리턴
--expr1 IS NOT NULL expr1을 리턴하고
--expr1 IS NULL COALESCE(expr2,expr3........)

SELECT empno, ename, comm, sal, COALESCE(comm, sal) coal_sal
FROM emp;


SELECT empno, ename, mgr,  
NVL(mgr, 9999) MGR_N, 
NVL2(mgr, mgr, 9999) MGR_N_2,
COALESCE(mgr, 9999) MGR_N_3 
FROM emp;


SELECT userid, usernm,
TO_CHAR(SYSDATE, 'YY/MM/DD' ) REG_DT,
TO_CHAR(SYSDATE, 'YY/MM/DD' ) N_REG_DT     ------내가하다만거
--REG_DT, 
--N_REG_DT
FROM users;


SELECT userid, usernm, reg_dt,
      NVL(reg_dt, sysdate) nvl_reg_dt,
      COALESCE(reg_dt, sysdate) n_reg_dt
FROM users
WHERE userid NOT IN ('brown');

--condition
--case
--emp.job 컬럼을 기준으로
--'SALESMAN'이면 sal * 1.05를 적용한 값 리턴
--'MANAGER'이면 sal * 1.10를 적용한 값 리턴
--'PRESIDENT'이면 sal * 1.20를 적용한 값 리턴
--위 3가지 직군이 아닐 경우 sal 리턴
--empno, ename, sal, 요율 적용한 급여 AS bouns
SELECT empno, ename, job, sal, 
       CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal
       END bonus
       
FROM emp;

--NULL처리 함수 사용하지 않고 CASE 절을 이용하여
       --comm이 NULL일 경우 -10을 리턴하도록 구성
SELECT empno, ename, job, sal, 
       CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal
       END bonus,
       comm,
      CASE
            WHEN comm IS NULL THEN -10                  --틀린
            else case_null
       
FROM emp;


--DECODE
SELECT empno, ename, job, sal,
       DECODE(job, 'SALESMAN', sal * 1.05,
                   'MANGER',   sal * 1.10,
                   'PRESIDENT',sal * 1.20,
                               sal) bonus    
FROM emp;                               



SELECT empno, ename,
       DECODE(deptno, '10', 'ACCOUNTING',
                      '20', 'RESEARCH',
                      '30', 'SALES',
                      '40', 'OPERATIONS',
                                   'DDIT') DNAME
                    
FROM emp;


SELECT EMPNO, ENAME,
        CASE
            WHEN deptno = 10 THEN 'ACCOUNTING'
            WHEN deptno = 20 THEN 'RESEARCH'
            WHEN deptno = 30 THEN 'SALES'
            WHEN deptno = 40 THEN 'OPERATIONS'
            ELSE 'DDIT'
            END dname
FROM emp;


SELECT empno, ename, hiredate,
           CASE WHEN MOD(TO_NUMBER(TO_CHAR(hiredate, 'yy')), 2) = 1 THEN '건강검진 대상자'
                     -- MOD(TO_CHAR(SYSDATE, 'YY'),2
           ELSE '건강검진 비대상자'
           END CONTACT_TO_DOCTOR
FROM emp;


SELECT empno, ename, hiredate,
           CASE 
           WHEN      MOD(TO_CHAR(hiredate, 'YY'), 2) = 
                     MOD(TO_CHAR(SYSDATE, 'YY'),2) 
           THEN '건강검진 대상자'    
           ELSE '건강검진 비대상자'
           END CONTACT_TO_DOCTOR
FROM emp; 




SELECT empno, ename, hiredate,
           CASE 
           WHEN      MOD(TO_CHAR(hiredate, 'YYYY'), 2) = 
                     MOD(TO_CHAR(SYSDATE, 'YYYY'),2) 
           THEN '건강검진 대상자'    
           ELSE '건강검진 비대상자'
           END CONTACT_TO_DOCTOR
FROM emp; 

SELECT empno, ename, hiredate,
           CASE 
           WHEN      MOD(TO_CHAR(hiredate, 'YYYY'), 2) = 
                     MOD ('2020',2 )
           THEN '건강검진 대상자'    
           ELSE '건강검진 비대상자'
           END CONTACT_TO_DOCTOR
FROM emp; 

--coud3문제
SELECT userid, usernm, alias, reg_dt,
        CASE 
        WHEN    MOD(TO_CHAR(reg_dt, 'YYYY'),2) =
                MOD(TO_CHAR(SYSDATE, 'YYYY'),2)
                THEN '건강검진 대상자'
                ELSE '건강검진 비대상자'
                END CONTACT_TO_DOCTOR
        
FROM users;

--GROUP FUNCTION
--특정 컬럼이나, 표현을 기준으로 여러행의 값을 한행의 결과로 생성
--count-건수, sum0합계, avg-평균, max-최대값 ,min-최소값
--전체 직원을 대상으로 (14건을 -> 1건)
--가장 높은 급여


--부서번호별 그룹함수 적용
SELECT deptno,
       MAX(sal) m_sal,              --부서에서 가장 높은 급여 
       MIN(sal) min_sal,            --부서에서 가장 낮은 급여
       ROUND(AVG(sal),2) avg_sal,   --부서 직원의 급여 평균
       SUM(sal) sum_sal,            --부서 직원의 급여 합계
       COUNT(sal) count_sal,        --부서의 급여 건수(null이 아닌 값이면 1건)
       COUNT(mgr) count_mgr,        --부서 직원의 관리자 건수(KING의 경우 MGR가 없다.
       COUNT(*) count_row           --부서의 조직원수
FROM emp
GROUP BY deptno;


SELECT deptno,ename,
       MAX(sal) m_sal,              --부서에서 가장 높은 급여 
       MIN(sal) min_sal,            --부서에서 가장 낮은 급여
       ROUND(AVG(sal),2) avg_sal,   --부서 직원의 급여 평균
       SUM(sal) sum_sal,            --부서 직원의 급여 합계
       COUNT(sal) count_sal,        --부서의 급여 건수(null이 아닌 값이면 1건)
       COUNT(mgr) count_mgr,        --부서 직원의 관리자 건수(KING의 경우 MGR가 없다.
       COUNT(*) count_row           --부서의 조직원수
FROM emp
GROUP BY deptno, ename;

--SELECT 절에는 GROUP BY 절에 표현된 컬럼 이외의 컬럼이 올 수 없다.
--논리적으로 성립이 되지 않음 (여러명의 직원 정보로 한건의 데이터로 그루핑)
--단 예외적으로 상수값들은 SELECT 절에 표현이 가능
SELECT deptno,
       MAX(sal) m_sal,              --부서에서 가장 높은 급여 
       MIN(sal) min_sal,            --부서에서 가장 낮은 급여
       ROUND(AVG(sal),2) avg_sal,   --부서 직원의 급여 평균
       SUM(sal) sum_sal,            --부서 직원의 급여 합계
       COUNT(sal) count_sal,        --부서의 급여 건수(null이 아닌 값이면 1건)
       COUNT(mgr) count_mgr,        --부서 직원의 관리자 건수(KING의 경우 MGR가 없다.
       COUNT(*) count_row           --부서의 조직원수
FROM emp
GROUP BY deptno;

--그룹함수에서는 NULL 컬럼은 계산에서 제외된다.
--emp테이블에서 comm컬럼이 null이 아닌 데이터는 4건이 존재, 9건은 NUll)
SELECT COUNT(comm),   --NULL이 아닌 값의 개수 4
       SUM(comm) sum_comm,
       SUM(sal) sum_sal,--NULL값을 제외, 300 + 500 + 1400 + 0 = 2200
       SUM(sal + comm) tot_sal_sum,
       SUM(sal + NVL(comm, 0)) tot_sal_sum
FROM emp;

--WHERE 절에는 GROUP 함수를 표현 할 수 없다.
--부서별 최대 급여 구하기
--deptno, 최대급여
SELECT deptno, MAX(sal) m_sal
FROM emp
WHERE MAX(sal) > 3000  --ORA-00934 WHERE 절에는 GROUP 함수가 올 수 없다.
GROUP BY deptno;

SELECT deptno,  MAX(sal) m_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;

--1번
SELECT      MAX(sal) MAX_sal, 
            MIN(sal) MIN_sal,
            AVG(sal) AVG_sal,
            SUM(sal) SUM_sal,
            COUNT(sal) COUNT_sal,
            COUNT(mgr) COUNT_mgr,
            COUNT(*) COUNT_ALL
FROM emp
GROUP BY deptno;

--2번          
SELECT deptno, MAX(sal) MAX_sal, 
            MIN(sal) MIN_sal,
            AVG(sal) AVG_sal,
            SUM(sal) SUM_sal,
            COUNT(sal) COUNT_sal,
            COUNT(mgr) COUNT_mgr,
            COUNT(*) COUNT_ALL
FROM emp
GROUP BY deptno;

--3번
SELECT deptno, 
            MAX(sal) MAX_sal, 
            MIN(sal) MIN_sal,
            AVG(sal) AVG_sal,
            SUM(sal) SUM_sal,
            COUNT(sal) COUNT_sal,
            COUNT(mgr) COUNT_mgr,
            COUNT(*) COUNT_ALL
FROM emp
GROUP BY deptno;

--4번
--grp4
--hiredate 컬럼의 값을 yyyymm 형식으로 만들기
SELECT TO_CHAR(hiredate,'YYYYmm') hire_yyyymm, COUNT(*) cnt
       
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYmm');

--5번
SELECT TO_CHAR(hiredate, 'yyyy') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyy');

--6번

SELECT COUNT(deptno) cnt
FROM dept;

--전체 부서수 구하기 (dept)


--7번
SELECT COUNT(COUNT(deptno)) cnt
FROM emp
GROUP BY deptno;

SELECT COUNT(DISTINCT deptno)
FROM emp;


--join
--1. 테이블 구조변경 (컬럼 추가)
--2. 추가된 컬럼에 값을 update
--dename 컬럼을 emp 테이블에 추가
DESC emp;
DESC dept;
--컬럼추가(daname, VARCHAR(14))
ALTER TABLE emp ADD (dname VARCHAR2(14));
DESC emp;
SELECT *
FROM emp;

UPDATE emp SET dname = CASE
                            WHEN deptno = 10 THEN 'ACCOUNTING'
                            WHEN deptno = 20 THEN 'RESERCH'
                            WHEN deptno = 30 THEN 'SALES'
                            END;
COMMIT;

SELECT empno, ename, deptno, dname
FROM emp;
                            
--SALES--> MARKET SALES
--총 6건의 데이터 변경이 필요하다.
--값의 중복이 있는 형태 (반 정규형)
--UPDATE emp SET dname = 'MARKET SALES'
--WHERE dname = 'SALES';


--emp 테이블, dept 테이블 조인
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;
                            
                            
                            