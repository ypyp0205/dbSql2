--�ǽ� 1
SELECT *
FROM customer, product;


SELECT *
FROM customer;

SELECT *
FROM fastfood
WHERE sido = '����������';



--���ù��������� ���� ������ ����
--���ù������� = (����ŷ���� + kfc ���� + �Ƶ����� ����) / �Ե����� ����
--���� / �õ�/ �ñ��� / ���ù�������(�Ҽ��� ��° �ڸ����� �ݿø�)
--1 / ����Ư���� / ���ʱ� / 7.5
--1 / ����Ư���� / ������ / 7.2

--�ش� �õ�, �ñ����� ��������� �Ǽ��� �ʿ�
SELECT ROWNUM rn, sido, sigungu, ���ù�������
FROM
(SELECT a.sido, a.sigungu, ROUND(a.cnt / b.cnt, 1) as ���ù�������
FROM

(SELECT sido, sigungu, count(*) cnt --����ŷ, kfc, �Ƶ����� �Ǽ�
FROM fastfood
WHERE gb IN ('kfc', '����ŷ', '�Ƶ�����') 
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, count(*) cnt --�Ե����� �Ǽ�
FROM fastfood
WHERE gb IN '�Ե�����'
GROUP BY sido, sigungu) b

WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY ���ù������� DESC);


SELECT *
FROM tax
ORDER BY sal DESC;

