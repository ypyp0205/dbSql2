--실습8
SELECT countries.region_id, region_name, country_name
FROM countries, regions
WHERE countries.region_id = regions.region_id
AND countries.region_id = '1';

--실습9 
--row 9 - France, Denmark, belgium 3개 구각에 속하는 locations 정보는 미존재
--나머지 5개중에 다수의 location 정보를 갖고 있는 국가가 존재한다.
SELECT countries.region_id, region_name, country_name, city
FROM countries, regions, locations
WHERE countries.region_id = regions.region_id
AND countries.country_id = locations.country_id
AND countries.region_id = '1';

--실습10
SELECT countries.region_id, region_name, countries.country_name, city, department_name
FROM countries, regions, locations, departments
WHERE countries.region_id = regions.region_id
AND countries.country_id = locations.country_id
AND countries.region_id = '1'
AND locations.location_id = departments.location_id;

--실습11
SELECT countries.region_id, region_name, countries.country_name, city, department_name, employees.first_name || ' ' || employees.last_name name
FROM countries, regions, locations, departments, employees
WHERE countries.region_id = regions.region_id
AND countries.country_id = locations.country_id
AND locations.location_id = departments.location_id 
AND employees.department_id = departments.department_id 
AND region_name IN ('Europe');

--실습12
SELECT employee_id, employees.first_name || ' ' ||  employees.last_name name, employees.job_id, job_title
FROM employees, jobs
WHERE employees.job_id = jobs.job_id;

--실습13
SELECT m.manager_id MNG_ID, e.first_name || ' ' || e.last_name mgr_name, m. employee_id , m.first_name || ' ' || m.last_name name,
      j. job_id, j.job_title 
FROM employees e, jobs j, employees m
WHERE m.job_id = j.job_id
AND m.manager_id = e.employee_id
ORDER BY m.manager_id;


SELECT *
FROM employees;

SELECT *
FROM jobs;

SELECT *
FROM  departments;

SELECT *
FROM  locations;
SELECT *
FROM  regions;
SELECT employees.first_name || employees.last.name
FROM employees;
WHERE ON(first_name last.name)


SELECT first_name || last.
FROM employees;


SELECT m.ename, s.ename
FROM emp m LEFT OUTER JOIN emp s ON(m.mgr = s.empno;

