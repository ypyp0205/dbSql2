--with
--with 블록이름 AS (
--  서브쿼리
--)
--SELECT *
--FROM 블록이름

--deptno, avg(sal) avg_sal
--해당 부서의 급여 평균이 전체 직원의 급여 평균보다 높은 부서에 한해 조회
SELECT deptno, ROUND(avg(sal),2) avg_sal
FROM emp
GROUP BY deptno
HAVING AVG(sal) > (SELECT AVG(sal) FROM emp);

--WITH 절을 사용하여 위의 쿼리를 작성
WITH dept_sal_avg AS
                (SELECT deptno, ROUND(avg(sal),2) avg_sal
                    FROM emp
                    GROUP BY deptno),
                emp_sal_avg AS
                    (SELECT AVG(sal) avg_sal 
                     FROM emp)
                       
SELECT *
FROM dept_sal_avg
WHERE avg_sal > (SELECT avg_sal FROM emp_sal_avg);                                              
                                                                    
WITH test AS(
    SELECT 1 ,'TEST' FROM DUAL UNION ALL
    SELECT 2 ,'TEST2' FROM DUAL UNION ALL
    SELECT 3 ,'TEST3' FROM DUAL)
SELECT *
FROM test;


--계층쿼리                                                                    
--달력만들기
--CONNECT BY LEVEL <= N
--테이블의 ROW 건수를 N만큼 반복한다.
--CONNECT BY LEVEL 절을 사용한 쿼리에서는
--SELECT 절에서 LEVEL 이라는 특수 컬럼을 사용할 수 있다.
--계층을 표현하는 특수 컬럼으로 1쿠터 증가하며 ROWNUM과 유사하나
--추후 배우게될 START WITH, CONNECT BY 절에서 다른점을 배우게 된다.

--2019년 11월은 30일까지 존재
--201911
--일자 + 정수 = 정수만큼 미래의 일자
--201911 --> 해당년월의 날짜가 몇일 까지 존재 하는가??
SELECT TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 30;                                                                    
                   
                   
--201911 --> 30
--201912 --> 31
--202402 --> 29
--201902 --> 28
--1-일, 2-월, ......7-토
--그달의 마지막 날짜, 요일, 
SELECT /*일요일이면 날짜, 화요일이면 날짜, ....토요일이면 날짜*/
       /* dt, d,*/ dt - (d - 1),
        MAX(DECODE(d, 1, dt)) 일요일, MAX(DECODE(d, 2, dt)) 월요일, MAX(DECODE(d, 3, dt)) 화요일,
        MAX(DECODE(d, 4, dt)) 수요일, MAX(DECODE(d, 5, dt)) 목요일, MAX(DECODE(d, 6, dt)) 금요일,
        MAX(DECODE(d, 7, dt)) 토요일
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1) dt,                     --요일 20191130
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1), 'D') d,        --일자
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL), 'IW') iw         --주차 20191201
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')) --30                                                                    
GROUP BY dt - (d - 1)
ORDER BY dt - (d - 1);

--12월 문제해결
SELECT /*일요일이면 날짜, 화요일이면 날짜, ....토요일이면 날짜*/
       /* dt, d,*/ iw 주차,
        MAX(DECODE(d, 1, dt)) 일요일, MAX(DECODE(d, 2, dt)) 월요일, MAX(DECODE(d, 3, dt)) 화요일,
        MAX(DECODE(d, 4, dt)) 수요일, MAX(DECODE(d, 5, dt)) 목요일, MAX(DECODE(d, 6, dt)) 금요일,
        MAX(DECODE(d, 7, dt)) 토요일
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1) dt,                     --요일 20191130
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1), 'D') d,        --일자
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL), 'IW') iw         --주차 20191201
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')) --30                                                                    
GROUP BY iw
ORDER BY 토요일;                                   
          
--실습1
SELECT /*1월 컬럼, 2월 컬럼,*/
    NVL(MIN(DECODE(mm, '01', sales_sum)), 0) JAN, NVL(MIN(DECODE(mm, '02', sales_sum)), 0) FEB, 
    NVL(MIN(DECODE(mm, '03', sales_sum)), 0) MAR, NVL(MIN(DECODE(mm, '04', sales_sum)), 0) APR, 
    NVL(MIN(DECODE(mm, '05', sales_sum)), 0) MAY, NVL(MIN(DECODE(mm, '06', sales_sum)), 0) JUN
FROM          
(SELECT TO_CHAR(DT, 'MM') mm, SUM(sales) sales_sum
FROM sales
GROUP BY TO_CHAR(dt, 'MM'));
                                                                    



SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd = 'dept0'   --시작점은 depted = 'dept0' --> XX회사(최상위조직)
CONNECT BY PRIOR deptcd = p_deptcd;
    
    
    
/*
    dept0(XX회사)
        dept0_00(디자인부)
            dept0_00_0(디자인팀)
        dept0_01(정보기획부)
            dept0_01_0(기획팀)
                dept0_00_0_0(기획파트)
        dept0_02(정보시스템부)        
            dept0_02_0(개발1팀)
            dept0_02_1(개발2팀)    