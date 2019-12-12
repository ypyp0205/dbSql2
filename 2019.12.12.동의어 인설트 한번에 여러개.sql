--��Ī : ���̺�, �÷��� �ٸ� �̸����� ��Ī
-- [AS] ��Ī��
--SELECT empno [AS] eno
--FROM emp e;

--SYNONYM (���Ǿ�)
--����Ŭ ��ü�� �ٸ��̸����� �θ� �� �ֵ��� �ϴ� ��
--���࿡ emp���̺��� e��� �ϴ� synoym(���Ǿ�)�� ������ �ϸ�
--������ ���� SQL�� �ۼ� �� �� �ִ�.
--SELECT *
--FROM e;

SELECT *
FROM employees;

--sem������ SYNONYM ���� ������ �ο�
GRANT CREATE SYNONYM TO YP0205;

--emp ���̺��� ����Ͽ� synonym e�� ����
--CREATE SYNONYM �ó�� �̸� FOR ����Ŭ��ü;
CREATE SYNONYM e FOR emp;


--emp ��� ���̺� �� ��ſ� e ��� �ϴ� �ó���� ����Ͽ� ������ �ۼ� �� �� �ִ�.
SELECT *
FROM e;

--YP0205 ������ fastfood ���̺��� hr ���������� �� �� �ֵ���
--���̺� ��ȸ ������ �ο�
GRANT SELECT ON fastfood TO hr;

--
SELECT *
FROM dictionary;

--������ sql�� ���信 ������ �Ʒ� sql���� �ٸ���
SELECT /* 20191118_205 */ * FROM emp;
SELECT /* 20191118_205 */ * FROM EMP;
SELECt /* 20191118_205 */ * FROM EMP;

SELECT /* 20191118_205 */ * FROM EMP WHERE empno = 7369;
SELECT /* 20191118_205 */ * FROM EMP WHERE empno = 7499;
SELECT /* 20191118_205 */ * FROM EMP WHERE empno = :empno;

--multiple insert
DROP TABLE emp_test;

--emp ���̺��� empno, ename �÷����� emp_test, emp_test2 ���̺���
--����(CATS, �����͵� ���� ����)

CREATE TABLE emp_test AS
CREATE TABLE emp_test2 AS
SELECT empno, ename
FROM emp;

CREATE TABLE emp_test2 AS
SELECT empno, ename
FROM emp;



------------------------------------
SELECT empno, ename
FROM emp_test;

SELECT empno, ename
FROM emp_test2;

--uncodititional insert
--���� ���̺� �����͸� ���� �Է�
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 9999, 'brown' FROM DUAL UNION ALL
SELECT 9998, 'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000;

SELECT *
FROM emp_test2
WHERE empno > 9000;


--���̺� �� �ԷµǴ� �������� �÷��� ���� ����
ROLLBACK;
INSERT ALL
    INTO emp_test (empno, ename) VALUES(eno, enm)
    INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno, 'brown' enm FROM DUAL UNION ALL
SELECT 9998, 'cony' FROM DUAL;


SELECT *
FROM emp_test
WHERE empno > 9000

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 9000;



--CONDITIONAL INSERT
--���ǿ� ���� ���̺� �����͸� �Է�
ROLLBACK;
/*
    CASE
        WHEN ���� THEN ----   //IF 
        WHEN ���� THEN ----   //ELSE IF    
        ELSE ----            //ELSE
*/        
INSERT ALL
    WHEN eno > 9000 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    WHEN eno > 9500 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)    
    ELSE
        INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno, 'brown' enm FROM DUAL UNION ALL
SELECT 8998, 'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 8000;







ROLLBACK;

INSERT FIRST
    WHEN eno > 9000 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    WHEN eno > 9500 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)    
    ELSE
        INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno, 'brown' enm FROM DUAL UNION ALL
SELECT 8998, 'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 8000;









