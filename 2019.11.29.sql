--�ǽ� 3
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, emp.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.sal > 2500
AND emp.empno > 7600; 


SELECT emp.empno, emp.ename, emp.sal, emp.deptno, emp.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.sal > 2500
AND emp.empno > 7600
AND dept.dname = 'RESEARCH';

--�ǽ� join2
SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;
--�ǽ�3
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer, prod
WHERE buyer_id = prod_buyer;

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, prod, cart
WHERE member.mem_id = cart.cart_member
AND cart.cart_prod = prod.prod_id;

--�ǽ�4
SELECt customer.cid, cnm, pid, day, sum(cnt)
FROM customer, cycle
WHERE customer.cid = cycle.cid
AND customer.cnm IN ('brown', 'sally') 
GROUP BY customer.cid, cnm, pid, day;

--�ǽ�5
SELECt customer.cid, cnm, pid, product.pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid 
AND customer.cnm IN ('brown', 'sally');


--�ǽ�6
SELECt customer.cid, cnm, cycle.pid, pnm, sum(cnt)
FROM customer, cycle, product
WHERE cycle.pid = product.pid 
AND cycle.cid = customer.cid
GROUP BY customer.cid, cnm, cycle.pid, pnm;

--�ǽ�7
SELECt cycle.pid, sum(cnt)
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY cycle.pid;

--�ǽ�8






SELECT *
FROM customer;

SELECT *
FROM cycle;

SELECT *
FROM product;



SELECT *
FROM emp;


SELECT *
FROM dept;