--emp 테이블, dept 테이블 조인
EXPLAIN PLAN FOR
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno = 10;


SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Plan hash value: 615168685
 
---------------------------------------------------------------------------
| Id  | Operation          | Name | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |      |    12 |   264 |     7  (15)| 00:00:01 |
|*  1 |  HASH JOIN         |      |    12 |   264 |     7  (15)| 00:00:01 |
|*  2 |   TABLE ACCESS FULL| DEPT |     2 |    26 |     3   (0)| 00:00:01 |
|*  3 |   TABLE ACCESS FULL| EMP  |     6 |    54 |     3   (0)| 00:00:01 |
---------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
   2 - filter("DEPT"."DEPTNO"=10)
   3 - filter("EMP"."DEPTNO"=10)

SELECT ename, deptno
FROM emp;

SELECT deptno, dname
FROM dept;


SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno
AND emp.deptno = 10;




--natural join : 조인 테이블간 같은 타입, 같은 이름의 컬럼으로 같은 값을 갖을 경우 조인
DESC emp;
DESC dept;
SELECT deptno, emp.empno, ename
FROM emp NATURAL JOIN dept;

DESC emp;
DESC dept;

--ANSI SQL
SELECT deptno, a.empno, ename
FROM emp a NATURAL JOIN dept b;

--oracle 문법
SELECT a.deptno, emp.empno, ename
FROM emp a, dept b
WHERE emp.deptno = dept.deptno;


--JOIN USING
--JOIN 하려고하는 테이블간 동일한 이름의 컬럼이 두개 이상일 때
--JOIN 컬럼을 하나만 사용하고 싶을 때

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);

--ORACLE SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM emp, dept
WHERE 1=1;

--ANSSI JOIN with ON
--조인 하고자 하는 테이블의 컬럼 이름이 다를때
--개발자가 조인 조건을 직접 제어할 때

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);


--oracle
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : 같은 테이블간 조인
--emp 테이블간 조인 할만한 사항 : 직원의 관리자 정보 조회
--직원의 관리자 정보를 조회
--직원이름, 관리자이름

--ANSI
--직원 이름, 직원의 상급자 이름, 직원의 상급자의 상급자 이름
SELECT*
FROM emp e JOIN emp m ON(e.mgr = m.empno);

SELECT e.ename, m.ename mgr
FROM emp e JOIN emp m ON(e.mgr = m.empno);

--ORACLE
--직원이름, 직원의 관리자 이름, 직원의 관리자의 관리자 이름
SELECT e.ename, m.ename mgr
FROM emp e, emp m
WHERE e.mgr = m.empno;

SELECT e.ename, m.ename mgr, hm.ename highmgr
FROM emp e, emp m, emp hm
WHERE e.mgr = m.empno
AND m.mgr = hm.empno;


SELECT e.ename, m.ename mgr, hm.ename highmgr, hhm.ename hhmgr
FROM emp e, emp m, emp hm, emp hhm
WHERE e.mgr = m.empno
AND m.mgr = hm.empno
AND hm.mgr = hhm.empno;

--여러테이블을 ANSI JOIN을 이용한 JOIN
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e JOIN emp m ON ( e.mgr = m.empno)
           JOIN emp t ON ( m.mgr = t.empno)
           JOIN emp k ON ( t.mgr = k.empno);


--직원의 이름과, 해당 직원의 관리자 이름을 조회한다.
--단 직원의 사번이 7369~7698인 직원을 대상으로 조회

--WHERE
SELECT a.ename, b.ename mgr, c.empno
FROM emp a, emp b, emp c
WHERE
AND
AND;



--ANSI
SELECT a.ename, b.ename mgr
FROM emp a JOIN emp b ON (a.mgr = b.empno)
WHERE  a.empno  BETWEEN 7369 AND 7698;

--NON-EQUI JOIN : 조인 조건이 =(equal)이 아닌 JOIN
--!=, BETWEEN___AND___


SELECT *
FROM salgrade; 


--where
SELECT empno, ename, sal, grade
FROM emp, salgrade 
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

--ANSI
SELECT empno, ename, sal, grade
FROM emp JOIN salgarde ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal;  ________________


--실습1
SELECT empno, ename, emp.deptno, emp.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;



SELECT empno, ename, emp.deptno, emp.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno;

--실습1
SELECT empno, ename, emp.deptno, emp.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno IN (10, 30);             --(emp.deptno = 10 OR emp.deptno = 30);


SELECT empno, ename, emp.deptno, emp.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno
         JOIN dept ON emp.deptno = 30;

--실습2
SELECT empno, ename, sal, emp.deptno, emp.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500;

SELECT empno, ename, sal, emp.deptno, emp.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno
AND sal >2500;




SELECT *
FROM emp;

SELECT *
FROM dept;











