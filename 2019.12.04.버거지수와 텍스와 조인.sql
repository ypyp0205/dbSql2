



SELECT bg.rn, bg.sido, bg.sigungu, bg.���ù�������, tx.people, tx.sal


FROM
(SELECT ROWNUM rn, sido, sigungu, ���ù�������


FROM
(SELECT a.sido, a.sigungu, ROUND(a.cnt / b.cnt, 1) as ���ù�������
FROM

(SELECT sido, sigungu, count(*) cnt --����ŷ, kfc, �Ƶ����� �Ǽ�
FROM fastfood
WHERE gb IN ('����ŷ', 'KFC', '�Ƶ�����') 
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, count(*) cnt --�Ե����� �Ǽ�
FROM fastfood
WHERE gb IN '�Ե�����'
GROUP BY sido, sigungu) b

WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY ���ù������� DESC)) bg,

(SELECT *
FROM tax
ORDER BY sal DESC) tx

WHERE bg.sido(+) = tx.sido
AND bg.sigungu(+) = tx.sigungu
ORDER BY rn;

SELECT *
FROM tax
ORDER BY sal DESC;
