
--Select Everything from CovidDeaths
Select * from PortfolioProject..CovidDeaths
Where continent is not NULL
Order by 3,4


--Select Everything From CovidVaccinations
Select * from PortfolioProject..CovidVaccinations
Where continent is NOT NULL
Order by 3,4



-- Selecting Data that we are using
Select location,date, total_cases, new_cases,total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is NOT NULL
Order By 1,2



-- List the name of location, unique location
Select distinct(location) from PortfolioProject..CovidDeaths
Where continent is NOT NULL
Order by location


-- total_deaths VS total_case in my Continent and Country
Select location,date,population, total_cases,new_cases,total_deaths,new_deaths,round((total_cases/population)*100,3) As TotalInfectedPopulation,Round((total_deaths/total_cases)*100,3) As DeathPercentage
From PortfolioProject..CovidDeaths
Where location Like '%Nepal%'
--AND continent is NOT NULL
Order By 1,2


Select location,population, max(total_cases) As MaximumCases, (max(total_cases)/population)*100 AS InfectedPeople,
Max(cast(total_deaths as Int)) As TotalDeath, (max(cast(total_deaths as int)/total_cases))*100 As DeathCountPerCases 
From PortfolioProject..CovidDeaths
--Where location in ('Nepal','India')
Where continent is not NUll
Group By location, population


	-- total_deaths vs total_case in wordl
Select location, date, population, total_cases, total_deaths, (total_deaths/total_cases)*100 As DeathRateWorldWide
from PortfolioProject..CovidDeaths
Where  location = 'World'
--Order by 3,4



-- Total Cases vs Population
Select Continent,location,date, total_cases, new_cases,population,Round((total_cases/population)*100,3) As InfectedPercentage
From PortfolioProject..CovidDeaths
--Where location in ('Asia','Nepal')
Where continent is NOT NULL
Order By 2,3


	-- WorldWide cases
Select location, date, population, total_cases,new_cases, total_deaths, (total_cases/population)*100 As InfectedRateWorldWide
from PortfolioProject..CovidDeaths
Where  location = 'World'



-- Highest Infection Rate

Select location,population, max(total_cases) as HighestInfectionCount,Max(Round((total_cases/population)*100,3)) As HighestInfectedPercentage
From PortfolioProject..CovidDeaths
--Where location in ('Asia','Nepal')
Where Continent is Not Null
Group By location, population
Order by HighestInfectedPercentage Desc



-- Highest Death Count per Population
-- Showing location with the highest death count per population

Select location, max(cast(total_deaths as int)) As TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is NOT NULL 
--And location = 'Nepal'
Group By location
Order by TotalDeathCount Desc



-- Highest Death Count per Population
-- Showing Continent with the highest death count per population
Select location, max(cast(total_deaths as int)) As TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is NULL 
Group By location
Order by TotalDeathCount Desc

-- or
Select continent, max(cast(total_deaths as int)) As TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is NOT NULL 
Group By continent
Order by TotalDeathCount Desc



-- Global Numbers

-- Death Percentage Per Day globally
Select date,sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_death,
Round(sum(cast(new_deaths as int))/sum(new_cases)*100,3) as DeathPercentageGlobal
From PortfolioProject..CovidDeaths
Where continent is not Null
Group By date
order by 1,2


-- total_cases, total_death and Death Percentage rate globally
Select sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_death,
Round(sum(cast(new_deaths as int))/sum(new_cases)*100,3) as DeathPercentageGlobal
From PortfolioProject..CovidDeaths
Where continent is not Null




-- Joining two tables
Select * 
From PortfolioProject..CovidDeaths As Death
Join PortfolioProject..CovidVaccinations As Vacci
On Death.location = Vacci.location
and Death.date = Vacci.date
Order by 3,4


-- Total population vs Vaccination
Select Death.continent,Death.location, Death.date, Death.population, new_vaccinations 
, sum(cast(vacci.new_vaccinations as int)) over (Partition By death.location Order By Death.location, Death.Date) As RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths As Death
Join PortfolioProject..CovidVaccinations As Vacci
On Death.location = Vacci.location
and Death.date = Vacci.date
Where Death.continent is not Null
Order by 2,3



-- For percentage of population that get vaccinated, use CTE

With PopulationVaccination(Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
as
(
Select Death.continent,Death.location, Death.date, Death.population, new_vaccinations 
, sum(cast(vacci.new_vaccinations as int)) over (Partition By death.location Order By Death.location, Death.Date) As RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths As Death
Join PortfolioProject..CovidVaccinations As Vacci
On Death.location = Vacci.location
and Death.date = Vacci.date
Where Death.continent is not Null
)
Select *, (RollingPeopleVaccinated/Population)*100 as VaccinatedPeople
from PopulationVaccination



-- Using Temp Table to calculate above operation i.e. percentage of vaccinated people
Drop Table if exists #TempTable
Create Table #TempTable(
Continent varchar(50),
Location varchar(50),
Date Datetime,
Population numeric,
New_vaccinaitons numeric,
RollingPeopleVaccinated numeric
)

Insert into #TempTable
Select Death.continent,Death.location, Death.date, Death.population, new_vaccinations 
, sum(cast(vacci.new_vaccinations as int)) over (Partition By death.location Order By Death.location, Death.Date) As RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths As Death
Join PortfolioProject..CovidVaccinations As Vacci
On Death.location = Vacci.location
and Death.date = Vacci.date
--Where Death.continent is not Null
--Order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100 as VaccinatedPeople
from #TempTable


-- Creating view
Create View PeopleVaccinatedPercentage as
Select Death.continent,Death.location, Death.date, Death.population, new_vaccinations 
, sum(cast(vacci.new_vaccinations as int)) over (Partition By death.location Order By Death.location, Death.Date) As RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths As Death
Join PortfolioProject..CovidVaccinations As Vacci
On Death.location = Vacci.location
and Death.date = Vacci.date
--Where Death.continent is not Null
--Order by 2,3

Select * from PeopleVaccinatedPercentage
