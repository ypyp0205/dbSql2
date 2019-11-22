UPDATE emp 

SET comm = 0

WHERE empno = 7844;

 

--emp ���̺����μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ��ȸ �ϼ��� ( IN, NOT IN ������ ������)

SELECT *

FROM emp

WHERE DEPTNO != '10' -- <> �� ����

AND hiredate >= TO_DATE('19810601', 'yyyymmdd');

 

--emp ���̺����μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ��ȸ �ϼ��� ( NOT IN ������ ���)

SELECT *

FROM emp

WHERE DEPTNO NOT IN (10)

AND hiredate >= TO_DATE('19810601', 'yyyymmdd');

 

--emp ���̺����μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ��ȸ �ϼ��� ( 10, 20, 30���� �ִٰ� �����ϰ� IN������ ���)

SELECT *

FROM emp

WHERE deptno IN (20, 30)

AND hiredate >= TO_DATE ('19810601', 'yyyymmdd');

 

--emp ���̺��� job�� SALESMAN�̰ų� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ��ȸ�ϼ���

SELECT *

FROM emp

WHERE job = 'SALESMAN'

OR hiredate >= TO_DATE ('19810601', 'yyyymmdd');

 

--emp ���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϴ� ������ ������ ��ȸ�ϼ���

SELECT *

FROM emp

WHERE job = 'SALESMAN' -- SALESMAN�� ' '�� �Ⱥ��̸� �÷����� �ν��Ѵ�.

OR empno LIKE '78%'; -- LIKE �� ���ڿ��� ���� ���ϰ˻��̶� ' '�� �����

 

--emp ���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϴ� ������ ������ ��ȸ�ϼ��� ( LIKE ������ ��� ���� )

--�������� : empno�� ���ڿ��ߵȴ� ( DESC emp. empno NUMBER )

DESC emp;

SELECT *

FROM emp

WHERE job = 'SALESMAN'

OR empno BETWEEN 7800 AND 7899;

 

--������ �켱���� ( AND > OR )

-- ���� �̸��� SMITH �̰ų� ALLEN �̸鼭 job�� SALESMAN�� ����

SELECT *

FROM emp

WHERE ename = 'SMITH'

OR (ename = 'ALLEN' AND job = 'SALESMAN');

 

-- ���� �̸��� SMITH �̰ų� ALLEN �̸鼭 job�� SALESMAN�� ����

SELECT *

FROM emp

WHERE (ename = 'SMITH' OR ename = 'ALLEN')

AND job = 'SALESMAN';

 

--emp ���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϸ鼭 �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ��ȸ�ϼ���

SELECT *

FROM emp

WHERE job = 'SALESMAN'

OR (empno LIKE '78%' AND hiredate >= TO_DATE('19810601', 'yyyymmdd'));

 

SELECT *

FROM emp

WHERE job = 'SALESMAN'

OR (empno BETWEEN 7800 AND 7899

    AND hiredate >= TO_DATE ('19810601', 'yyyymmdd') );

    

SELECT *

FROM emp

WHERE (job = 'SALESMAN'

OR empno BETWEEN 7800 AND 7899)

AND hiredate >= TO_DATE ('19810601', 'yyyymmdd');

 

--ORDER BY

-- ASC : �������� (�⺻) -> 10 5 3 2 1  = 1 2 3 5 10 ���������� �ö󰣴ٴ� ��

-- DESC : �������� -> 10 5 3 2 1 ������ ū���������� �������ٴ� ��

-- ASC�� ǥ�⸦ ���Ұ�� �⺻��

-- DESC�� ���������� �ݵ�� ǥ��

 

/*

    SELECT col1, col2, ....

    FROM ���̺��

    WHERE coll = '��'

    ORDER BY ���ı����÷�1 [ASC / DESC], ���ı����÷�2.....[ASC / DESC]

*/

 

--emp ���̺��� ������ ������ ���� �̸�(ename) ���� �������� ����

SELECT *

FROM emp

ORDER BY ename ASC; -- <- (ASC ���� ����) ���ı����� �ۼ����� ������� �������� ����

 

--emp ���̺��� ������ ������ ���� �̸�(ename) ���� �������� ����

SELECT *

FROM emp

ORDER BY ename DESC; -- DESC : ���������� ���� Ű���� (�������� �Ҷ� �ݵ�� �������)

 

--emp ���̺��� ������ ������ �μ���ȣ�� ��������(ASC) �����ϰ�

-- �μ���ȣ�� ���� ���� sal(DESC) �������� ����

-- �޿�(sal)�� �������� �̸����� ��������(ASC) ���� �Ѵ�.

SELECT *

FROM emp

ORDER BY deptno, sal DESC, ename;

 

--���� �÷��� ALIAS�� ǥ��

SELECT deptno, sal, ename nm

FROM emp

ORDER BY nm;

 

--��ȸ�ϴ� �÷��� ��ġ �ε����� ǥ�� ����, ��õ��������.( �÷� �߰��� �ǵ����� ���� ����� ���ü� ����)

