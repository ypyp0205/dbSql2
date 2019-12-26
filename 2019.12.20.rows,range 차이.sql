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
    -- PL/SQL : ������ Ÿ��;
/*    v_dname VARCHAR2(14);
      v_loc VARCHAR2(13);    */
    --���̺� �÷��� ���Ǹ� �����Ͽ� ������ Ÿ���� �����Ѵ�.
    v_dname dept.dname %TYPE;
    v_loc dept.loc %TYPE;
    
BEGIN
    --DEPT ���̺��� 10�� �μ��� �μ��̸�, LOC ������ ��ȸ
    SELECT dname, loc
    INTO v_dname, v_loc
    FROM dept
    WHERE deptno = 10;
    -- string a = "t";
    -- string b = "c";
    -- system.out.println(a + b);
    DBMS_OUTPUT.PUT_LINE(v_dname || v_loc);    
END;
/ 
----> PL/SQL ����� �����Ѵٴ� ��


-- 10�� �μ��� �μ��̸�, ��ġ������ ��ȸ�ؼ� ������ ���
-- ������ DBMS_OUTPUT.PUT_LINE�Լ��� �̿��Ͽ� console�� ���
CREATE OR REPLACE PROCEDURE printdept IS
-- �����(�ɼ�)
     dname dept.dname%TYPE;
     loc dept.loc%TYPE;
     
-- �����
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
-- ����ó����(�ɼ�)
END;
/



exec printdept;




--���� �߰�
CREATE OR REPLACE PROCEDURE printdept 
-- �Ķ���͸� IN/OUT Ÿ��
-- p_�Ķ�����̸�
(p_deptno IN dept.deptno%TYPE)
IS
-- �����(�ɼ�)
     dname dept.dname%TYPE;
     loc dept.loc%TYPE;
     
-- �����
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = p_deptno;
    
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
-- ����ó����(�ɼ�)
END;
/

exec printdept(10);



--�ǽ� pro_1
CREATE OR REPLACE PROCEDURE printtemp
(p_empno IN emp.empno%TYPE)
IS
     ename emp.ename%TYPE;
     dname dept.dname%TYPE;
BEGIN
    SELECT ename, dname
    INTO ename, dname
    FROM emp, dept
    WHERE emp.empno = p_empno
    AND dept.deptno = emp.deptno;
    
    DBMS_OUTPUT.PUT_LINE(ename || ' ' || dname);
END;
/
  
 exec printtemp(7369); 
  
  
--�ǽ� pro_2
CREATE OR REPLACE PROCEDURE registdept_test
(p_deptno IN dept.deptno%TYPE,
 p_dname IN dept.dname%TYPE,
 p_loc IN dept.loc%TYPE)
IS
    deptno dept_test.deptno%TYPE;
    dname dept_test.dname%TYPE;
    loc dept_test.loc%TYPE;
BEGIN

INSERT INTO dept_test VALUES (99, 'DDIT', 'DAEJEON');
DBMS_OUTPUT.PUT_LINE(deptno || ' ' || dname || ' ' || loc);
END;
/

exec registdept_test(99, 'DDIT', 'DAEJEON');



--�ǽ� pro_3
CREATE OR REPLACE PROCEDURE UPDATEdept_test
(p_deptno IN dept_test.deptno%TYPE,
 p_dname IN dept_test.dname%TYPE,
 p_loc IN dept_test.loc%TYPE)
IS
    
BEGIN

UPDATE dept_test SET deptno = 99, dname = 'DDIT', loc = 'DAEJEON'  
            WHERE deptno = p_deptno;
            COMMIT;
END;
/

exec UPDATEdept_test(99, 'DDIT', 'DAEJEON');

SELECT *
FROM dept_test;
  
