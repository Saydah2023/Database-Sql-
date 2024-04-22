--1. Write SQL query to sum all the funding AmountinUSD, where City location equals “Bengaluru”
SELECT sum(AmountinUSD) AS TotalFunding FROM indian_startup_funding where CityLocation = 'Bengaluru';

--2 Write SQL query to sort the table by startup name DESC
SELECT * FROM indian_startup_funding order by StartupName DESC;

--3. Write SQL query to sum all the funding AmountinUSD, where City location equals “Bengaluru” and AmountinUSD>380000
SELECT sum(AmountinUSD) AS TotalFunding FROM indian_startup_funding where CityLocation = 'Bengaluru' and AmountinUSD>380000;

--4. Write SQL query to get all CityLocations that has an AmountinUSD >380000
SELECT CityLocation ,AmountinUSD FROM indian_startup_funding where AmountinUSD >380000 ;

--5. Write SQL query to get only unique CityLocations that has an AmountinUSD >380000
select DISTINCT CityLocation FROM indian_startup_funding where AmountinUSD >380000 ;

--6. Write SQL query to get all StartupNames where AmountinUSD<380000
SELECT StartupName FROM indian_startup_funding where AmountinUSD <380000 ;
--7. Write SQL query to sort the output from the previous question DESC
SELECT StartupName FROM indian_startup_funding where AmountinUSD <380000 
ORDER by StartupName DESC ;
--8. Write SQL query to get the City location that has the maximum funding amount “Note that is the data is not cleaned properly you will get non logical result”
select CityLocation from indian_startup_funding where AmountinUSD =(SELECT max(AmountinUSD) FROM indian_startup_funding);
--9. Write SQL query to get the total funding AmountinUSD for each IndustryVertical
Select IndustryVertical, sum(AmountinUSD) AS TotalFunding FROM indian_startup_funding group by IndustryVertical;

--10. Write SQL query to get the total funding AmountinUSD for each IndustryVertical that starts with letter “A”
Select IndustryVertical, sum(AmountinUSD) AS TotalFunding FROM indian_startup_funding  where 
IndustryVertical like 'A%'
 group by IndustryVertical;
--11. Write SQL query to get the total funding AmountinUSD for each IndustryVertical that starts with letter “A” and sort the output DESC by the total AmountinUSD
Select IndustryVertical, sum(AmountinUSD) AS TotalFunding 
FROM indian_startup_funding  where IndustryVertical like 'A%'
  group by IndustryVertical order by TotalFunding  DESC ;
--12. Write SQL query to count all the start_ups in the Education field
select  COUNT(*) AS StartupCount FROM indian_startup_funding  where IndustryVertical= 'Education';
--13. Write SQL query to count all the start_Ups in the E-Commerce field
select  COUNT(*) AS StartupCount FROM indian_startup_funding  where IndustryVertical= 'E-Commerce';
--14. Write SQL query to count all the start_Ups in the E-Commerce field, where city location equals “Bengaluru”
select count(*) AS StartupCount from indian_startup_funding where IndustryVertical= 'E-Commerce' AND CityLocation='Bengaluru';
--15. For each Industry Vertical find the total funding amount
select IndustryVertical,sum(AmountinUSD) AS TotalFunding from indian_startup_funding group by  IndustryVertical;
--16. For each Industry Vertical find the total funding amount as “Total_fund” and the average funding amount as “Avg_Fund”. In this question provide two answer 1- using group by Industry Vertical, 2- using sub_queries
--1 
select IndustryVertical ,sum(AmountinUSD) AS TotalFund ,avg(AmountinUSD) as Average_Fund from indian_startup_funding
group by IndustryVertical;
--2

--17. Write SQL query to get the minimum value of funding for the “Uniphore” start_up
SELECT   MIN(AmountinUSD) AS Minimum_funding
FROM indian_startup_funding WHERE  StartupName = 'Uniphore';
   
--18. Write SQL query to get the length of the city location names
select CityLocation ,length(CityLocation) FROM indian_startup_funding ;
--19. Write SQL query to convert start_ups names into uppercase if the funding amount is >380,000
SELECT 
    CASE 
        WHEN AmountinUSD > 380000 THEN UPPER(StartupName)
        ELSE StartupName
    END AS StartupName
FROM indian_startup_funding;
20. Write SQL query to select distinct industry vertical names, knowing that names are mix of lowercase and uppercase values.
select  distinct upper (IndustryVertical )from indian_startup_funding ;