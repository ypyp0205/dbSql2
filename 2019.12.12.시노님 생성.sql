

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

--YP0205.fastfood --> fastfood시노님으로 생성
--생성 후 다음 sql이 정상적으로 동작하는지 확인
CREATE SYNONYM fastfood FOR YP0205.fastfood;

SELECT *
FROM fastfood;

