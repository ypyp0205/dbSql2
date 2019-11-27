--��¥���� �Լ�
--ROUND, TRUNC
--(MONTHS_BETWEEN) ADD_MONTHS, NEXT_DAY
--LAST_DAY : �ش� ��¥�� ���� ���� ������ ����(DATE)

--�� :1, 3, 5, 7, 8, 10, 12 : 31��
-- : 2 -���� ���� 28, 29
-- : 4, 6, 9, 11 : 30��




SELECT SYSDATE, LAST_DAY (SYSDATE)
FROM dual;

-- '201912' --> date Ÿ������ �����ϱ�
--�ش� ��¥�� ������ ��¥�� �̵�
--���� �ʵ常 �����ϱ�
--DATE --> �����÷� (DD)�� ����
--DATE --> ���ڿ�(DD)
--TO_CHAR(DATE, '����')
--DATE : LAST_DAY(TO_DATE('201912', 'yyyymm'))
--���� : 'DD'

SELECT :yyyymm param,
        TO_CHAR(LAST_DATE(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')dt  
FROM dual;

--SYSDATE�� YYYY/MM/DD ������ ���ڿ��� ���� (DATE -> CHAR)
--'2019/11/26' ���ڿ� --> DATE
SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYY/MM/DD' ), 'YYYY/MM/DD')
FROM dual;
--YYYY-MM-DD HH24:MI:SS ���ڿ��� ����
SELECT TO_CHAR(TO_DATE(TO_CHAR(SYSDATE, 'YYYY/MM/DD' ), 'YYYY/MM/DD'), 'YYYY-MM-DD HH24:MI:SS')
FROM dual;


--EMPNO    NOT NULL NUMBER(4)
--HIREDATE          DATE    
DESC emp;

--empno�� 7369�� ���� ���� ��ȸ �ϱ�
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';  ----------�ܿ��� ���� ���δٰ��Ѵ�.



SELECT *
FROM TABLE(dbms_xplan.display);


Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     2 |    74 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     2 |    74 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';  ----------�ܿ��� ���� ���δٰ��Ѵ�.



SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     2 |    74 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     2 |    74 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_CHAR("EMPNO")='7369')
   
SELECT 7300 + '69'
FROM dual;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = 7300 + '69';  ----------�ܿ��� ���� ���δٰ��Ѵ�.



SELECT *
FROM TABLE(dbms_xplan.display);


Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     2 |    74 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     2 |    74 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_NUMBER(TO_CHAR("EMPNO"))=7369)



--
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


--DATEŸ���� ������ ����ȯ�� �����  ������ ����
--YY -> 19
--RR --> 50 / 19, 20
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('81/06/01', 'RR/MM/DD');   ---------���Ҷ� �̰� ���� ������
--WHERE hiredate >= 81/06/01';

SELECT TO_DATE('50/05/05', 'RR/MM/DD'),
       TO_DATE('49/05/05', 'RR/MM/DD'),
       TO_DATE('50/05/05', 'YY/MM/DD'),
       TO_DATE('49/05/05', 'YY/MM/DD')
FROM dual;        


--���� --> ���ڿ�
--���ڿ� --> ����
--���� : 1000000  --> 1,000,000.00 (�ѱ�)
--���� : 1000000  --> 1.000.000,00 (����)
--��¥ ���� : YYYY, MM, DD, HH24, MI, SS
--���� ���� : ���� ǥ�� : 9, �ڸ������� ���� 0ǥ�� : 0, ȭ����� : L 1000�ڸ� ����:, �Ҽ��� : .
--���� -> ���ڿ� TO_CHAR(����, '����')
--���� ������ �������� ���� �ڸ����� ����� ǥ��
SELECT empno, ename, sal, TO_CHAR(sal, 'L009,999') fm_sal
FROM emp;


SELECT TO_CHAR(100000000000, '999,999,999,999,999')
FROM dual;

--NULL ó�� �Լ� : NVL, NVL2, NULLIF, COALESCE

--NVL(expr1, expr2,) : �Լ� ���� �ΰ�
--expr1�� NULL�̸� expr2�� ��ȯ
--expr1�� NULL�� �ƴϸ� expr1�� ��ȯ
SELECT empno, ename, comm, NVL(comm, -1) nvl_comm 
FROM emp;

--NVL2(expr1, expr2, expr3)
--expr1 IS NOT NULL expr2����
--expr1 IS NULL expr3����
SELECT empno, ename, comm, NVL2(comm, 1000, -500) nvl_comm ,
       NVL2(comm, comm, -500) nvl_comm --NVL�� ������ ���     
FROM emp;

--NULLIF(expr1, expr2)
--expr1 = expr2 NULL�� ����
--expr1 != expr2 expr1�� ����
--comm�� NULL�ϋ� comm + 500 : NULL
--NULLIF(NULL, NULL) : NULL
--comm�� NULL�� �ƴҶ� comm + 500 : comm + 500
--NULLIF(comm, comm + 500) : comm

