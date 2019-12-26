--EXCEPTION
--�����߻� �� ���α׷��� �����Ű�� �ʰ� �ش� ���ܿ� ����
--�ٸ� ������ ���� ��ų �� �ְԲ� ó���Ѵ�

--���ܰ� �߻��ߴµ� ����ó���� ���� ��� : pl/sql����� ������ �Բ� ����ȴ�
--�������� SELECT����� �����ϴ� ��Ȳ���� ��Į�� ������ ���� �ִ� ��Ȳ

--EMP���̺��� ����̸� ��ȸ
SET SERVEROUTPUT ON;
DECLARE
    --��� �̸��� ������ �� �ִ� ����
    v_ename emp.ename%TYPE;
BEGIN
    --14���� select����� ������ SQL -> ��Į�� ������ ������ �Ұ��ϴ�(����)
    SELECT ename
    INTO v_ename
    FROM emp;
    
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('�������� SELECT����� ����');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('WHEN OTHERS');
        
END;
/

--����� ���� ����
--����Ŭ���� ������ ������ ���� �̿ܿ��� �����ڰ� �ش� ����Ʈ���� �����Ͻ� ��������
--������ ���ܸ� ����, ����� �� �ִ�
--�������, SELECT����� ���� ��Ȳ���� ����Ŭ������ NO_DATA_FOUND���ܸ� ������
--�ش� ���ܸ� ��� NO_EMP��� �����ڰ� ������ ���ܷ� �������ؿ� ���ܸ� ���� �� �ִ�


DECLARE
    --EMP���̺� ��ȸ ����� ������ ����� ����� ���� ����
    --���ܸ� EXCEPTION;
    no_emp EXCEPTION;
    v_ename emp.ename%TYPE;
BEGIN

    --NO_DATA_FOUND
    BEGIN
        SELECT ename
        INTO v_ename
        FROM emp
        WHERE empno = 7000;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE no_emp; --java throw new NoEmpExcetion()
    END;
EXCEPTION
    WHEN no_emp THEN
        DBMS_OUTPUT.PUT_LINE('NO_EMP');
END;
/


--����� �Է¹޾Ƽ� �ش� ������ �̸��� �����ϴ� �Լ�
--getEmpName(7369) -> SMITH

CREATE OR REPLACE FUNCTION getEmpName (p_empno emp.empno%TYPE)
RETURN VARCHAR2 IS
    --�����
    v_ename emp.ename%TYPE;

BEGIN
    SELECT ename
    INTO v_ename
    FROM emp
    WHERE empno = p_empno;
    
    return v_ename;
END;
/


SELECT getempname(7369)
FROM dual;


CREATE OR REPLACE FUNCTION getdeptname(p_deptno dept.deptno%TYPE)
RETURN INTEGER IS
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname
    INTO v_dname
    FROM dept
    WHERE deptno = p_deptno;
    
    return v_dname;
END;
/   

--cache : 20
--������ ������ :
--deptno (�ߺ� �߻�����) : �������� ���� ���ϴ�
--empno (�ߺ��� ����) : �������� ����.

--emp ���̺��� �����Ͱ� 100������ ���
--100���߿��� deptno�� ������ 4��(10~40)



SELECT getdeptname(deptno),  --4����
       getempname(empno)   --row ����ŭ �����Ͱ�����
FROM emp;                  

---------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION indent(p_lv NUMBER, p_dname VARCHAR2)
RETURN VARCHAR2 IS
    V_dname VARCHAR2(200);
BEGIN
    
--    SELECT LPAD(' ', (p_lv - 1 ) * 4, ' ') || p_dname
--    INTO v_dname
--    FROM dual;
--    
        v_dname := LPAD(' ', (p_lv - 1 ) * 4, ' ') || p_dname;
           
    return v_dname;
END;
/
---------------------------------------------------------------------------------------------------
SELECT deptcd, indent(LEVEL, deptnm) deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;











