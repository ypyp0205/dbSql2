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
SELECT a.empno, a.ename, a.sal, a.sum(sal) c_sum
FROM
(SELECT empno, ename, sal, ROWNUM rn
FROM
(SELECT empno, ename, sal 
FROM emp
ORDER BY sal)) a,

(SELECT empno, ename, sal, ROWNUM rn
FROM
(SELECT empno, ename, sal 
FROM emp
ORDER BY sal)) b

WHERE a.empno = b.empno
AND a.ename = b.ename
AND a.sal = b.sal

GROUP BY empno, ename;

--empno,ename,sal �������
--a.rn >= b.rn;




SELECT empno, ename, sal, ROWNUM rn
FROM
(SELECT empno, ename, sal 
FROM emp
ORDER BY sal);