SELECT empno, ename, comm, NULLIF(comm, comm + 500) nullif_comm
       
FROM emp;


--COALESCE(expr1, expr2, expr3 ......)
--�����߿� ù��°�� �����ϴ� NULL�� �ƴ� exprN�� ����
--expr1 IS NOT NULL expr1�� �����ϰ�
--expr1 IS NULL COALESCE(expr2,expr3........)

SELECT empno, ename, comm, sal, COALESCE(comm, sal) coal_sal
FROM emp;


SELECT empno, ename, mgr,  
NVL(mgr, 9999) MGR_N, 
NVL2(mgr, mgr, 9999) MGR_N_2,
COALESCE(mgr, 9999) MGR_N_3 
FROM emp;


SELECT userid, usernm,
TO_CHAR(SYSDATE, 'YY/MM/DD' ) REG_DT,
TO_CHAR(SYSDATE, 'YY/MM/DD' ) N_REG_DT     ------�����ϴٸ���
--REG_DT, 
--N_REG_DT
FROM users;


SELECT userid, usernm, reg_dt,
      NVL(reg_dt, sysdate) nvl_reg_dt,
      COALESCE(reg_dt, sysdate) n_reg_dt
FROM users
WHERE userid NOT IN ('brown');

--condition
--case
--emp.job �÷��� ��������
--'SALESMAN'�̸� sal * 1.05�� ������ �� ����
--'MANAGER'�̸� sal * 1.10�� ������ �� ����
--'PRESIDENT'�̸� sal * 1.20�� ������ �� ����
--�� 3���� ������ �ƴ� ��� sal ����
--empno, ename, sal, ���� ������ �޿� AS bouns
SELECT empno, ename, job, sal, 
       CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal
       END bonus
       
FROM emp;

--NULLó�� �Լ� ������� �ʰ� CASE ���� �̿��Ͽ�
       --comm�� NULL�� ��� -10�� �����ϵ��� ����
SELECT empno, ename, job, sal, 
       CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal
       END bonus,
       comm,
      CASE
            WHEN comm IS NULL THEN -10                  --Ʋ��
            else case_null
       
FROM emp;


--DECODE
SELECT empno, ename, job, sal,
       DECODE(job, 'SALESMAN', sal * 1.05,
                   'MANGER',   sal * 1.10,
                   'PRESIDENT',sal * 1.20,
                               sal) bonus    
FROM emp;                               



SELECT empno, ename,
       DECODE(deptno, '10', 'ACCOUNTING',
                      '20', 'RESEARCH',
                      '30', 'SALES',
                      '40', 'OPERATIONS',
                                   'DDIT') DNAME
                    
FROM emp;


SELECT EMPNO, ENAME,
        CASE
            WHEN deptno = 10 THEN 'ACCOUNTING'
            WHEN deptno = 20 THEN 'RESEARCH'
            WHEN deptno = 30 THEN 'SALES'
            WHEN deptno = 40 THEN 'OPERATIONS'
            ELSE 'DDIT'
            END dname
FROM emp;


SELECT empno, ename, hiredate,
           CASE WHEN MOD(TO_NUMBER(TO_CHAR(hiredate, 'yy')), 2) = 1 THEN '�ǰ����� �����'
                     -- MOD(TO_CHAR(SYSDATE, 'YY'),2
           ELSE '�ǰ����� ������'
           END CONTACT_TO_DOCTOR
FROM emp;


SELECT empno, ename, hiredate,
           CASE 
           WHEN      MOD(TO_CHAR(hiredate, 'YY'), 2) = 
                     MOD(TO_CHAR(SYSDATE, 'YY'),2) 
           THEN '�ǰ����� �����'    
           ELSE '�ǰ����� ������'
           END CONTACT_TO_DOCTOR
FROM emp; 




SELECT empno, ename, hiredate,
           CASE 
           WHEN      MOD(TO_CHAR(hiredate, 'YYYY'), 2) = 
                     MOD(TO_CHAR(SYSDATE, 'YYYY'),2) 
           THEN '�ǰ����� �����'    
           ELSE '�ǰ����� ������'
           END CONTACT_TO_DOCTOR
FROM emp; 

SELECT empno, ename, hiredate,
           CASE 
           WHEN      MOD(TO_CHAR(hiredate, 'YYYY'), 2) = 
                     MOD ('2020',2 )
           THEN '�ǰ����� �����'    
           ELSE '�ǰ����� ������'
           END CONTACT_TO_DOCTOR
FROM emp; 

--coud3����
SELECT userid, usernm, alias, reg_dt,
        CASE 
        WHEN    MOD(TO_CHAR(reg_dt, 'YYYY'),2) =
                MOD(TO_CHAR(SYSDATE, 'YYYY'),2)
                THEN '�ǰ����� �����'
                ELSE '�ǰ����� ������'
                END CONTACT_TO_DOCTOR
        
FROM users;

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
                            
                            
                            