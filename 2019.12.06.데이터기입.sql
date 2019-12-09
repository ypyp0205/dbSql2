SELECT *
FROM dept;

--dept ���̺� �μ���ȣ 99, �μ��� ddit, ��ġ daejeon
INSERT INTO dept VALUES ( 99, 'ddit', 'daejeon');
COMMIT;

--UPDATE : ���̺� ����� �÷��� ���� ����
--UPDATE ���̺�� SET �÷��� 1= �����Ϸ����ϴ� ��1, �÷���2 = �����Ϸ����ϴ� ��2...
--[WHERE row ��ȸ ����] --��ȸ���ǿ� �ش��ϴ� �����͸� ������Ʈ�� �ȴ�.

--�μ���ȣ�� 99���� �μ��� �μ����� ���IT��, ������ ���κ������� ����
UPDATE dept SET dname = '���IT', loc = '���κ���'
WHERE deptno = 99;

SELECT *
FROM dept;

--���� QUERY�� �����ϸ� WHERE���� ROW ���� ������ ���� ������
--dept ���̺��� ��� �࿡ ���� �μ���, ��ġ ������ �����Ѵ�.
UPDATE dept SET dname = '���IT', loc = '���κ���';


--������Ʈ���� ������Ʈ �Ϸ����ϴ� ���̺��� WHERE���� ����� �������� 
--SELECT�� �Ͽ� ������Ʈ ��� ROW�� Ȯ���غ���
SELECT *
FROM dept
WHERE deptno = 99;

--SLUBQUERY�� �̿��� UPDATE
--emp ���̺� �ű� ������ �Է�
--�����ȣ 9999, ����̸� brown, ���� : null
INSERT INTO emp (empno, ename) VALUES ( 9999, 'brown');
SELECT *
FROM emp
WHERE empno = 9999;
COMMIT;

--�����ȣ�� 9999�� ����� �Ҽ� �μ��� �������� SMITH����� �μ�, ������ ������Ʈ
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'), 
                 job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno = 9999;

--DELETE : ���ǿ� �ش��ϴ� ROW�� ����
--�÷��� ���� ����??(NULL)������ �����Ͽ��� --> UPDATE

--DELETE ���̺��
--[WHERE ����]

--UPDATE������ ���������� DELETE ���� ���������� �ش� ���̺��� WHERE������ ���� 
--�ϰ� �Ͽ� SELECT�� ����, ������ ROW�� ���� Ȯ���غ���

--emp���̺� �����ϴ� �����ȣ 9999�� ����� ����
DELETE emp
WHERE empno = 9999;

COMMIT;

SELECT *
FROM emp;

--�Ŵ����� 7698�� ��� ����� ����
DELETE emp
WHERE empno IN(SELECT empno
                FROM emp
                WHERE mgr = 7698);
SELECT *
FROM emp;

ROLLBACK;

--�� ������ �Ʒ� ������ ����
DELETE emp
WHERE mgr = 7698;


