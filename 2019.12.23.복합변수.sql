--ROWTYPE
--특정 테이블의 ROW 정보를 담을 수 있는 참조 타입
--TYPE : 테이블명.테이블 컬럼명%TYPE --> %COLTYPE
--ROWTYOE : 테이블명%ROWTYPE
SET SERVEROUTPUT ON;
DECLARE 
    --dept 테이블의 row 정보를 담을 수 있는 ROWTYPE 변수 선언
    dept_row dept%ROWTYPE;
BEGIN
    SELECT *
    INTO dept_row
    FROM dept
    WHERE DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE(dept_row.dname || ', ' || dept_row.loc);
END;
/    



--public class 클래스명{
--      필드type 필드(컬럼);     //String name;
--      필드2type 필드(컬럼)2;    //int age;
--}
  


--RECORD TYPE : 개발자가 컬럼을 직접 선언하여 개발에 필요한 TYPE을 생성
--TYPE 타입이름 IS RECORD
--         컬럼1 컬럼1TYPE,
--         컬럼2 컬럼2TYPE
--;

DECLARE
    -- 부서이름, LOC 정보를 저장 할 수 있는 RECORD TYPE 선언
    TYPE dept_row IS RECORD(
        dname dept.dname%TYPE,
        loc dept.loc%TYPE);
        --type선언이 완료, type을 갖고 변수를 생성
        --java : Class 생성후 해당 class의 인스턴스를 생성(new)
        --plsql 변수 생성 : 변수이름 변수타입 dname dept.dname%TYPE;
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


--TABLE TYPE : 여러개의 ROWTYPE을 저장할 수 있는 TYPE
--col --> row --> table
--TYPE 테이블타입명 IS TABLE OF ROWTYPE/RECORD INDEX BY 인덱스 타입 (BINARY_INTEGER)
--java와 다르게 plsql에서는 arrary 역할을 하는 table type의 인덱스를
--숫자 뿐만 아니라, 문자열 형태도 가능하다
--그렇기 때문에 index에 대한 타입을 명시한다.
--일반적으로 array(list) 형태인 경우라면 INDEX BY BINARY_INTEGER를 주로 사용한다.
--arr(1).name = 'brown'
--arr('person').name = 'brown'

--dept테이블의 row를 여러건 저장 할 수 있는 dept_tab TABLE TYPE 선언하여
--SELECT * FROM dept; 의 결과(여러건)를 변수에 담는다.
DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;
BEGIN
    --한 row의 값을 변수에 저장 : INTO
    --복수 row의 값을 변수에 저장 : BULK COLLECT INTO
    SELECT *
    BULK COLLECT INTO v_dept
    FROM dept;
    
    FOR i IN 1..v_dept.count LOOP
        --arr[1] --> arr(1)
        DBMS_OUTPUT.PUT_LINE(v_dept(i).deptno);
    END LOOP;
END;
/


