--emp ���̺�, dept ���̺� ����
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




--natural join : ���� ���̺� ���� Ÿ��, ���� �̸��� �÷����� ���� ���� ���� ��� ����
DESC emp;
DESC dept;
SELECT deptno, emp.empno, ename
FROM emp NATURAL JOIN dept;

DESC emp;
DESC dept;

--ANSI SQL
SELECT deptno, a.empno, ename
FROM emp a NATURAL JOIN dept b;

--oracle ����
SELECT a.deptno, emp.empno, ename
FROM emp a, dept b
WHERE emp.deptno = dept.deptno;


--JOIN USING
--JOIN �Ϸ����ϴ� ���̺� ������ �̸��� �÷��� �ΰ� �̻��� ��
--JOIN �÷��� �ϳ��� ����ϰ� ���� ��

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
--���� �ϰ��� �ϴ� ���̺��� �÷� �̸��� �ٸ���
--�����ڰ� ���� ������ ���� ������ ��

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);


--oracle
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : ���� ���̺� ����
--emp ���̺� ���� �Ҹ��� ���� : ������ ������ ���� ��ȸ
--������ ������ ������ ��ȸ
--�����̸�, �������̸�

--ANSI
--���� �̸�, ������ ����� �̸�, ������ ������� ����� �̸�
SELECT*
FROM emp e JOIN emp m ON(e.mgr = m.empno);

SELECT e.ename, m.ename mgr
FROM emp e JOIN emp m ON(e.mgr = m.empno);

--ORACLE
--�����̸�, ������ ������ �̸�, ������ �������� ������ �̸�
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

--�������̺��� ANSI JOIN�� �̿��� JOIN
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e JOIN emp m ON ( e.mgr = m.empno)
           JOIN emp t ON ( m.mgr = t.empno)
           JOIN emp k ON ( t.mgr = k.empno);


--������ �̸���, �ش� ������ ������ �̸��� ��ȸ�Ѵ�.
--�� ������ ����� 7369~7698�� ������ ������� ��ȸ

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

--NON-EQUI JOIN : ���� ������ =(equal)�� �ƴ� JOIN
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


--�ǽ�1
SELECT empno, ename, emp.deptno, emp.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;



SELECT empno, ename, emp.deptno, emp.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno;

--�ǽ�1
SELECT empno, ename, emp.deptno, emp.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno IN (10, 30);             --(emp.deptno = 10 OR emp.deptno = 30);


SELECT empno, ename, emp.deptno, emp.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno
         JOIN dept ON emp.deptno = 30;

--�ǽ�2
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











