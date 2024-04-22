--Problem 1: Find the total number of crimes recorded in the CRIME table.
select CASE_NUMBER ,count (*)as total_number_crimes from CHICAGO_CRIME_DATA ; 
--Problem 2: List community areas with per capita income less than 11000.
select COMMUNITY_AREA_NAME ,PER_CAPITA_INCOME FROM CENSUS_DATA where PER_CAPITA_INCOME<11000;
--Problem 3: List all case numbers for crimes involving minors?
select CASE_NUMBER FROM CHICAGO_CRIME_DATA where description LIKE '%MINOR%';

--Problem 4: List all kidnapping crimes involving a child?(children are not considered minors for the purposes of crime analysis)
SELECT case_number FROM CHICAGO_CRIME_DATA WHERE primary_type = 'KIDNAPPING' AND description LIKE '%CHILD%';
--5 Problem 5: What kind of crimes were recorded at schools?
SELECT DISTINCT primary_type FROM CHICAGO_CRIME_DATA WHERE location_description LIKE '%SCHOOL%';

--Problem 6: List the average safety score for all types of schools.
SELECT ElementaryMiddleorHighSchool as School_Type, AVG(SAFETY_SCORE) AVERAGE_SAFETY_SCORE FROM CHICAGO_PUBLIC_SCHOOLS GROUP BY ElementaryMiddleorHighSchool;

Problem --7: List 5 community areas with highest % of households below poverty line.
SELECT COMMUNITY_AREA_NAME, PERCENT_HOUSEHOLDS_BELOW_POVERTY FROM CENSUS_DATA ORDER BY PERCENT_HOUSEHOLDS_BELOW_POVERTY DESC LIMIT 5 ;
--Problem 8: Which community area(number) is most crime prone?
SELECT COMMUNITY_AREA_NUMBER ,COUNT(COMMUNITY_AREA_NUMBER) AS FREQUENCY
FROM CHICAGO_CRIME_DATA 
GROUP BY COMMUNITY_AREA_NUMBER
ORDER BY COUNT(COMMUNITY_AREA_NUMBER) DESC
LIMIT 1;
--Problem 9: Use a sub-query to find the name of the community area with highest hardship
index.
select COMMUNITY_AREA_NAME from CENSUS_DATA where HARDSHIP_INDEX= (SELECT MAX(HARDSHIP_INDEX) FROM CENSUS_DATA);
--Problem 10: Use a sub-query to determine the Community Area Name with most number
--of crimes?
SELECT community_area_name FROM CENSUS_DATA 
WHERE COMMUNITY_AREA_NUMBER = (SELECT COMMUNITY_AREA_NUMBER FROM CHICAGO_CRIME_DATA 
    GROUP BY COMMUNITY_AREA_NUMBER
    ORDER BY COUNT(COMMUNITY_AREA_NUMBER) DESC
    LIMIT 1)
LIMIT 1;

--Problem 11: How many Elementary Schools are in the dataset?
SELECT COUNT(*) FROM CHICAGO_PUBLIC_SCHOOLS WHERE ElementaryMiddleorHighSchool = 'ES';

---Problem 12: Display total number of elementary, middle and high school
--from Chicago_public_Schools
SELECT ElementaryMiddleorHighSchool , count (*) as Totel_number
FROM CHICAGO_PUBLIC_SCHOOLS GROUP by ElementaryMiddleorHighSchool ;
--Problem 13: What is the highest Safety Score? #Which schools have highest Safety Score?
SELECT 
    MAX(safety_score) AS highest_safety_score
FROM 
    CHICAGO_PUBLIC_SCHOOLS;

--SELECT 
 --   school_name,
  --  safety_score
--FROM 
   -- CHICAGO_PUBLIC_SCHOOLS
--WHERE 
   -- safety_score = (SELECT MAendance column.

UPDATE CHICAGO_PUBLIC_SCHOOLS 
SET average_student_attendance = REPLACE(average_student_attendance, '%', '');

--Problem 15: Which Schools have Average Student Attendance lower than 70%?
SELECT  NAME_OF_SCHOOL, average_student_attendance
FROM 
    CHICAGO_PUBLIC_SCHOOLS
WHERE 
    CAST(REPLACE(average_student_attendance, '%', '') AS FLOAT) < 70.0;
--Problem 16: Get the total College Enrollment for each Community Area.
SELECT 
    community_area_name,
    SUM(college_enrollment) AS total_college_enrollment
FROM 
    CHICAGO_PUBLIC_SCHOOLS
GROUP BY 
    community_area_name;
--Problem 17: Get the 5 Community Areas with the least College Enrollment sorted in
--ascending order
SELECT 
    community_area_name,
    SUM(college_enrollment) AS total_college_enrollment
FROM 
    CHICAGO_PUBLIC_SCHOOLS
GROUP BY 
    community_area_name
ORDER BY 
    total_college_enrollment ASC
LIMIT 5;
--Problem 18: Display total number of elementary, middle and high school from
--Chicago_public_Schools

SELECT 
  ElementaryMiddleorHighSchool,
    COUNT(*) AS num_schools
FROM 
    CHICAGO_PUBLIC_SCHOOLS
GROUP BY 
    ElementaryMiddleorHighSchool

--Problem 19: Display ZIPCodes from Chicago_Schools which are having more than 5
--schools.
SELECT  ZIP_Code, COUNT(*) AS num_schools
FROM 
    CHICAGO_PUBLIC_SCHOOLS
GROUP BY ZIP_Code
HAVING num_schools > 5;
--Problem 20: Get the hardship index for the community area which has the school with the
--highest enrollment
SELECT 
    hardship_index
FROM 
    CENSUS_DATA
WHERE 
    community_area_number = (SELECT 
                                 community_area_number 
                             FROM 
                                 CHICAGO_PUBLIC_SCHOOLS 
                             ORDER BY 
                                 college_enrollment DESC 
                             LIMIT 1);
--Problem 21: Display the type of crimes with less than 10 reported crimes for each category.
SELECT 
    primary_type
FROM 
    CHICAGO_CRIME_DATA
GROUP BY 
    primary_type
HAVING 
    COUNT(*) < 10;
--Problem 22 : Display the top 20 least reported types of crime. (Primary_type column
SELECT 
    primary_type,
    COUNT(*) AS num_crimes
FROM 
    CHICAGO_CRIME_DATA
GROUP BY 
    primary_type
ORDER BY 
    num_crimes ASC
LIMIT 20;