--실습 1
SELECT *
FROM customer, product;

SELECT *
FROM customer;

SELECT *
FROM fastfood
WHERE sido = '대전광역시';

--도시발전지수가 높은 순으로 나열
--도시발정지수 = (버거킹개수 + kfc 개수 + 맥도날드 개수) / 롯데리아 개수
--순위 / 시동/ 시군구 / 도시발전지수(소수점 둘째 자리에서 반올림)
--1 / 서울특별시 / 서초구 / 7.5
--1 / 서울특별시 / 강남구 / 7.2

--해당 시도, 시군구별 프렌차이즈별 건수가 필요
SELECT ROWNUM rn, sido, sigungu, 도시발전지수
FROM
(SELECT a.sido, a.sigungu, ROUND(a.cnt / b.cnt, 1) as 도시발전지수
FROM

(SELECT sido, sigungu, count(*) cnt --버거킹, kfc, 맥도날드 건수
FROM fastfood
WHERE gb IN ('버거킹', 'KFC', '맥도날드') 
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, count(*) cnt --롯데리아 건수
FROM fastfood
WHERE gb IN '롯데리아'
GROUP BY sido, sigungu) b

WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY 도시발전지수 DESC);




SELECT *
FROM tax
ORDER BY sal DESC;

