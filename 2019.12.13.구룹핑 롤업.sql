SELECT *
FROM emp_test
ORDER BY empno;


--emp���̺� �����ϴ� �����͸� emp_test ���̺�� ����
--���� empno�� ������ �����Ͱ� �����ϸ�
--ename update : ename || '_marge'
--���� empno�� ������ �����Ͱ����� ���� ���� ���
--emp���̺��� empno, ename emp_test �����ͷ� insert

--emp_test �����Ϳ��� ������ �����͸� ������

DELETE emp_test
WHERE empno >=7788;
COMMIT;

--emp ���̺��� 14���� �����Ͱ� ����
--emp_test ���̺��� ����� 7788���� ���� 7���� �����Ͱ� ����
--emp���̺��� �̿��Ͽ� emp_test ���̺��� �����ϰ� �Ǹ�
--emp���̺��� �����ϴ� ���� (����� 7788���� ũ�ų� ���� )7��
--emp_test�� ���Ӱ� insert�� �� ���̰�
--emp, emp_test�� �����ȣ�� �����ϰ� �����ϴ� 7���� �����ʹ�
--(����� 7788���� ���� ����)ename�÷����� ename || '_modify'����
--������Ʈ�� �Ѵ�.

/*
MERGE INTO ���̺��
USING ������� ���̺� |VIEW|SUBQUARY
ON (���̺��� ��������� �������)
WHEN MATCHED THEN
    UPDATE ....
    WHEN NOT MATCHED THEN
    INSERT ....
*/

MERGE INTO emp_test
USING emp
ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
    UPDATE SET ename = ename || '_mod'
    WHEN NOT MATCHED THEN
    INSERT VALUES (emp.empno, emp.ename);


--emp_test ���̺� ����� 9999�� �����Ͱ� �����ϸ�
--ename�� 'brown'���� update
--�������� ���� ��� empno, ename VALUES (9999, ' brown')���� insert
--���� �ó������� MERGE ������  Ȱ���Ͽ� �ѹ��� sql�� ����
--:empno - 9999, :ename -'brown'
MERGE INTO emp_test
USING dual
ON (emp_test.empno = :empno)
WHEN MATCHED THEN
    UPDATE SET ename = :ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (:empno,:ename);
        
SELECT *
FROM emp_test
WHERE empno = 9999;
        
        
--���� merge ������ ���ٸ�(** 2���� SQL�� �ʿ�)
--1. empno = 9999�� �����Ͱ� ���� �ϴ��� Ȯ��
--2-1. 1�����׿��� �����Ͱ� �����ϸ� UPDATE
--2-2. 1�����׿��� �����Ͱ� �������� ������ INSERT



SELECT deptno,sum(sal)
FROM emp
GROUP BY deptno

UNION ALL

SELECT null, SUM(sal)
FROM emp
ORDER BY deptno;

--JOIN������� Ǯ��
--emp ���̺��� 14�ǿ� �����͸� 28������ ����
--������(1 - 14, 2 - 14)�� �������� group by
--������ 1 : �μ���ȣ �������� 14 �X
--������ 2 : ��ü 14 �X
SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno, 
        SUM(emp.sal) sal
FROM emp,
        (SELECT ROWNUM rn
        FROM dept
        WHERE ROWNUM < = 2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);

----------OR---------------------------
SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno, 
        SUM(emp.sal) sal
FROM emp,
        (SELECT LEVEL rn
        FROM dual
        CONNECT BY LEVEL <= 2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);

--REPORT GROUP BY
--ROLLUP
--GROUP BY ROLLOUP(coll....)
--ROLLUP���� ����� �÷��� �����ʿ��� ���� ���� �����
--SUB GROUP�� �����Ͽ� �������� GROUP BY���� �ϳ��� SQL���� ����ǵ��� �Ѵ�.
GROUP BY ROLLUP(jov, deptno)
--GROUP BY ROLLUP(job, deptno)
--GROUP BY job, deptno
--GROUP BY job
--GROUP BY --> ��ü ���� ������� GROUP BY 

--EMP���̺��� �̿��Ͽ� �μ���ȣ��, ��ü������ �޿����� ���ϴ� ������ 
--ROLLUP ����� �̿��Ͽ� �ۼ�
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP(deptno);



--emp ���̺��� �̿��Ͽ� job, deptno�� sal+comm �հ�
--                    job �� sal + comm �հ�
--                    ��ü������ sal + comm �հ�
--ROLLUP�� Ȱ���Ͽ� �ۼ�
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);
--GROUP BY job, deptno
--GROUP BY job
--GROUP BY --> ��ü ROW���


--ROLLUP��  �÷� ������ ��ȸ ����� ������ ��ģ��.
GROUP BY ROLLUP(deptno, job);
--GROUP BY job, deptno, job
--GROUP BY deptno
--GROUP BY --> ��ü ROW���


--�ǽ�2
SELECT  DECODE(GROUPING(job), 1, '�Ѱ�', job) job,
        deptno, SUM(sal + nvl(comm, 0 )) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);

--or
SELECT  DECODE(GROUPING(job), 1, '��', job) job,
        CASE
            WHEN deptno IS NULL AND job IS NULL THEN '��'
            WHEN deptno IS NULL AND job IS NOT NULL THEN '�Ұ�'
            ELSE '' || deptno 
        END deptno,
    
      
        
        SUM(sal + nvl(comm, 0 )) sal_sum
 
FROM emp
GROUP BY ROLLUP(job, deptno);

--�ǽ�3
SELECT deptno, 
       job,
       SUM(sal + nvl(comm, 0 )) sal
FROM emp
GROUP BY ROLLUP(deptno,job);

--UNION ALL�� ġȯ
SELECT deptno, job, SUM(sal + nvl(comm, 0 )) sal
FROM emp
GROUP BY deptno, job

UNION ALL

SELECT deptno ,null, SUM(sal + nvl(comm, 0 )) sal
FROM emp
GROUP BY deptno

UNION ALL

SELECT null ,null, SUM(sal + nvl(comm, 0 )) sal
FROM emp;

--�ǽ� 4
SELECT dname, 
       job,
       SUM(sal + nvl(comm, 0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dname, job)
ORDER BY dname;

--or




--�ǽ� 5
SELECT 
       DECODE(GROUPING(dname), 1, '����', dname) dname,
       job,
       SUM(sal + nvl(comm, 0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dname, job)
ORDER BY dname,sal;


DECODE(GROUPING(job), 1, '��', job) job