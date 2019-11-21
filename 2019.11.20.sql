-- Ư�� ���̺��� �÷� ��ȸ

--1. DESC ���̺��

--2. SELECT * FROM user_tab_columns;

 

--prod ���̺��� �÷���ȸ

DESC prod;

 

VARCHAR2, CHAR --> ���ڿ� (Character)

NUMBER --> ����

CLOB --> Character Large OBject, ���ڿ� Ÿ���� ���� ����

        --�ִ� ������ : VARCHAR2(4000), CLOB : 4GB

DATE --> ��¥(�Ͻ� = ��,��,�� + �ð�, ��, ��)

--date Ÿ�Կ� ���� ������ �����?

'2019/11/20 09:16:20' + 1 = ??

 

--USERS ���̺��� ��� �÷��� ��ȸ �غ�����

 

SELECT *

FROM users; --��� �÷� ��ȸ

 

--userid, usernm, reg_dt ������ �÷��� ��ȸ

--������ ���� ���ο� �÷��� ���� (reg_dt�� ���� ������ �� ���ο� ���� �÷�)

--��¥ + ���� ������ ?? ==> ���ڸ� ���� ��¥Ÿ���� ����� ���´� reg_dt �� 19/02/05 �϶� reg_dt+5�� 19/02/10 ��.(5���� ������)

--��Ī : ���� �÷����̳� ������ ���� ������ ���� �÷��� ������ �÷��̸��� �ο�

--      col | express [AS] ��Ī��

SELECT userid, usernm, reg_dt reg_date, reg_dt+5 AS after5day

FROM users;

 

--���� ���, ���ڿ� ��� ( oracle : ' ' , java ������ '', "")

--table�� ���� ���� ���Ƿ� �÷����� ����

--���ڿ� ���� ���� ( +, -, /, *)

--���ڿ� ���� ���� ( +���簡 ���� ����, ==>||)

SELECT 1, userid, usernm, reg_dt

FROM users;

 

SELECT (10-5)*5, 'DB SQL ����', userid, '_modified', usernm, reg_dt

FROM users;

 

SELECT 'DB SQL ����', 

usernm || '_modified', reg_dt

-- userid + '_modified', ���ڿ� ������ ���ϱ� ������ ����

        

FROM users;

--NULL : ���� �𸣴� ��
--NULL�� ���� ���� ����� �׻� NULL �̴�.
--DESC ���̺�� : NOT NULL�� �����Ǿ� �ִ� �÷����� ���� �ݵ�� ���� �Ѵ�.


SELECT *
FROM users;

--user ���ʿ��� ������ ����
DELETE users
WHERE userid NOT IN ('brown', 'sally', 'cony', 'moon', 'james' );

rollback;

commit;

SELECT userid, usernm, reg_dt
FROM users;

--null������ �����غ��� ���� moon�� reg_dt �÷��� null�� ����
UPDATE users SET reg_dt =NULL
WHERE userid = 'moon';

ROLLBACK;
COMMIT;

--users ���̺��� reg_dt �÷����� 5���� ���� ���ο� �ķ��� ����
--NULL���� ���� ������ ����� NULL�̴�.
SELECT userid, usernm, reg_dt, reg_dt + 5
FROM users;

--column aluas ( �Ǽ� select2 )

--prod ���̺��� prod_id, prod_name �� Į���� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
--(�� Prod_id > id, prod_name >name ���� �÷� ��Ī�� ����)
SELECT prod_id id, prod_name AS name
FROM prod;

--1prod ���̺��� lprod_gu,lprod_nm �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
--(�� lprod_gu > gu, lprod_nm > nm���� �÷� ��Ī�� ����)
SELECT lprod_gu , lprod_nm asdf!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!?
FROM lprod;

--buyer ���̺��� buyer_id, buyer_name �� Į���� ��ȸ�ϴ� �����k �ۼ��Ͻÿ�.
--(�� buyer id > ���̾���̵�, buyer_name > �̸����� Į�� ��Ī�� ����)

--���ڿ� �÷��� ����       (�÷� || �÷�, '���ڿ����' ||�÷�)
--                         ( CONCAT(�÷�,�÷�) )
SELECT userid, usernm,
       userid || usernm AS id_nm,
       CONCAT(userid, usernm) con_id_nm,
       -- ||�� �̿��ؼ� userid, usernm, pass
       userid ||usernm || pass id_nm_pass,
       --CONCAT�� �̿��ؼ� userid, usernm, pass
       CONCAT(CONCAT(userid,usernm), pass) con_id_nm_pass
       
From users;



--����ڰ� ������ ���̺� ��� ��ȸ
--LPROD --> SELECT * FROM LPORD;
SELECT *
FROM user_tables;


SELECT * FROM LPROD;

SELECT 'SELECT * FROM ' || table_name || ';' query
FROM user_tables ;

SELECT * FROM LPROD;


SELECT * FROM LPROD;
SELECT * FROM BUYER;
SELECT * FROM PROD;
SELECT * FROM BUYPROD;
SELECT * FROM MEMBER;
SELECT * FROM CART;
SELECT * FROM USERS;
SELECT * FROM NO_EXISTS_TABLE;



--CONCAT�Լ��� �̿��ؼ�
--1.'SELECT*FROM'
--2. table_name
--3. ';'
SELECT CONCAT(CONCAT('SELECT * FROM ', table_name ), ';')
FROM user_tables;



--WHEERE : ������ ��ġ�ϴ� �ุ ��ȸ�ϱ� ���� ���
--               �࿡ ���� ��ȸ ������ �ۼ�
SELECT userid, usernm, alias, reg_dt
FROM users
WHERE userid = 'brown';   --userid �÷��� 'brown'�� ��(row)�� ��ȸ




--emp���̺��� ��ü ������ ��ȸ (��� ��(row), ��(column))
SELECT *
FROM emp;

SELECT *
FROM dapt;

--�μ���ȣ(deptno)�� 20���� ũ�ų� ���� �μ����� ���ϴ� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno >= 20;

--�����ȣ(empno)�� 7700���� ũ�ų� ���� ����� ������ ��ȸ
SELECT *
FROM emp
WHERE empno >= 7700;

--����Ի����ڰ� 1982�� 1��1�� ������ ��� ���� ��ȸ
--���ڿ�--> ��¥ Ÿ������ ���� TO_DATE('��¥���ڿ�', '��¥���ڿ�����')
--�ѱ� ��¥ ǥ�� : ��-��-��
--�̱� ��¥ ǥ�� : ��-��-�� (01-01-2020)
SELECT empno, ename, hiredate,
       2000 no, '���ڿ����' str, TO_DATE( '19810101', 'yyyymmdd' )
FROM emp
WHERE hiredate >= TO_DATE('19820101','yyyymmdd');

--���� ��ȸ (BETWEEN ���۱��� AND �������)
--���۱���, ��������� ����
--����߿��� �޿�(sal)�� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ��� ���� ��ȸ
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--BETWEEN AND �����ڴ� �ε�ȣ �����ڷ� ��ü ����
SELECT *
FROM emp
WHERE sal >= 1000 
AND   sal <= 2000;


SELECT ename, hiredate
FROM emp
WHERE hiredate 
BETWEEN TO_DATE ('19820101','yyyymmdd')
AND TO_DATE ('19830101','yyyymmdd');


SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE ('19820101','yyyymmdd') 
AND   hiredate <= TO_DATE ('19830101','yyyymmdd');

