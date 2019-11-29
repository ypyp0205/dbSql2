--실습8
SELECT countries.region_id, region_name, country_name
FROM countries, regions
WHERE countries.region_id = regions.region_id
AND countries.region_id = '1';

--실습9
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
SELECT countries.region_id, region_name, countries.country_name, city, department_name, name
FROM countries, regions, locations, departments, employees;






SELECT *
FROM countries;
SELECT *
FROM  departments;


SELECT *
FROM  locations;
SELECT *
FROM  regions;




