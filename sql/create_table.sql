-- -----------------------------------------------------
-- Tabel Dimensi: DimCustomer
-- -----------------------------------------------------
CREATE TABLE DimCustomer (
    CustomerSK INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    Age INT,
    Sex VARCHAR(10),
    Smoker VARCHAR(3),
    AgeGroup VARCHAR(20) 
);
GO

-- Indeks untuk DimCustomer 
CREATE NONCLUSTERED INDEX IX_DimCustomer_AgeGroup ON DimCustomer(AgeGroup);
GO
CREATE NONCLUSTERED INDEX IX_DimCustomer_Age ON DimCustomer(Age);
GO

-- -----------------------------------------------------
-- Tabel Dimensi: DimRegion
-- -----------------------------------------------------
CREATE TABLE DimRegion (
    RegionSK INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    RegionName VARCHAR(25)
);
GO

-- Indeks untuk DimRegion 
CREATE NONCLUSTERED INDEX IX_DimRegion_RegionName ON DimRegion(RegionName);
GO

-- -----------------------------------------------------
-- Tabel Dimensi: DimBMI
-- -----------------------------------------------------
CREATE TABLE DimBMI (
    BMISK INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    BMI_Value DECIMAL(5,2),
    BMI_Category VARCHAR(20) -- Atribut Turunan: Underweight, Normal, Overweight, Obese
);
GO

-- Indeks untuk DimBMI (Opsional, jika sering difilter berdasarkan BMI_Category)
CREATE NONCLUSTERED INDEX IX_DimBMI_BMI_Category ON DimBMI(BMI_Category);
GO

-- -----------------------------------------------------
-- Tabel Dimensi: DimChildren
-- -----------------------------------------------------
CREATE TABLE DimChildren (
    ChildrenSK INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    NumberOfChildren INT,
    ChildrenGroup VARCHAR(15) -- Atribut Turunan: 0 Anak, 1-2 Anak, 3+ Anak
);
GO

-- Indeks untuk DimChildren (Opsional, jika sering difilter berdasarkan ChildrenGroup)
CREATE NONCLUSTERED INDEX IX_DimChildren_ChildrenGroup ON DimChildren(ChildrenGroup);
GO

-- -----------------------------------------------------
-- Tabel Fakta: FactInsuranceCharges
-- -----------------------------------------------------
CREATE TABLE FactInsuranceCharges (
    ChargesSK BIGINT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key untuk Tabel Fakta
    Charges DECIMAL(10,2),
    CustomerSK INT NOT NULL,
    RegionSK INT NOT NULL,
    BMISK INT NOT NULL,
    ChildrenSK INT NOT NULL,

    -- Foreign Key Constraints
    CONSTRAINT FK_FactInsuranceCharges_DimCustomer FOREIGN KEY (CustomerSK) REFERENCES DimCustomer(CustomerSK),
    CONSTRAINT FK_FactInsuranceCharges_DimRegion FOREIGN KEY (RegionSK) REFERENCES DimRegion(RegionSK),
    CONSTRAINT FK_FactInsuranceCharges_DimBMI FOREIGN KEY (BMISK) REFERENCES DimBMI(BMISK),
    CONSTRAINT FK_FactInsuranceCharges_DimChildren FOREIGN KEY (ChildrenSK) REFERENCES DimChildren(ChildrenSK)
);
GO

-- Indeks untuk Foreign Keys di Tabel Fakta
CREATE NONCLUSTERED INDEX IX_FactInsuranceCharges_CustomerSK ON FactInsuranceCharges(CustomerSK);
GO
CREATE NONCLUSTERED INDEX IX_FactInsuranceCharges_RegionSK ON FactInsuranceCharges(RegionSK);
GO
CREATE NONCLUSTERED INDEX IX_FactInsuranceCharges_BMISK ON FactInsuranceCharges(BMISK);
GO
CREATE NONCLUSTERED INDEX IX_FactInsuranceCharges_ChildrenSK ON FactInsuranceCharges(ChildrenSK);
GO