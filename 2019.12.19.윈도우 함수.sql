--�ǽ� ana0
SELECT a.ename, a.sal, a.deptno, b.rn
FROM 
(SELECT ename, sal, deptno, ROWNUM j_rn
    FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC)) a,

(SELECT rn, ROWNUM j_rn
 FROM
    (SELECT b.*, a.rn
    FROM 
    (SELECT ROWNUM rn
     FROM dual
     CONNECT BY level <= (SELECT COUNT(*) FROM emp)) a,
    
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) b
     WHERE b.cnt >= a.rn
     ORDER BY b.deptno, a.rn )) b
 WHERE a.j_rn = b.j_rn;

--�ǽ� ana0�� �м��Լ���
SELECT ename, sal, deptno,
       RANK() OVER(PARTITION BY deptno ORDER BY sal ) rank,
       DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal ) dense_rank,
       ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal ) row_number  
FROM emp;    


--�ǽ� ana1
SELECT empno, ename, sal, deptno,
       RANK() OVER(ORDER BY sal DESC, empno) sal_rank,
       DENSE_RANK() OVER(ORDER BY sal DESC, empno) sal_dense_rank,
       ROW_NUMBER() OVER(ORDER BY sal DESC, empno) sal_row_number  
FROM emp;

--�ǽ� ana2
SELECT b.empno, b.ename, b.deptno, a.cnt
       
FROM emp b, (SELECT deptno, count(*) cnt
             FROM emp
             GROUP BY deptno) a
WHERE b.deptno = a.deptno
ORDER BY deptno;            

--�����ȣ, ����̸�, �μ���ȣ, �μ��� ������
SELECT empno, ename, deptno,
        COUNT(*) OVER(PARTITION BY deptno) cnt
FROM emp;

--�ǽ� ana2
SELECT empno, ename, sal, deptno,
       ROUND(avg(sal) OVER(PARTITION BY deptno), 2) avg
FROM emp
ORDER BY deptno;

--�ǽ� ana3
SELECT empno, ename, sal, deptno,
       MAX(sal) OVER(PARTITION BY deptno) MAX
FROM emp;


--�ǽ� ana4
SELECT empno, ename, sal, deptno,
       MIN(sal) OVER(PARTITION BY deptno) MAX
FROM emp;



--��ü����� ������� �޿������� �ڽź��� �Ѵܰ� ���� ����� �޿�
--(�޿��� ���� ���, �Ի����ڰ� ���� ����� ���� ����)


--�ǽ� ana5
SELECT empno, ename, hiredate, sal,
      LEAD(sal) OVER(ORDER BY sal DESC, hiredate) lead_sal
FROM emp
ORDER BY sal DESC;

--�ǽ� ana6
SELECT empno, ename, hiredate, job, sal,
      LAG(sal) OVER(PARTITION BY job ORDER BY sal DESC, hiredate) lead_sal
FROM emp;


--�ǽ� no_ana3
select e1.EMPNO,e1.ENAME,e1.SAL,e1.HIREDATE,sum(e2.sal)from(
          SELECT a.*,rownum rn
FROM(
    Select empno,ename,sal,hiredate FROM emp ORDER BY sal,hiredate)a
        )e1,
             (select b.*, rownum rn FROM(
             select empno,ename,sal from emp
             order by sal,HIREDATE)b)e2
WHERE e1.rn>=e2.rn
GROUP BY  e1.EMPNO,e1.ENAME,e1.SAL,e1.HIREDATE
;





