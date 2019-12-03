--ouyter join : ���� ���ῡ ���� �ϴ��� ������ �Ǵ� ���̺��� �����ʹ� �������� �ϴ� join
--LEFT OUTER JOIN : ���̺�1 LEFT OUTER JOIN ���̺�2
--���̺�1�� ���̺�2�� �����ҋ� ���ο� �����ϴ��� ���̺� 1���� �����ʹ� ��ȸ�� �ǵ����Ѵ�.
--���ο� ������ �࿡�� ���̺�2�� �÷����� �������� �����Ƿ� NULL�� ǥ�� �ȴ�.

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m
            ON(e.mgr = m.empno);
            
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m
            ON(e.mgr = m.empno);
--
SELECT e.empno, e.ename, m.empno, m.ename, m.deptno, e.deptno
FROM emp e LEFT OUTER JOIN emp m
            ON(e.mgr = m.empno AND m.deptno = 10);
           
SELECT e.empno, e.ename, m.empno, m.ename, m.deptno, e.deptno
FROM emp e LEFT OUTER JOIN emp m
            ON (e.mgr = m.empno)
WHERE m.deptno = 10;           

--ORACLE outer join syntax
--�Ϲ����ΰ� �������� �÷��� (+)ǥ��
--(+)ǥ�� : �����Ͱ� �������� �ʴµ� ���;� �ϴ� ���̺��� �÷�
--���� LEFT OUTER JOIN �Ŵ���
--      ON(������.�Ŵ�����ȣ = �Ŵ���.������ȣ)
--ORACLE OUTER
--WHERE ����.�Ŵ�����ȣ = ������ȣ(+) --�Ŵ����� �����Ͱ� �������� ����

--ANSI
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m
            ON(e.mgr = m.empno);

-- ORACLE OUTER
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

--�Ŵ��� �μ���ȣ ����
--ANSI SQL ON ���� ����� ����
-- --> OUTER ������ ������� ���� ��Ȳ
--**�ƿ��� ������ ����Ǿ�� ���̺��� ��� �÷��� (+)�� �پ�� �ȴ�.***********
SELECT e.empno, e.ename, m.empno, m.ename,m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;
            
--ansi sql�� on���� ����� ���� ����            
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;
            
            
--emp ���̺��� 14���� ������ �ְ� 14���� 10, 20, 30�μ��߿� �� �μ��� ���Ѵ�.
--������ dept ���̺��� 10, 20, 30, 40�� �μ��� ����

--�μ���ȣ, �μ���, �ش�μ��� ���� �������� �������� ������ �ۼ�

--10	ACCOUNTING  3
--20	RESEARCH    5
--30	SALES       6
--40	OPERATIONS  0

--dept : deptno, dname
--inline : deptno, cnt (������ ��)
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt
FROM 
dept,
(SELECT deptno, count(*) cnt
FROM emp
GROUP BY deptno)emp_cnt
WHERE dept.deptno = emp_cnt.deptno(+);

--ANSI
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt
FROM 
dept LEFT OUTER JOIN (SELECT deptno, count(*) cnt
                    FROM emp
                    GROUP BY deptno)emp_cnt
                    ON (dept.deptno = emp_cnt.deptno); 
            
SELECT dept.deptno, dept.dname, count(emp.deptno)
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno
GROUP BY dept.deptno, dept.dname;



SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m
            ON(e.mgr = m.empno);

--FULL OUTER : LEFT OUTER + RIGHT OUTER - �ߺ������� �߿��� �ѰǸ� �����.
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m
            ON(e.mgr = m.empno);
            
--�ǽ� 1
SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b, prod p
WHERE p.prod_id = b.buy_prod
AND b.BUY_DATE(+) = TO_DATE('2005/01/25');
  
SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p
     ON (p.prod_id = b.buy_prod)
     AND BUY_DATE = TO_DATE('050125', 'yymmdd');

--�ǽ� 2
SELECT ('05/01/25')buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b  RIGHT OUTER JOIN prod p
     ON (p.prod_id = b.buy_prod)
     AND BUY_DATE = '2005/01/25';
     
--�ǽ� 3
SELECT ('05/01/25')buy_date, b.buy_prod, p.prod_id, p.prod_name, NVL(b.buy_qty,0) buy_qty
FROM buyprod b  RIGHT OUTER JOIN prod p
     ON (p.prod_id = b.buy_prod)
     AND BUY_DATE = '2005/01/25';     

--�ǽ� 4
SELECT p.pid pid, p.pnm, NVL(c.cid,1) cid, NVL(c.day,0) day, NVL(c.cnt,0) cnt
FROM cycle c  RIGHT OUTER JOIN product p 
     ON (c.pid = p.pid)
     AND c.cid = '1';

--�ǽ� 5
SELECT NVL(p.pid, 300) pid, p.pnm, NVL(c.cid,1) cid, NVL(cnm,'brown') cnm, NVL(c.day,0) day, NVL(c.cnt,0) cnt
FROM cycle c, product p, customer
WHERE c.pid(+) = p.pid
AND customer.cid(+) = c.cid
AND c.cid(+) = '1'
ORDER BY pid;









            