--How many Elementary Schools are in the dataset
SELECT count(*) FROM ChicagoPublicSchools WHERE ElementaryMiddleorHighSchool = 'ES';    
--Correct answer: 462

--What is the highest Safety Score?
SELECT MAX(Safety_Score) AS MAX_SAFETY_SCORE FROM ChicagoPublicSchools;
--Correct answer: 99

--Which schools have highest Safety Score?
 select Name_of_School, Safety_Score from ChicagoPublicSchools where Safety_Score = 99;

--or, a better way:

-- select Name_of_School, Safety_Score from ChicagoPublicSchools where 
  --Safety_Score= (select MAX(Safety_Score) from ChicagoPublicSchools

--Correct answer: several schools with with Safety Score of 99.

--What are the top 10 schools with the highest "Average Student Attendance"?
select Name_of_School, Average_Student_Attendance from ChicagoPublicSchools
    order by Average_Student_Attendance desc nulls last limit 10;
	--Retrieve the list of 5 Schools with the lowest Average Student Attendance sorted in ascending order based on attendance
	SELECT Name_of_School, Average_Student_Attendance from ChicagoPublicSchools 
     order by Average_Student_Attendance LIMIT 5;
--Now remove the '%' sign from the above result set for Average Student Attendance column
SELECT Name_of_School, REPLACE(Average_Student_Attendance, '%', '') from ChicagoPublicSchools
     order by Average_Student_Attendance LIMIT 5;
--Which Schools have Average Student Attendance lower than 70%?
select Name_of_School,Average_Student_Attendance from ChicagoPublicSchools where AVERAGE_STUDENT_ATTENDANCE <'70.00%';
--Get the total College Enrollment for each Community Area¶
select Community_Area_Name, sum(College_Enrollment) AS TOTAL_ENROLLMENT
   from ChicagoPublicSchools
   group by Community_Area_Name ;
--Get the 5 Community Areas with the least total College Enrollment  sorted in ascending order
select Community_Area_Name, sum(College_Enrollment) AS TOTAL_ENROLLMENT 
   from ChicagoPublicSchools
   group by Community_Area_Name 
   order by TOTAL_ENROLLMENT asc 
   LIMIT 5 ;
   --List 5 schools with lowest safety score.
   select NAME_OF_SCHOOL ,SAFETY_SCORE as Lowest_safety_score  from ChicagoPublicSchools 
    where safety_score !='None'
    order by SAFETY_SCORE asc
	 LIMIT 5  ;
	 --Get the hardship index for the community area which has College Enrollment of 4368
	 select hardship_index from ChicagoPublicSchools CPS 
         where  college_enrollment = 4368;
/*select hardship_index from CENSUS_DATA CD, CHICAGO_PUBLIC_SCHOOLS_DATA CPS 
where CD.community_area_number = CPS.community_area_number 
and college_enrollment = 4368*\

--Get the hardship index for the community area which has the highest value for College Enrollment
select community_area_number, community_area_name, hardship_index from CENSUS_DATA \
   where community_area_number in 
   ( select community_area_number from CHICAGO_PUBLIC_SCHOOLS_DATA order by college_enrollment desc limit 1 )
-->