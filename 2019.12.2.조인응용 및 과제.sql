--ouyter join : 조인 연결에 실패 하더라도 기준이 되는 테이블의 데이터는 나오도록 하는 join
--LEFT OUTER JOIN : 테이블1 LEFT OUTER JOIN 테이블2
--테이블1과 테이블2를 조인할떄 조인에 실패하더라도 테이블 1쪽의 데이터는 조회가 되도록한다.
--조인에 실패한 행에서 테이블2의 컬럼값은 존재하지 않으므로 NULL로 표시 된다.

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
--일반조인과 차이점은 컬럼명에 (+)표시
--(+)표시 : 데이터가 존재하지 않는데 나와야 하는 테이블의 컬럼
--직원 LEFT OUTER JOIN 매니저
--      ON(지구언.매니저번호 = 매니저.직원번호)
--ORACLE OUTER
--WHERE 직원.매니저번호 = 직원번호(+) --매니저쪽 데이터가 존재하지 않음

--ANSI
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m
            ON(e.mgr = m.empno);

-- ORACLE OUTER
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

--매니저 부서번호 제한
--ANSI SQL ON 절에 기술한 형태
-- --> OUTER 조인이 적용되지 않은 상황
--**아우터 조인이 적용되어야 테이블의 모든 컬럼에 (+)가 붙어야 된다.***********
SELECT e.empno, e.ename, m.empno, m.ename,m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;
            
--ansi sql의 on절에 기술한 경우와 동일            
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;
            
            
--emp 테이블에는 14명의 직원이 있고 14명은 10, 20, 30부서중에 한 부서에 속한다.
--하지만 dept 테이블에는 10, 20, 30, 40번 부서가 존재

--부서번호, 부서명, 해당부서에 속한 직원수가 나오도록 쿼리를 작성

--10	ACCOUNTING  3
--20	RESEARCH    5
--30	SALES       6
--40	OPERATIONS  0

--dept : deptno, dname
--inline : deptno, cnt (직원의 수)
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

--FULL OUTER : LEFT OUTER + RIGHT OUTER - 중복데이터 중에서 한건만 남긴다.
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m
            ON(e.mgr = m.empno);
            
--실습 1
SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b, prod p
WHERE p.prod_id = b.buy_prod
AND b.BUY_DATE(+) = TO_DATE('2005/01/25');
  
SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p
     ON (p.prod_id = b.buy_prod)
     AND BUY_DATE = TO_DATE('050125', 'yymmdd');

--실습 2
SELECT ('05/01/25')buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b  RIGHT OUTER JOIN prod p
     ON (p.prod_id = b.buy_prod)
     AND BUY_DATE = '2005/01/25';
     
--실습 3
SELECT ('05/01/25')buy_date, b.buy_prod, p.prod_id, p.prod_name, NVL(b.buy_qty,0) buy_qty
FROM buyprod b  RIGHT OUTER JOIN prod p
     ON (p.prod_id = b.buy_prod)
     AND BUY_DATE = '2005/01/25';     

--실습 4
SELECT p.pid pid, p.pnm, NVL(c.cid,1) cid, NVL(c.day,0) day, NVL(c.cnt,0) cnt
FROM cycle c  RIGHT OUTER JOIN product p 
     ON (c.pid = p.pid)
     AND c.cid = '1';

--실습 5
SELECT NVL(p.pid, 300) pid, p.pnm, NVL(c.cid,1) cid, NVL(cnm,'brown') cnm, NVL(c.day,0) day, NVL(c.cnt,0) cnt
FROM cycle c, product p, customer
WHERE c.pid(+) = p.pid
AND customer.cid(+) = c.cid
AND c.cid(+) = '1'
ORDER BY pid;









            