SELECT *
FROM dept;

--dept 테이블에 부서번호 99, 부서명 ddit, 위치 daejeon
INSERT INTO dept VALUES ( 99, 'ddit', 'daejeon');
COMMIT;

--UPDATE : 테이블에 저장된 컬럼의 값을 변경
--UPDATE 테이블명 SET 컬럼명 1= 적용하려고하는 값1, 컬러명2 = 적용하려고하는 값2...
--[WHERE row 조회 조건] --조회조건에 해당하는 데이터만 업데이트가 된다.

--부서번호가 99번인 부서의 부서명을 대덕IT로, 지역을 영민빌딩으로 변경
UPDATE dept SET dname = '대덕IT', loc = '영민빌딩'
WHERE deptno = 99;

SELECT *
FROM dept;

--다음 QUERY를 실행하면 WHERE절에 ROW 제한 조건이 없기 때문에
--dept 테이블의 모든 행에 대해 부서명, 위치 정보를 수정한다.
UPDATE dept SET dname = '대덕IT', loc = '영민빌딩'


--업데이트전에 업데이트 하려고하는 테이블을 WHERE절에 기술한 조건으로 
--SELECT를 하여 업데이트 대상 ROW를 확인해보자
SELECT *
FROM dept
WHERE deptno = 99;
