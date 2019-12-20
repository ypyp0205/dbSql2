--hash join
SELECT *
FROM dept, emp
WHERE dept.deptno = emp.deptno;
-- dept ���� �д� ����
-- join �÷��� hash �Լ��� ������ �ش� �ؽ� �Լ��� �ش��ϴ� bucket�� �����͸� �ִ´�.
-- 10 --> ccc1122 (hashvalue)

-- emp ���̺� ���� ���� ������ �����ϰ� ����
-- 10 --> ccc1122 (hashvalue)

-- �����ȣ, ����̸�, �μ���ȣ, �޿�, �μ����� ��ü �޿���


SELECT COUNT(*) --emp table�� ���� �� ��ĵ�ϱ� ������ ����� �� �� ���� (sort merge)
FROM emp;


SELECT empno, ename, deptno, sal,                   --------------SQL���� PPT.121P
        SUM(sal) OVER (ORDER BY sal 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum, --���� ó������ ���������
        
        --�ٷ� �������̶� ����������� �޿���
        SUM(sal) OVER (ORDER BY sal
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW ) c_sum2

FROM emp
ORDER BY sal;

--�ǽ� ana7

SELECT empno, ename, deptno, sal,                   --------------SQL���� PPT.121P
    
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, ename DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) c_sum

FROM emp;

--ROWS vs RANGE ���� Ȯ���ϱ�
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING ) row_sum,
        SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING ) range_sum,
        SUM(sal) OVER (ORDER BY sal) c_sum  
-- ORDER BY�ڿ� �ƹ��͵� �������� ������ 
-- �ڵ����� ����Ŭ���� (RANGE BETWEEN UNBOUNDED PRECEDING)�Է����༭ 
-- ���� ���� �����ϰ� ���´�.
FROM emp;

-- PL/SQL
-- PL/SQL �⺻����
-- DECLARE : �����, ������ �����ϴ� �κ�
-- BEGIN : PL/SQL�� ������ ���� �κ�
-- EXCEPTION : ����ó����

-- DBMS_OUTPUT.PUT_LINE �Լ��� ����ϴ� ����� ȭ�鿡 �����ֵ��� Ȱ��ȭ
SET SERVEROUTPUT ON;
DECLARE --�����
-- JAVA : Ÿ�� ������;
--PL/SQL : ������ Ÿ��;
BEGIN
    --DEPT ���̺��� 10�� �μ��� �μ��̸�, LOC ������ ��ȸ
    SELECT dname, loc
    INTO ����1, ����2
    FROM dept
    WHERE deptno = 10;
    
END;
/ ----> PL/SQL ����� �����Ѵٴ� ��
;

DESC dept;
