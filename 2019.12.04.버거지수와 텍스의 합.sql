


SELECT ww.id, ww.sido, ww.sigungu, ww.cal_sal, qq.sido, qq.sigungu, qq.도시발전지수

FROM
(SELECT ROWNUM rn, sido, sigungu, 도시발전지수
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
ORDER BY 도시발전지수 DESC)) qq,


(SELECT id, sido, sigungu, cal_sal
FROM 
(SELECT id, sido, sigungu, sal, people, ROUND( sal/people, 1 ) cal_sal
FROM tax
ORDER BY cal_sal DESC) z) ww

WHERE qq.sido(+) = ww.sido
AND qq.sigungu(+) = ww.sigungu
ORDER BY ww.id;

--도시발전지수 시도, 시군구와 연말정산 납입금액의 시도, 시군구가 같은 지역끼리 조인
--정령순서는 tax 테이블의 id 컬럼순으로 정렬






--SELECT *
--FROM tax;
--
--UPDATE TAX SET SIGUNGU = TRIM(SIGUNGU);
--COMMIT;



--UPDATE tax SET PEOPLE = 70391
--WHERE SIDO = '대전광역시'
--AND SIGUNGU = '동구';
--COMMIT;