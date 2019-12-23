--실습 ana0
SELECT a.ename, a.sal, a.deptno, b.rn
FROM 
(SELECT ename, sal, deptno, ROWNUM j_rn
    FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC)) a,

(SELECT rn, ROWNUM j_rn
 FROM
    (SELECT b.*, a.rn
    FROM 
    (SELECT ROWNUM rn
     FROM dual
     CONNECT BY level <= (SELECT COUNT(*) FROM emp)) a,
    
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) b
     WHERE b.cnt >= a.rn
     ORDER BY b.deptno, a.rn )) b
 WHERE a.j_rn = b.j_rn;

--실습 ana0을 분석함수로
SELECT ename, sal, deptno,
       RANK() OVER(PARTITION BY deptno ORDER BY sal ) rank,
       DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal ) dense_rank,
       ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal ) row_number  
FROM emp;    


--실습 ana1
SELECT empno, ename, sal, deptno,
       RANK() OVER(ORDER BY sal DESC, empno) sal_rank,
       DENSE_RANK() OVER(ORDER BY sal DESC, empno) sal_dense_rank,
       ROW_NUMBER() OVER(ORDER BY sal DESC, empno) sal_row_number  
FROM emp;

--실습 ana2
SELECT b.empno, b.ename, b.deptno, a.cnt
       
FROM emp b, (SELECT deptno, count(*) cnt
             FROM emp
             GROUP BY deptno) a
WHERE b.deptno = a.deptno
ORDER BY deptno;            

--사원번호, 사원이름, 부서번호, 부서의 직원수
SELECT empno, ename, deptno,
        COUNT(*) OVER(PARTITION BY deptno) cnt
FROM emp;

--실습 ana2
SELECT empno, ename, sal, deptno,
       ROUND(avg(sal) OVER(PARTITION BY deptno), 2) avg
FROM emp
ORDER BY deptno;

--실습 ana3
SELECT empno, ename, sal, deptno,
       MAX(sal) OVER(PARTITION BY deptno) MAX
FROM emp;


--실습 ana4
SELECT empno, ename, sal, deptno,
       MIN(sal) OVER(PARTITION BY deptno) MAX
FROM emp;



--전체사원을 대상으로 급여순위가 자신보다 한단계 낮은 사람의 급여
--(급여가 같은 경우, 입사일자가 빠른 사람이 높은 순위)


--실습 ana5
SELECT empno, ename, hiredate, sal,
      LEAD(sal) OVER(ORDER BY sal DESC, hiredate) lead_sal
FROM emp
ORDER BY sal DESC;

--실습 ana6
SELECT empno, ename, hiredate, job, sal,
      LAG(sal) OVER(PARTITION BY job ORDER BY sal DESC, hiredate) lead_sal
FROM emp;


--실습 no_ana3
select e1.EMPNO,e1.ENAME,e1.SAL,e1.HIREDATE,sum(e2.sal)from(
          SELECT a.*,rownum rn
FROM(
    Select empno,ename,sal,hiredate FROM emp ORDER BY sal,hiredate)a
        )e1,
             (select b.*, rownum rn FROM(
             select empno,ename,sal from emp
             order by sal,HIREDATE)b)e2
WHERE e1.rn>=e2.rn
GROUP BY  e1.EMPNO,e1.ENAME,e1.SAL,e1.HIREDATE
;





