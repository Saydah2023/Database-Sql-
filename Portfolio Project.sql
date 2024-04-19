select *
from PortfolioProject.dbo.CovidDeaths
order by 3,4
--select *
--from PortfolioProject..CovidVaccinations
--order by 3,4

--select data that we are going to be using

select location ,date , total_cases, new_cases, total_deaths, population 
from PortfolioProject.dbo.CovidDeaths
order by 1,2


-- Looking to Totel cases vs Totel deaths
--Shows likelihood of dying if you contract covid in your country.

select location ,date , total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPresentage
from PortfolioProject.dbo.CovidDeaths
Where location like '%states%'
order by 1,2

--Looking to the totel cases vs the Populations 
--Shows  what percentage of Populations got Covid

select location ,date , population ,total_cases, (total_cases/ population)*100 as PresentPopulationInfected
from PortfolioProject.dbo.CovidDeaths
Where location like '%states%'
order by 1,2

-- Looking at countries with Highest Infection Rate compare to population

select location , population ,max(total_cases)as HighestInfectionCount,
max((total_cases/ population))*100 as PresentPopulationInfected
from PortfolioProject.dbo.CovidDeaths
--Where location like '%states%'
Group by  location, population
order by PresentPopulationInfected desc


--Showing countries with Highes Death Count per Population

select location , max(cast(total_deaths as int ))as TotalDeathCount
from PortfolioProject.dbo.CovidDeaths
--Where location like '%states%'
where continent is not null
Group by  location
order by TotalDeathCount desc


--lets breack down By continent
--Shwing continent with the highest death count per population 

select continent , max(cast(total_deaths as int ))as TotalDeathCount
from PortfolioProject.dbo.CovidDeaths
--Where location like '%states%'
where continent is not null
Group by  continent
order by TotalDeathCount desc



--Globle Numbers
select date , SUM(new_cases)as total_cases , sum(cast (new_deaths as int ))as totel_deaths ,sum(cast (new_deaths as int ))/sum(new_cases)*100 as DeathPresentage
from PortfolioProject.dbo.CovidDeaths
--Where location like '%states%'
where continent is not null
group by date
order by 1,2

--Looking at Totel population vs vaccination

Select dea.continent,dea. location, dea.date, dea.population , vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations )) over (partition by dea.location order by dea.location ,dea.date) as RollingPeopleVaccinated 
From PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location=vac.location and 
dea.date= vac.date
where dea.continent is not null
order by 2,3

--Use CTE
with PopvsVas(contient, location ,date, population ,new_vaccinations ,RollingPeopleVaccinated )
as

(
Select dea.continent,dea. location, dea.date, dea.population , vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations )) over (partition by dea.location order by dea.location ,dea.date) as RollingPeopleVaccinated 
From PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location=vac.location and 
dea.date= vac.date
where dea.continent is not null
--order by 2,3
)

select *
from PopvsVas



--Temp Table 
drop table if exists #PrecentPopulationVaccinated
create table #PrecentPopulationVaccinated
(
contient nvarchar(255),
location nvarchar(255),
Data  datetime ,
Population numeric,
new_vaccinates numeric,
RollingPeopleVaccinated numeric
)

insert into #PrecentPopulationVaccinated
Select dea.continent,dea. location, dea.date, dea.population , vac.new_vaccinations,
sum(convert(numeric,vac.new_vaccinations )) over (partition by dea.location order by dea.location ,dea.date) as RollingPeopleVaccinated 
From PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location=vac.location and 
dea.date= vac.date
--where dea.continent is not null
--order by 2,3
Select *,( RollingPeopleVaccinated /Population)*100
from #PrecentPopulationVaccinated


-- creating view to store data for later visualization 

create view PrecentPopulationVaccinated as 
Select dea.continent,dea. location, dea.date, dea.population , vac.new_vaccinations,
sum(convert(numeric,vac.new_vaccinations )) over (partition by dea.location order by dea.location ,dea.date) as RollingPeopleVaccinated 
From PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location=vac.location and 
dea.date= vac.date
where dea.continent is not null
--order by 2,3

   select *
   from PrecentPopulationVaccinated 