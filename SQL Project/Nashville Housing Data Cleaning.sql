
/*
Nashville Housing Data for Data Cleaning

Cleaning data in SQL

*/

Select * From [PortfolioProject]..NashvilleHousing

-- Standardize Data Format --------------------------------

Select SaleDateUpdated, convert(Date,SaleDate)
From [PortfolioProject]..NashvilleHousing

Update PortfolioProject..NashvilleHousing
Set SaleDate = CONVERT(Date,SaleDate)

-- or

Alter Table NashvilleHousing
Add SaleDateUpdated Date;

Update PortfolioProject..NashvilleHousing
Set SaleDateUpdated = CONVERT(Date,SaleDate)

-------------------------------------------------
-- Populate Property Address Data

Select *
From PortfolioProject..NashvilleHousing
--Where PropertyAddress is NULL
Order BY ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL( a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
Join PortfolioProject..NashvilleHousing b
On a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is NULL



Update a
Set PropertyAddress = ISNULL( a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
Join PortfolioProject..NashvilleHousing b
On a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is NULL


------------------------------------------------------------------
-- Breaking address into Individual columns

Select PropertyAddress 
From PortfolioProject..NashvilleHousing

Select 
Substring(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1) As Address,
Substring(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)) As City 
From  PortfolioProject..NashvilleHousing


Alter Table NashvilleHousing
Add Property_Address NVarchar(300);

Update PortfolioProject..NashvilleHousing
Set Property_Address = Substring(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1)


Alter Table NashvilleHousing
Add Property_City NVarchar(200);

Update PortfolioProject..NashvilleHousing
Set Property_City =Substring(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))

Select PropertyAddress, Property_Address, Property_City
From PortfolioProject..NashvilleHousing


-- Owner Address
 Select OwnerAddress,
PARSENAME(Replace(OwnerAddress,',','.'),3) As Owner_Address,
PARSENAME(Replace(OwnerAddress,',','.'),2) As Owner_City,
PARSENAME(Replace(OwnerAddress,',','.'),1) As Owner_State
From  PortfolioProject.dbo.NashvilleHousing



Alter Table PortfolioProject..NashvilleHousing
Add Owner_Address NVarchar(300);

Update PortfolioProject..NashvilleHousing
Set Owner_Address = PARSENAME(Replace(OwnerAddress,',','.'),3) 



Alter Table PortfolioProject..NashvilleHousing
Add Owner_City NVarchar(300);

Update PortfolioProject..NashvilleHousing
Set Owner_City =PARSENAME(Replace(OwnerAddress,',','.'),2) 



Alter Table PortfolioProject..NashvilleHousing
Add Owner_State NVarchar(300);

Update PortfolioProject..NashvilleHousing
Set Owner_State =PARSENAME(Replace(OwnerAddress,',','.'),1) 


Select * From PortfolioProject..NashvilleHousing

--------------------------------------------------------------
-- Change Y and N to Yes and No in 'Sold as Vacant' field

Select Distinct(SoldAsVacant),count(SoldAsVacant)
From PortfolioProject..NashvilleHousing
Group By SoldAsVacant


Select SoldAsVacant,
Case
When SoldAsVacant = 'Y' then 'Yes'
When SoldAsVacant = 'N' then 'No'
Else SoldAsVacant
End
From PortfolioProject..NashvilleHousing

Update PortfolioProject..NashvilleHousing
Set SoldAsVacant = Case
When SoldAsVacant = 'Y' then 'Yes'
When SoldAsVacant = 'N' then 'No'
Else SoldAsVacant
End

---------------------------------------------------------------
-- Remove Duplicates
With NashHouse As(
Select *,
ROW_NUMBER() over (
Partition By ParcelID,
PropertyAddress,
SaleDate, LegalReference
Order BY UniqueID
) row_num
From PortfolioProject..NashvilleHousing
)
Delete * 
From NashHouse
Where row_num>1
Order By PropertyAddress


Select * From PortfolioProject..NashvilleHousing

----------------------------------------------------------
-- Delete Unused/Updated Columns


Select * From PortfolioProject..NashvilleHousing

Alter Table PortfolioProject..NashvilleHousing
Drop column SaleDate, PropertyAddress, OwnerAddress


------------------------------------------------------------------

Select Bedrooms, COALESCE(Bedrooms, 0)
From PortfolioProject..NashvilleHousing

---------------------------------------------------------------------------
-- Calculating Price Per Acre
Select SalePrice, Acreage, Round(SalePrice/NULLIF(Acreage,0),3) As PricePerAcre
From PortfolioProject..NashvilleHousing

Alter Table PortfolioProject..NashvilleHousing
Add PricePerAcre float;

Update PortfolioProject..NashvilleHousing
Set PricePerAcre = Round(SalePrice/NULLIF(Acreage,0),3)

------------------------------------------------------------------
Select SalePrice
From PortfolioProject..NashvilleHousing
Where SalePrice > 1000000;

--------------------------------------------
-- Impute missing BuildingValue based on LandUse
With AvgBuildingValue As(
Select LandUse, Avg(BuildingValue) As AvgBuilding
From PortfolioProject..NashvilleHousing
Group BY LandUse, BuildingValue
)
Update PortfolioProject..NashvilleHousing
Set BuildingValue = AvgBuilding
From AvgBuildingValue
Where PortfolioProject..NashvilleHousing.LandUse = AvgBuildingValue.LandUse
And PortfolioProject..NashvilleHousing.BuildingValue IS NULL;

-------------------------------------------------------------------------------------
Select * From PortfolioProject..NashvilleHousing