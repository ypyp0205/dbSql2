

SELECT *
FROM jobs;

SELECT *
FROM USER_TABLES;

--78--> 79
SELECT *
FROM ALL_TABLES
WHERE OWNER = 'YP0205';

SELECT *
FROM YP0205.fastfood;

--YP0205.fastfood --> fastfood�ó������ ����
--���� �� ���� sql�� ���������� �����ϴ��� Ȯ��
CREATE SYNONYM fastfood FOR YP0205.fastfood;

SELECT *
FROM fastfood;

