--ROWTYPE
--Ư�� ���̺��� ROW ������ ���� �� �ִ� ���� Ÿ��
--TYPE : ���̺��.���̺� �÷���%TYPE --> %COLTYPE
--ROWTYOE : ���̺��%ROWTYPE
SET SERVEROUTPUT ON;
DECLARE 
    --dept ���̺��� row ������ ���� �� �ִ� ROWTYPE ���� ����
    dept_row dept%ROWTYPE;
BEGIN
    SELECT *
    INTO dept_row
    FROM dept
    WHERE DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE(dept_row.dname || ', ' || dept_row.loc);
END;
/    



--public class Ŭ������{
--      �ʵ�type �ʵ�(�÷�);     //String name;
--      �ʵ�2type �ʵ�(�÷�)2;    //int age;
--}
  


--RECORD TYPE : �����ڰ� �÷��� ���� �����Ͽ� ���߿� �ʿ��� TYPE�� ����
--TYPE Ÿ���̸� IS RECORD
--         �÷�1 �÷�1TYPE,
--         �÷�2 �÷�2TYPE
--;

DECLARE
    -- �μ��̸�, LOC ������ ���� �� �� �ִ� RECORD TYPE ����
    TYPE dept_row IS RECORD(
        dname dept.dname%TYPE,
        loc dept.loc%TYPE);
        --type������ �Ϸ�, type�� ���� ������ ����
        --java : Class ������ �ش� class�� �ν��Ͻ��� ����(new)
        --plsql ���� ���� : �����̸� ����Ÿ�� dname dept.dname%TYPE;
        dept_row_data dept_row;
BEGIN
    SELECT dname, loc
    INTO dept_row_data
    FROM dept
    WHERE deptno = 10;
    DBMS_OUTPUT.put_line(dept_row_data.dname || ', ' || dept_row_data.loc);
END;
/
exec registdept_test(99, 'DDIT', 'DAEJEON');


--TABLE TYPE : �������� ROWTYPE�� ������ �� �ִ� TYPE
--col --> row --> table
--TYPE ���̺�Ÿ�Ը� IS TABLE OF ROWTYPE/RECORD INDEX BY �ε��� Ÿ�� (BINARY_INTEGER)
--java�� �ٸ��� plsql������ arrary ������ �ϴ� table type�� �ε�����
--���� �Ӹ� �ƴ϶�, ���ڿ� ���µ� �����ϴ�
--�׷��� ������ index�� ���� Ÿ���� ����Ѵ�.
--�Ϲ������� array(list) ������ ����� INDEX BY BINARY_INTEGER�� �ַ� ����Ѵ�.
--arr(1).name = 'brown'
--arr('person').name = 'brown'

--dept���̺��� row�� ������ ���� �� �� �ִ� dept_tab TABLE TYPE �����Ͽ�
--SELECT * FROM dept; �� ���(������)�� ������ ��´�.
DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;
BEGIN
    --�� row�� ���� ������ ���� : INTO
    --���� row�� ���� ������ ���� : BULK COLLECT INTO
    SELECT *
    BULK COLLECT INTO v_dept
    FROM dept;
    
    FOR i IN 1..v_dept.count LOOP
        --arr[1] --> arr(1)
        DBMS_OUTPUT.PUT_LINE(v_dept(i).deptno);
    END LOOP;
END;
/


