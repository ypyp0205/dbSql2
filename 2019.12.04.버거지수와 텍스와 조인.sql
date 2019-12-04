



SELECT bg.rn, bg.sido, bg.sigungu,  ROUND(tx.sal / tx.people, 2)


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
ORDER BY 도시발전지수 DESC)) bg,

(SELECT  *
FROM tax
ORDER BY sal DESC) tx

WHERE bg.sido(+) = tx.sido
AND bg.sigungu(+) = tx.sigungu;

ORDER BY rn;

SELECT *
FROM tax

ORDER BY sal DESC;
