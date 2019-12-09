SELECT deptno
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = (SELECT deptno                  ------����Ŀ������Ѵ�.
                FROM emp
                WHERE ename = 'SMITH');
   

SELECT empno, ename, deptno, 
       (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname
FROM emp;

--SCALAR SUBQUERY
--SELECT ���� ǥ���� ���� ����
--�� ��, �� COLUMN�� ��ȸ�ؾ� �Ѵ�.
SELECT empno, ename, deptno, 
       (SELECT dname FROM dept ) dname
FROM emp;

--INLINE VIEW
--FROM���� ���Ǵ� ���� ����

--SUBQUERY
--WHERE�� ���Ǵ� ��������


SELECT sum(sal)
FROM emp;

--�ǽ�1
SELECT COUNT(*) cnt
FROM emp
WHERE sal > (SELECT AVG(SAL)
            FROM emp);
--�ǽ�2
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp
WHERE sal > (SELECT AVG(SAL)
            FROM emp);

--�ǽ�3

SELECT *
FROM emp;

SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno 
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));

--SMITH Ȥ�� WARD ���� �޿��� ���� �޴� ������ȸ
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp
WHERE sal < ANY(SELECT sal     --800, 1250
                FROM emp    
                WHERE ename IN ('SMITH', 'WARD'));


SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp
WHERE sal <= ALL(SELECT sal     --800, 1250
                FROM emp    
                WHERE ename IN ('SMITH', 'WARD'));
                
                
--������ ������ ���� �ʴ� ��� ���� ��ȸ
--NOT IN ������ ���� NULL�� �����Ϳ� �������� �ʾƾ� ������ �Ѵ�.
SELECT *
FROM emp  --��� ���� ��ȸ --> �����ڿ����� ���� �ʴ�
WHERE empno NOT IN
            (SELECT  NVL(mgr, -1)
            FROM emp);

SELECT *
FROM emp  --��� ���� ��ȸ --> �����ڿ����� ���� �ʴ�
WHERE empno NOT IN
            (SELECT  mgr
            FROM emp
            WHERE mgr IS NOT NULL);

--pair wise (�����÷��� ���� ���ÿ� ���� �ؾ��ϴ� ���)
--ALLEN CLARK�� �Ŵ����� �μ���ȣ�� ���ÿ� ���� ��� ���� ��ȸ
--(7698, 30)
--(7839,10)

SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));

--�Ŵ����� 7698�̰ų� 7839 �̸鼭
--�ҼӺμ��� 10�� �̰ų� 30���� ������ ���� ��ȸ
--7698, 10
--7698, 30
--7639, 10
--7639, 30
SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
              FROM emp
              WHERE empno IN (7499, 7782))
AND deptno IN (SELECT deptno
               FROM emp
               WHERE empno IN (7499, 7782));
          
--���ȣ ���� ���� ����
--���������� �÷��� ������������ ������� �ʴ� ������ ���� ����



--���ȣ ���� ���������� ��� ������������ ����ϴ� ���̺�, �������� ��ȸ ������ ���������� ������ ������ �Ǵ��Ͽ� ������ �����Ѵ�.
--���������� emp���̺��� ���� ���� ���� �ְ�, ���������� emp ���̺��� ���� ���� ���� �ִ�.

--���ȣ ���� ������������ �������� �� ���̺��� ���� ���� ���� 
--���������� ������ ������ �ߴ� ��� �� �������� ǥ��
--���ȣ ���� ������������ �������� �� ���̺��� ���߿� ���� ���� 
--���������� Ȯ���� ������ �ߴ� ��� �� �������� ǥ��

--������ �޿� ��պ��� ���� �޿��� �޴� ���� ���� ��ȸ
--������ �޿� ���
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

--��ȣ���� ��������
--�ش������� ���� �μ��� �޿���պ��� ���� �޿��� �޴� ���� ��ȸ

SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal)
             FROM emp
             WHERE deptno = m.deptno);



--10�� �μ��� �޿����
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno;







































