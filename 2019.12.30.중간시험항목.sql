-----------------------------------------------------------------------------------------------------
-- PROD, LPROD PK, FK
SELECT *
FROM user_constraints
WHERE table_name IN ('PROD', 'LPROD')
AND constraint_type IN ('P', 'R');


-----------------------------------------------------------------------------------------------------
-- 1. member테이블을 통해 member2 테이블 생성
-- 2. member 테이블에서 김은대 회원의 직업을 '군인'으로 수정하는 DML 문 작성
-- COMMIT;
-- 3. 데이터 조회를 통해 데이터 변경 확인

CREATE TABLE member2 AS
SELECT *
FROM member;

SELECT * FROM USER_CONSTRAINTS WHERE table_name = 'MEMBER2';

UPDATE member SET mem_job = '군인' WHERE mem_name = '김은대';
COMMIT;

SELECT mem_name, mem_job FROM member WHERE mem_name = '김은대';


-----------------------------------------------------------------------------------------------------
--제품별 매입금액합
--VM_PROD_BUY
CREATE OR REPLACE VIEW VM_PROD_BUY AS
SELECT buy_prod, SUM(buy_cost) sum_buy_cost
FROM buyprod
GROUP BY buy_prod;

SELECT *
FROM VM_PROD_BUY;


-----------------------------------------------------------------------------------------------------


create or replace PROCEDURE proc_test1
(v_yyyymm IN VARCHAR2) IS
    TYPE cal_row_type IS RECORD(
        dt VARCHAR2(8),
        day number);
    TYPE cal_tab IS TABLE OF cal_row_type INDEX BY BINARY_INTEGER;
    v_cal_tab cal_tab;
BEGIN
    DELETE daily  
    WHERE dt LIKE v_yyyymm || '%';

    SELECT TO_CHAR(TO_DATE(v_yyyymm, 'YYYYMM') + (LEVEL-1), 'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(v_yyyymm, 'YYYYMM') + (LEVEL-1), 'D') day
    BULK COLLECT INTO v_cal_tab
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(v_yyyymm, 'YYYYMM')), 'DD');  --어디까지인지를 표기
     FOR daily IN (SELECT * FROM cycle) LOOP
        
        FOR i IN 1..v_cal_tab.count LOOP
            IF daily.day = v_cal_tab(i).day THEN
                
                INSERT INTO daily VALUES 
                    (daily.cid, daily.pid, v_cal_tab(i).dt, daily.cnt);
            END IF;    
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(daily.cid || ', ' || daily.day);
    END LOOP;
     COMMIT;
    END;
/






-- cart_member, cart_prod 
-- ==> 회원별 카트 수량합, 제품별 카트 수량합
SELECT *
FROM cart;


SELECT cart_member, cart_prod, SUM(cart_qty) sum_cart_qty
FROM cart
GROUP BY GROUPING SETS (cart_member, cart_prod);



























