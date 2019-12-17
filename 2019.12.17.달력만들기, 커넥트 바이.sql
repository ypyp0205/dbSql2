--with
--with ����̸� AS (
--  ��������
--)
--SELECT *
--FROM ����̸�

--deptno, avg(sal) avg_sal
--�ش� �μ��� �޿� ����� ��ü ������ �޿� ��պ��� ���� �μ��� ���� ��ȸ
SELECT deptno, ROUND(avg(sal),2) avg_sal
FROM emp
GROUP BY deptno
HAVING AVG(sal) > (SELECT AVG(sal) FROM emp);

--WITH ���� ����Ͽ� ���� ������ �ۼ�
WITH dept_sal_avg AS
                (SELECT deptno, ROUND(avg(sal),2) avg_sal
                    FROM emp
                    GROUP BY deptno),
                emp_sal_avg AS
                    (SELECT AVG(sal) avg_sal 
                     FROM emp)
                       
SELECT *
FROM dept_sal_avg
WHERE avg_sal > (SELECT avg_sal FROM emp_sal_avg);                                              
                                                                    
WITH test AS(
    SELECT 1 ,'TEST' FROM DUAL UNION ALL
    SELECT 2 ,'TEST2' FROM DUAL UNION ALL
    SELECT 3 ,'TEST3' FROM DUAL)
SELECT *
FROM test;


--��������                                                                    
--�޷¸����
--CONNECT BY LEVEL <= N
--���̺��� ROW �Ǽ��� N��ŭ �ݺ��Ѵ�.
--CONNECT BY LEVEL ���� ����� ����������
--SELECT ������ LEVEL �̶�� Ư�� �÷��� ����� �� �ִ�.
--������ ǥ���ϴ� Ư�� �÷����� 1���� �����ϸ� ROWNUM�� �����ϳ�
--���� ���Ե� START WITH, CONNECT BY ������ �ٸ����� ���� �ȴ�.

--2019�� 11���� 30�ϱ��� ����
--201911
--���� + ���� = ������ŭ �̷��� ����
--201911 --> �ش����� ��¥�� ���� ���� ���� �ϴ°�??
SELECT TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 30;                                                                    
                   
                   
--201911 --> 30
--201912 --> 31
--202402 --> 29
--201902 --> 28
--1-��, 2-��, ......7-��
--�״��� ������ ��¥, ����, 
SELECT /*�Ͽ����̸� ��¥, ȭ�����̸� ��¥, ....������̸� ��¥*/
       /* dt, d,*/ dt - (d - 1),
        MAX(DECODE(d, 1, dt)) �Ͽ���, MAX(DECODE(d, 2, dt)) ������, MAX(DECODE(d, 3, dt)) ȭ����,
        MAX(DECODE(d, 4, dt)) ������, MAX(DECODE(d, 5, dt)) �����, MAX(DECODE(d, 6, dt)) �ݿ���,
        MAX(DECODE(d, 7, dt)) �����
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1) dt,                     --���� 20191130
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1), 'D') d,        --����
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL), 'IW') iw         --���� 20191201
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')) --30                                                                    
GROUP BY dt - (d - 1)
ORDER BY dt - (d - 1);

--12�� �����ذ�
SELECT /*�Ͽ����̸� ��¥, ȭ�����̸� ��¥, ....������̸� ��¥*/
       /* dt, d,*/ iw ����,
        MAX(DECODE(d, 1, dt)) �Ͽ���, MAX(DECODE(d, 2, dt)) ������, MAX(DECODE(d, 3, dt)) ȭ����,
        MAX(DECODE(d, 4, dt)) ������, MAX(DECODE(d, 5, dt)) �����, MAX(DECODE(d, 6, dt)) �ݿ���,
        MAX(DECODE(d, 7, dt)) �����
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1) dt,                     --���� 20191130
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1), 'D') d,        --����
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL), 'IW') iw         --���� 20191201
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')) --30                                                                    
GROUP BY iw
ORDER BY �����;                                   
          
--�ǽ�1
SELECT /*1�� �÷�, 2�� �÷�,*/
    NVL(MIN(DECODE(mm, '01', sales_sum)), 0) JAN, NVL(MIN(DECODE(mm, '02', sales_sum)), 0) FEB, 
    NVL(MIN(DECODE(mm, '03', sales_sum)), 0) MAR, NVL(MIN(DECODE(mm, '04', sales_sum)), 0) APR, 
    NVL(MIN(DECODE(mm, '05', sales_sum)), 0) MAY, NVL(MIN(DECODE(mm, '06', sales_sum)), 0) JUN
FROM          
(SELECT TO_CHAR(DT, 'MM') mm, SUM(sales) sales_sum
FROM sales
GROUP BY TO_CHAR(dt, 'MM'));
                                                                    



SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd = 'dept0'   --�������� depted = 'dept0' --> XXȸ��(�ֻ�������)
CONNECT BY PRIOR deptcd = p_deptcd;
    
    
    
/*
    dept0(XXȸ��)
        dept0_00(�����κ�)
            dept0_00_0(��������)
        dept0_01(������ȹ��)
            dept0_01_0(��ȹ��)
                dept0_00_0_0(��ȹ��Ʈ)
        dept0_02(�����ý��ۺ�)        
            dept0_02_0(����1��)
            dept0_02_1(����2��)    