SELECT deptno, sal, ename nm

FROM emp

ORDER BY 3; -- 3�� nm�� ����. 2�� sal 

 

--dept ���̺��� ��� ������ �μ��̸����� �������� ���ķ� ��ȸ�ǵ��� ������ �ۼ��ϼ���

SELECT *

FROM dept

ORDER BY dname;

 

--ORDERBY 1

--dept ���̺��� ��� ������ �μ���ġ�� �������� ���ķ� ��ȸ�ǵ��� ������ �ۼ��ϼ���

SELECT *

FROM dept

ORDER BY loc DESC;

 

--ORDERBY 2

-- emp ���̺��� �� ������ �ִ� ����鸸 ��ȸ�ϰ�, �󿩸� ���� �޴� ����� ���� ��ȸ�ǵ��� �ϰ�, 

-- �󿩰� ���� ��� ������� �������� �����϶�. (�󿩰� 0�� ����� �󿩰� ���� ������ ����)

SELECT *

FROM emp

WHERE comm IS NOT NULL

AND comm != 0

ORDER BY comm DESC, empno;

 

--ORDERBY 3

--emp ���̺��� �����ڰ� �ִ� ������ ��ȸ�ϰ� ���� ������ �������� ����(ASC), 

--������ ������� �����ȣ�� ū����� ���� ��ȸ�ǵ��� (DESC)

SELECT *

FROM emp

WHERE mgr IS NOT NULL

ORDER BY job, empno DESC;

 

--ORDERBY 4

--emp ���̺��� 10�� �μ�(deptno) Ȥ�� 30�� �μ��� ���ϴ� ����� �޿�(sal)�� 1500�� �Ѵ� ����鸸 ��ȸ�ϰ� 

--�̸����� �������� ���ĵǵ��� ������ �ۼ��ϼ���

SELECT *

FROM emp

WHERE deptno IN (10, 30) -- deptno = 10 OR deptno = 30 �� ����

AND sal > 1500

ORDER BY ename DESC;

 

--ROWNUM : �÷��� ���������� ��ȣ�� �ο���

SELECT ROWNUM, empno, ename

FROM emp;

 

SELECT ROWNUM, empno, ename

FROM emp

WHERE ROWNUM = 1; -- ROWNUM = equal �񱳴� 1�� ����

 

SELECT ROWNUM, empno, ename

FROM emp

WHERE ROWNUM <= 2; -- <=, (<) �ε�ȣ ROWNUM�� 1���� ���������� �ε�ȣ�� ����ؼ� ��ȸ�ϴ� ���� ����

 

SELECT ROWNUM, empno, ename

FROM emp

WHERE ROWNUM BETWEEN 1 AND 20; -- 1���� �����ϴ� ��� ���� 2�� �ƹ��͵� �ȳ���

 

--SELECT ���� ORDER BY ������ �������

--SELECT -> ROWNUM -> ORDER BY 

SELECT ROWNUM, empno, ename

FROM emp

ORDER BY ename;

 

--INLINE VIEW(���� ����� �Ѱ�)�� ���� ������ ���� �����ϰ�, �ش� ����� ROWNUM�� ����

-- *�� ǥ���ϰ�, �ٸ� �÷� ǥ������ ���� ��� *�տ� ���̺���̳�, ���̺� ��Ī�� �����ؾ���.

SELECT ROWNUM, a.*        -- empno, ename

FROM (SELECT empno, ename 

      FROM emp

      ORDER BY ename) a;

      

SELECT emp.*

FROM emp;

 

SELECT ROWNUM, a.*

FROM (SELECT empno, ename, deptno

     FROM emp

     ORDER BY deptno) a;

     

--ROWNUM 1

--emp ���̺��� ROWNUM ���� 1~10�� ���� ��ȸ�ϴ� ������ �ۼ��ϼ���

SELECT ROWNUM rn, empno, ename

FROM emp

WHERE ROWNUM BETWEEN 1 AND 10;

 

--ROWNUM 2

-- ROWNUM�� 11~14�� ������

SELECT ROWNUM rn, e.*

FROM (SELECT empno, ename

     FROM emp                       -- �����Ѱ�. Ʋ��

     WHERE ROWNUM BETWEEN 1 AND 20)

WHERE rn BETWEEN 11 AND 14 e;

 

SELECT a.*

FROM

    (SELECT ROWNUM rn, empno, ename     -- ����

    FROM emp) a

WHERE rn BETWEEN 11 AND 20;

 

--ROWNUM 3

--emp ���̺��� ename���� ������ ����� 11~14��° �ุ ��ȸ�ϴ� ���� �ۼ� 

--(empno, ename �÷��� ���ȣ�� ��ȸ)



SELECT *

FROM
( SELECT ROWNUM RN,  a.*
FROM 
          (  SELECT ename, empno
             FROM emp
             ORDER BY ename  )a )

             WHERE RN BETWEEN 11 AND 14 ;





SELECT *
FROM emp;





