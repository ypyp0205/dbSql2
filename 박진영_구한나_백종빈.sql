--실습3
--시스템에서 사용하는 쿼리가 다음과 같다고 할 때 적절한 emp 테이블에 필요하다고 생각되는 인덱스를 생성 스크립트를 만들어 보세요.

--dept(deptno)인덱스 생성
CREATE INDEX idx_n_dept_01 ON dept (deptno);

SELECT deptno, rowid
FROM dept
ORDER BY deptno;

--emp(deptno)인덱스 생성

CREATE INDEX idx_n_emp_01 ON emp (deptno);

SELECT deptno, rowid
FROM emp
ORDER BY deptno;

--emp(empno)인덱스 생성
CREATE INDEX idx_n_emp_02 ON emp (empno);

SELECT empno, rowid
FROM emp
ORDER BY empno;
