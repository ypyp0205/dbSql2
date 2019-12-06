--DDL : TABLE ����
--CREATE TABLE [����ڸ�/]���̺��(
--  �÷���1 �÷�Ÿ��1,
--  �÷���1 �÷�Ÿ��2, ...
--  �÷���N �÷�Ÿ��N);
--ranger_no NUMBAER             : ������ ��ȣ
--ranger_n�� NUMBAER2(50)        : ������ �̸� 
--reg_dt DATE                   : ������ �������
--���̺� ���� DDL : Date Defination Language(������ ���Ǿ�)
--DDL rollback�� ����.(�ڵ�Ŀ�� �ǹǷ� rollback�� �� �� ����.)
CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE
);
DESC ranger;

--DDL ������ ROLLBACK ó���� �Ұ�!!!!
ROLLBACK;

SELECT *
FROM user_tables
WHERE table_name = 'RANGER';
--WHERE table_name = 'ranger';    
--����Ŭ������ ��ü ������ �ҹ��ڷ� �����ϴ��� ���������δ� �빮�ڷ� ������.

INSERT INTO ranger VALUES(1, 'brown', sysdate);
--������ ��ȸ Ȯ������
SELECT *
FROM ranger;

--DML���� DLL�� �ٸ��� ROLLBACK�� �����ϴ�.
ROLLBACK;

--ROLLBACK�� �߱� ������ DML������ ��ҵȴ�..
SELECT *
FROM ranger;
ROLLBACK;

--DATE Ÿ�Կ��� �ʵ� �����ϱ�
--EXTRACT(�ʵ�� FROM �÷�/expression)
SELECT TO_CHAR(SYSDATE, 'YYYY') yyyy,
       TO_CHAR(SYSDATE, 'MM') mm,
       EXTRACT(year FROM SYSDATE) ex_yyyy, 
       EXTRACT(month FROM SYSDATE) ex_mm
FROM dual;


--���̺� ������ �÷� ���� �������� ����
CREATE TABLE dept_test(
        deptno NUMBER(2) PRIMARY KEY,
        dname VARCHAR2(14),
        loc VARCHAR2(13));

DROP TABLE dept_test;

--dept_test ���̺��� deptno �÷��� PRIMARY KEY ���������� �ֱ� ����
--deptno�� ������ �����͸� �Է��ϰų� ���� �� �� ����.
--���� ������ �̹Ƿ� �Է¼���
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');

--dept_test �����Ϳ� deptno�� 99���� �����Ͱ� �����Ƿ�
--primary key �������ǿ� ���� �Է� �� �� ����.
--ORA-00001 unique constraint ���� ����
--����Ǵ� �������Ǹ� SYS-C007105���� ���� ����
--SYS-C007105 ���������� � ���� �������� �Ǵ��ϱ� ����Ƿ�
--�������ǿ� �̸��� �ڵ� �꿡 �� �� �ٿ� �ִ� ����
--���������� ���ϴ�
INSERT INTO dept_test VALUES(99, '���', '����');

--���̺� ������ �������� �̸��� �߰��Ͽ� �����
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test  PRIMARY KEY,
    dname VARCHAR2(14),
    lon VARCHAR2(13));
    
--INSERT ���� ����   
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, '���', '����');
















