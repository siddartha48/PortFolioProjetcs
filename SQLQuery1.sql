select *
FROM PortFolioProject.dbo.CovidDeaths
where continent is not null
order by 3,4 

select new_vaccinations
FROM PortFolioProject.dbo.CovidVaccinations
where continent is not null


select *
FROM PortFolioProject.dbo.CovidVaccinations
order by 3,4 
select location,date,total_cases, new_cases, total_deaths, population
FROM PortFolioProject.dbo.CovidDeaths
where continent is not null
order by 1,2

--Lookin at total  cases vs total deaths 
select location,date,total_cases, total_deaths, (total_deaths/total_cases)*100 AS 'DeathPercenatge'
FROM PortFolioProject.dbo.CovidDeaths
WHERE location like '%states'
order by 1,2
--Lookin at total  cases vs population 
--show what percentage got covid

select location,date,total_cases, population, (total_cases/population)*100 AS 'CasePercentage'
FROM PortFolioProject.dbo.CovidDeaths
--WHERE location like '%states'
--group by location,population
where continent is not null
order by CasePercentage DESC

--looking at countries with highest infrction rates compared to population 
select location,population, MAX(total_cases) AS 'maximin total cases',  MAX((total_cases/population))*100 AS 'PercentPopulationInfected'
FROM PortFolioProject.dbo.CovidDeaths
--WHERE location like '%states'
where continent is not null
group by location,population
order by PercentPopulationInfected DESC


--highest death count per person 
select location, MAX(cast(total_deaths as int)) AS 'maximum_deaths_cases', MAX(total_deaths/total_cases)*100 AS deathPercentage
FROM PortFolioProject.dbo.CovidDeaths
--WHERE location like '%states'
where continent is  null
group by location 
order by maximum_deaths_cases DESC

--let's BREAK THIS DOWN BY CONTINENT 

select continent, MAX(cast(total_deaths as int)) AS 'maximum_deaths_cases', MAX(total_deaths/total_cases)*100 AS deathPercentage
FROM PortFolioProject.dbo.CovidDeaths
--WHERE location like '%INDIA'
where continent is not null
group by continent 
order by maximum_deaths_cases DESC


--showing the continent with highest death count per population 

select continent, MAX(cast(total_deaths as int)) AS 'maximum_deaths_cases', MAX(total_deaths/population)*100 AS deathPercentage
FROM PortFolioProject.dbo.CovidDeaths
--WHERE location like '%INDIA'
where continent is not null
group by continent 
order by deathPercentage DESC


--GLOBAL NUMBERS
SELECT date, SUM(new_cases) as 'total_cases' , SUM(cast(new_deaths as int)) as 'total_deaths' , SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS 'DeathPercentage'
FROM PortFolioProject.dbo.CovidDeaths
where continent is not null
group by date
order by DeathPercentage DESC;

--Looking at total population vs vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int )) 
OVER (Partition by dea.location Order By dea.location,dea.date)   AS 'rollingPeopleVacinated'
,(SUM(cast(vac.new_vaccinations as int )) 
OVER (Partition by dea.location Order By dea.location,dea.date) /dea.population)*100 AS 'pencentage'
FROM PortFolioProject..CovidDeaths dea
JOIN PortFolioProject..CovidVaccinations vac 
On dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3 

--USING CTE 
 WIth PopvsVac (continent,location,date,population,new_vaccinations,rollingPeopleVacinated)
 as
 (
 SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) 
OVER (Partition by dea.location Order By dea.location,dea.date)   AS 'rollingPeopleVacinated'

FROM PortFolioProject..CovidDeaths dea
JOIN PortFolioProject..CovidVaccinations vac 
On dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
--order by 2,3 
)
SELECT *,	(rollingPeopleVacinated/population)*100
FROM PopvsVac


--TEMP TABLE 
Drop Table if exists  #PercentPopulationvsVaccianated
Create Table #PercentPopulationvsVaccianated 
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rollingPeopleVacinated numeric
)
Insert into #PercentPopulationvsVaccianated
 SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) 
OVER (Partition by dea.location Order By dea.location,dea.date)   AS 'rollingPeopleVacinated'
FROM PortFolioProject..CovidDeaths dea
JOIN PortFolioProject..CovidVaccinations vac 
On dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
--order by 2,3 

SELECT *,	(rollingPeopleVacinated/population)*100
FROM #PercentPopulationvsVaccianated

-- Creating View to store data for later visualizations

Create View PercentPopulationvsVaccianated as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) 
OVER (Partition by dea.location Order By dea.location,dea.date)   AS 'rollingPeopleVacinated'
FROM PortFolioProject..CovidDeaths dea
JOIN PortFolioProject..CovidVaccinations vac 
On dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
--order by 2,3 

