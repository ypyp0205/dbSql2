--GROUP FUNCTION
--Ư�� �÷��̳�, ǥ���� �������� �������� ���� ������ ����� ����
--count-�Ǽ�, sum0�հ�, avg-���, max-�ִ밪 ,min-�ּҰ�
--��ü ������ ������� (14���� -> 1��)
--���� ���� �޿�


--�μ���ȣ�� �׷��Լ� ����
SELECT deptno,
       MAX(sal) m_sal,              --�μ����� ���� ���� �޿� 
       MIN(sal) min_sal,            --�μ����� ���� ���� �޿�
       ROUND(AVG(sal),2) avg_sal,   --�μ� ������ �޿� ���
       SUM(sal) sum_sal,            --�μ� ������ �޿� �հ�
       COUNT(sal) count_sal,        --�μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr,        --�μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����.
       COUNT(*) count_row           --�μ��� ��������
FROM emp
GROUP BY deptno;


SELECT deptno,ename,
       MAX(sal) m_sal,              --�μ����� ���� ���� �޿� 
       MIN(sal) min_sal,            --�μ����� ���� ���� �޿�
       ROUND(AVG(sal),2) avg_sal,   --�μ� ������ �޿� ���
       SUM(sal) sum_sal,            --�μ� ������ �޿� �հ�
       COUNT(sal) count_sal,        --�μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr,        --�μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����.
       COUNT(*) count_row           --�μ��� ��������
FROM emp
GROUP BY deptno, ename;

--SELECT ������ GROUP BY ���� ǥ���� �÷� �̿��� �÷��� �� �� ����.
--�������� ������ ���� ���� (�������� ���� ������ �Ѱ��� �����ͷ� �׷���)
--�� ���������� ��������� SELECT ���� ǥ���� ����
SELECT deptno,
       MAX(sal) m_sal,              --�μ����� ���� ���� �޿� 
       MIN(sal) min_sal,            --�μ����� ���� ���� �޿�
       ROUND(AVG(sal),2) avg_sal,   --�μ� ������ �޿� ���
       SUM(sal) sum_sal,            --�μ� ������ �޿� �հ�
       COUNT(sal) count_sal,        --�μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr,        --�μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����.
       COUNT(*) count_row           --�μ��� ��������
FROM emp
GROUP BY deptno;

--�׷��Լ������� NULL �÷��� ��꿡�� ���ܵȴ�.
--emp���̺��� comm�÷��� null�� �ƴ� �����ʹ� 4���� ����, 9���� NUll)
SELECT COUNT(comm),   --NULL�� �ƴ� ���� ���� 4
       SUM(comm) sum_comm,
       SUM(sal) sum_sal,--NULL���� ����, 300 + 500 + 1400 + 0 = 2200
       SUM(sal + comm) tot_sal_sum,
       SUM(sal + NVL(comm, 0)) tot_sal_sum
FROM emp;

--WHERE ������ GROUP �Լ��� ǥ�� �� �� ����.
--�μ��� �ִ� �޿� ���ϱ�
--deptno, �ִ�޿�
SELECT deptno, MAX(sal) m_sal
FROM emp
WHERE MAX(sal) > 3000  --ORA-00934 WHERE ������ GROUP �Լ��� �� �� ����.
GROUP BY deptno;

SELECT deptno,  MAX(sal) m_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;

--1��
SELECT      MAX(sal) MAX_sal, 
            MIN(sal) MIN_sal,
            AVG(sal) AVG_sal,
            SUM(sal) SUM_sal,
            COUNT(sal) COUNT_sal,
            COUNT(mgr) COUNT_mgr,
            COUNT(*) COUNT_ALL
FROM emp
GROUP BY deptno;

--2��          
SELECT deptno, MAX(sal) MAX_sal, 
            MIN(sal) MIN_sal,
            AVG(sal) AVG_sal,
            SUM(sal) SUM_sal,
            COUNT(sal) COUNT_sal,
            COUNT(mgr) COUNT_mgr,
            COUNT(*) COUNT_ALL
FROM emp
GROUP BY deptno;

--3��
SELECT deptno, 
            MAX(sal) MAX_sal, 
            MIN(sal) MIN_sal,
            AVG(sal) AVG_sal,
            SUM(sal) SUM_sal,
            COUNT(sal) COUNT_sal,
            COUNT(mgr) COUNT_mgr,
            COUNT(*) COUNT_ALL
FROM emp
GROUP BY deptno;

--4��
--grp4
--hiredate �÷��� ���� yyyymm �������� �����
SELECT TO_CHAR(hiredate,'YYYYmm') hire_yyyymm, COUNT(*) cnt
       
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYmm');

--5��
SELECT TO_CHAR(hiredate, 'yyyy') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyy');

--6��

SELECT COUNT(deptno) cnt
FROM dept;

--��ü �μ��� ���ϱ� (dept)


--7��
SELECT COUNT(COUNT(deptno)) cnt
FROM emp
GROUP BY deptno;

SELECT COUNT(DISTINCT deptno)
FROM emp;


--join
--1. ���̺� �������� (�÷� �߰�)
--2. �߰��� �÷��� ���� update
--dename �÷��� emp ���̺� �߰�
DESC emp;
DESC dept;
--�÷��߰�(daname, VARCHAR(14))
ALTER TABLE emp ADD (dname VARCHAR2(14));
DESC emp;
SELECT *
FROM emp;

UPDATE emp SET dname = CASE
                            WHEN deptno = 10 THEN 'ACCOUNTING'
                            WHEN deptno = 20 THEN 'RESERCH'
                            WHEN deptno = 30 THEN 'SALES'
                            END;
COMMIT;

SELECT empno, ename, deptno, dname
FROM emp;
                            
--SALES--> MARKET SALES
--�� 6���� ������ ������ �ʿ��ϴ�.
--���� �ߺ��� �ִ� ���� (�� ������)
--UPDATE emp SET dname = 'MARKET SALES'
--WHERE dname = 'SALES';


--emp ���̺�, dept ���̺� ����
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;














                            