--�ǽ�3
--�ý��ۿ��� ����ϴ� ������ ������ ���ٰ� �� �� ������ emp ���̺� �ʿ��ϴٰ� �����Ǵ� �ε����� ���� ��ũ��Ʈ�� ����� ������.

--dept(deptno)�ε��� ����
CREATE INDEX idx_n_dept_01 ON dept (deptno);

SELECT deptno, rowid
FROM dept
ORDER BY deptno;

--emp(deptno)�ε��� ����

CREATE INDEX idx_n_emp_01 ON emp (deptno);

SELECT deptno, rowid
FROM emp
ORDER BY deptno;

--emp(empno)�ε��� ����
CREATE INDEX idx_n_emp_02 ON emp (empno);

SELECT empno, rowid
FROM emp
ORDER BY empno;
