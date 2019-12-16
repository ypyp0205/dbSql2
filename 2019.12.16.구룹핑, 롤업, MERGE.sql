--GROUPING SETS(col1, col2)
--������ ����� ����
--�����ڰ� GROUP BY�� ������ ���� ����Ѵ�.
--ROLLUP�� �޸� ���⼺�� ���� �ʴ´�.
--GROUPING SETS(col1, col2) = GROUPING SETS(col1, col2)

--GROUP BY col1
--UNION ALL
--GROUP BY col2

--emp ���̺��� ������ job(����)�� �޿�(sal)+ ��(comm)��,
--    deptno(�μ�)�� �޿�(sal)+��(comm)�� ���ϱ�
--�������(GROUP FUNGTION) : 2���� SQL�ۼ� �ʿ�(UNION / UNION ALL)
SELECT job, null, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job

UNION ALL

SELECT '', deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY deptno;

--GROUPING SETS ������ �̿��Ͽ� ���� SQL�� ���տ����� ������� �ʰ�
--���̺��� �ѹ� �о ó��
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno);

--job, deptno�� �׷����� �� sal + comm ��
--mgr�� �׷����� �� sal + comm ��
--GROUP BY job, deptno
--UNION ALL
--GROUP BY mgr
-- -->GROUPING SETS(job, deptno,mgr)
SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum
        ,GROUPING(job), GROUPING(deptno), GROUPING(mgr)
FROM emp
GROUP BY GROUPING SETS((job,deptno), mgr);

--CUBE (col1, col2 ...)
--������ �÷��� ��� ������ �������� GROUP BY subset�� �����
--CUBE�� ������ �÷��� 2���� ��� : ������ ���� 4��
--CUBE�� ������ �÷��� 3���� ��� : ������ ���� 8��
--CUBE�� ������ �÷����� 2�� ������ �� ����� ������ ���� ������ �ȴ�.(2^n)
--�÷��� ������ �������� ������ ������ ���ϱ޼������� �þ� ���� ������
--���� ��������� �ʴ´�.

--job, deptno�� �̿��Ͽ� CUBE ����
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY CUBE(job, deptno);
--job, deptno
--1, 1 --> GROUP BY job, deptno
--1, 0 --> GROUP BY job
--0, 1 --> GROUP BY deptno
--0, 0 --> GROUP BY --emp ���̺��� ����࿡ ���� GROUP BY

--GROUP BY ����
-- FROUP BY, ROLLUP, CUBE�� ���� ����ϱ�
--������ ������ �����غ��� ���� ����� ������ �� �ִ�.
--GROP BY job, rollup(deptno), CUBE(mgr)

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

SELECT job, SUM(sal)
FROM emp
GROUP BY job;

--�ǽ�1
DROP TABLE dept_test;
--���̺� ����
CREATE TABLE dept_test AS  
SELECT *
FROM emp;
--�÷��߰�
ALTER TABLE dept_test   
ADD (empcnt NUMBER(6));
--������Ʈ
UPDATE dept_test   
SET empcnt = (SELECT count(deptno)
              FROM emp
              WHERE emp.deptno = dept_test.deptno);
SELECT *
FROM dept_test;

--�ǽ�2
DROP TABLE dept_test;
--���̺� ����
CREATE TABLE dept_test AS  
SELECT *
FROM dept;
--�ű� ������ �߰�
insert into dept_test values(99, 'ddit1', 'daejeon');
insert into dept_test values(98, 'ddit2', 'daejeon');
--emp���̺��� �������� ������ ���� �μ� ����
SELECT *
FROM dept_test 
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);
DELETE dept_test 
WHERE deptno IN (SELECT deptno
                     FROM emp);

SELECT *
FROM dept_test;

--�ǽ�3
--emp���̺��� �̿��Ͽ� emp_test ���̺� ����
DROP TABLE emp_test;
CREATE TABLE emp_test AS
SELECT *
FROM emp;


UPDATE emp_test SET sal = sal + 200
WHERE sal < (SELECT ROUND(AVG(sal), 2)
                FROM emp
                WHERE deptno = emp_test.deptno);

SELECT *
FROM emp_test;

ROLLBACK;
------MERGE ������ �̿��� ������Ʈ
SELECT deptno, AVG(sal)
FROM emp_test
GROUP BY deptno;

--MERGE ���1
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
        FROM emp_test
        GROUP BY deptno) b
ON (a.deptno = b.deptno)

WHEN MATCHED THEN
    UPDATE SET sal = sal + 200
    WHERE a.sal < b.avg_sal;


--MERGE ���2
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
        FROM emp_test
        GROUP BY deptno) b
ON (a.deptno = b.deptno)

WHEN MATCHED THEN
    UPDATE SET sal = CASE
                      WHEN a.sal < b.avg_sal THEN sal + 200
                      ELSE sal
                      END;

