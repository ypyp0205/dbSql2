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
UPDATE dept SET dname = '���IT', loc = '���κ���'


--������Ʈ���� ������Ʈ �Ϸ����ϴ� ���̺��� WHERE���� ����� �������� 
--SELECT�� �Ͽ� ������Ʈ ��� ROW�� Ȯ���غ���
SELECT *
FROM dept
WHERE deptno = 99;
