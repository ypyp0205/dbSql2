


SELECT ww.id, ww.sido, ww.sigungu, ww.cal_sal, qq.sido, qq.sigungu, qq.���ù�������

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
ORDER BY ���ù������� DESC)) qq,


(SELECT id, sido, sigungu, cal_sal
FROM 
(SELECT id, sido, sigungu, sal, people, ROUND( sal/people, 1 ) cal_sal
FROM tax
ORDER BY cal_sal DESC) z) ww

WHERE qq.sido(+) = ww.sido
AND qq.sigungu(+) = ww.sigungu
ORDER BY ww.id;

--���ù������� �õ�, �ñ����� �������� ���Աݾ��� �õ�, �ñ����� ���� �������� ����
--���ɼ����� tax ���̺��� id �÷������� ����






--SELECT *
--FROM tax;
--
--UPDATE TAX SET SIGUNGU = TRIM(SIGUNGU);
--COMMIT;



--UPDATE tax SET PEOPLE = 70391
--WHERE SIDO = '����������'
--AND SIGUNGU = '����';
--COMMIT;