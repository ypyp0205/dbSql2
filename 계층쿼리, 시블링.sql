  
    
SELECT LPAD('XX회사', 15, '*'),
       LPAD('XX회사', 15)
FROM dual;
/*
    dept0(XX회사)
        dept0_00(디자인부)
            dept0_00_0(디자인팀)
        dept0_01(정보기획부)
            dept0_01_0(기획팀)
                dept0_00_0_0(기획파트)
        dept0_02(정보시스템부)        
            dept0_02_0(개발1팀)
            dept0_02_1(개발2팀)   */
            
            
--실습1
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL - 1)*3) || deptnm
FROM dept_h
START WITH deptcd = 'dept0'   --시작점은 depted = 'dept0' --> XX회사(최상위조직)
CONNECT BY PRIOR deptcd = p_deptcd;
  


            

--실습 2           
--디자인팀(dept0_00_0)을 기준으로 상향식 계층쿼리 작성
--자기 부서의 부모 부서와 연결을 한다.
SELECT LEVEL lv, dept_h.*
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd; --AND PRIOR deptnm LIKE '디자인%'; --AND col = PRIOR col2;
            
--실습 3                      
SELECT deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd;      
            
--실습 4            
SELECT LPAD(' ', (LEVEL-1)*4) || S_ID S_ID, VALUE 
FROM H_SUM
START WITH S_ID = '0'
CONNECT BY PRIOR S_ID = PS_ID;      

SELECT *
FROM h_sum;
            
--실습 5
SELECT LPAD(' ', (LEVEL-1)*4) || org_cd org_cd, NO_EMP
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd =  parent_org_cd;      
            
            
            
--pruning branch(가지치기)
--계츨 퀄리의 실행순서
--FROM -> START WITH -CONNECT BY -> WHERE
--조건을 CONNECT BY 절에 기술한 경우
--조건에 따라 다음 ROW로 연결이 안되고 종료
--조건을 WHERE 절에 기술한 경우
-- START WITH - CONNECT BY 절에 의해 계층형으로 나온 결과에
--WHERE절에 기술한 결과 값에 해당하는 데이터만 조회

--최상위 노드에서 하향식으로 탐색
SELECT *
FROM dept_h
WHERE deptcd = 'dept0';


--CONNECT BY절에 deptnm != '정보기획부' 조건을 기술한 경우
SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '정보기획부';
            
--WHERE절에 deptnm != '정보기획부' 조건을 기술한 경우
--계층쿼리를 실행하고나서 최종 결과에 WHERE절 조건을 적용
SELECT *
FROM dept_h
WHERE deptnm != '정보기획부'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;            

--계층 쿼리에서 사용 가능한 특수 함수
--CONNECT_BY_ROOT(col) 가장 최상위 row의 col 정보 값 조회
--SYS_CONNECT_BY_PATH(col, 구분자) : 최상위 row에서 현재 로우까지 col값을
--구분자로 연결해준 문자열 (EX : XX회사 - 디자인부디자인팀)
--CONNECT_BY_ISLEAF : 해당 ROW가 마지막 노드인지(leaf Node)
--leaf node : 1, code : 0
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm deptnm,
        CONNECT_BY_ROOT(deptnm) c_root,
        LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-') sys_path,
        CONNECT_BY_ISLEAF isleaf
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;            

            
SELECT *
FROM board_test;

--실습 6
SELECT seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

--실습 7
SELECT seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq DESC;

--실습 8
SELECT seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

--실습 9 
--값이 하나있으면 편한데 없어도 가능
SELECT parent_seq,seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY NVL(parent_seq, seq) DESC;




