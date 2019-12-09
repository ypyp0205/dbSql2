SELECT deptno
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = (SELECT deptno                  ------서브커리라고한다.
                FROM emp
                WHERE ename = 'SMITH');
   

SELECT empno, ename, deptno, 
       (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname
FROM emp;

--SCALAR SUBQUERY
--SELECT 절에 표현된 서브 쿼리
--한 행, 한 COLUMN을 조회해야 한다.
SELECT empno, ename, deptno, 
       (SELECT dname FROM dept ) dname
FROM emp;

--INLINE VIEW
--FROM절에 사용되는 서브 쿼리

--SUBQUERY
--WHERE에 사용되는 서브쿼리


SELECT sum(sal)
FROM emp;

--실습1
SELECT COUNT(*) cnt
FROM emp
WHERE sal > (SELECT AVG(SAL)
            FROM emp);
--실습2
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp
WHERE sal > (SELECT AVG(SAL)
            FROM emp);

--실습3

SELECT *
FROM emp;

SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno 
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));

--SMITH 혹은 WARD 보다 급여를 적게 받는 직원조회
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp
WHERE sal < ANY(SELECT sal     --800, 1250
                FROM emp    
                WHERE ename IN ('SMITH', 'WARD'));


SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp
WHERE sal <= ALL(SELECT sal     --800, 1250
                FROM emp    
                WHERE ename IN ('SMITH', 'WARD'));
                
                
--관리자 역할을 하지 않는 사원 정보 조회
--NOT IN 연산자 사용시 NULL이 데이터에 존재하지 않아야 정상동작 한다.
SELECT *
FROM emp  --사원 정보 조회 --> 관리자역할을 하지 않는
WHERE empno NOT IN
            (SELECT  NVL(mgr, -1)
            FROM emp);

SELECT *
FROM emp  --사원 정보 조회 --> 관리자역할을 하지 않는
WHERE empno NOT IN
            (SELECT  mgr
            FROM emp
            WHERE mgr IS NOT NULL);

--pair wise (여러컬럼의 값을 동시에 만족 해야하는 경우)
--ALLEN CLARK의 매니저와 부서번호가 동시에 같은 사원 정보 조회
--(7698, 30)
--(7839,10)

SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));

--매니저가 7698이거나 7839 이면서
--소속부서가 10번 이거나 30번인 지구언 정보 조회
--7698, 10
--7698, 30
--7639, 10
--7639, 30
SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
              FROM emp
              WHERE empno IN (7499, 7782))
AND deptno IN (SELECT deptno
               FROM emp
               WHERE empno IN (7499, 7782));
          
--비상호 연관 서브 쿼리
--메인쿼리의 컬럼을 서브쿼리에서 사용하지 않는 형태의 서브 쿼리



--비상호 연관 서브쿼리의 경우 메인쿼리에서 사용하는 테이블, 서브쿼리 조회 순서를 성능적으로 유리한 쪽으로 판단하여 순서를 결정한다.
--메인쿼리의 emp테이블을 먼저 읽을 수도 있고, 서브쿼리의 emp 테이블을 먼저 읽을 수도 있다.

--비상호 연과 서브쿼리에서 서브쿼리 쪽 테이블을 먼저 읽을 때는 
--서브쿼리가 제공자 역할을 했다 라고 모 도서에서 표현
--비상호 연과 서브쿼리에서 서브쿼리 쪽 테이블을 나중에 읽을 때는 
--서브쿼리가 확인자 역할을 했다 라고 모 도서에서 표현

--직원의 급여 평균보다 높은 급여를 받는 직원 정보 조회
--직원의 급여 평균
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

--상호연관 서브쿼리
--해당직원이 속한 부서의 급여평균보다 높은 급여를 받는 직원 조회

SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal)
             FROM emp
             WHERE deptno = m.deptno);



--10번 부서의 급여평균
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno;







































