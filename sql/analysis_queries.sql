-- =================================================================
-- Contoh Kueri Analitik
-- Data Warehouse Asuransi Kesehatan
-- =================================================================

-- 1. Total Biaya (Charges) per Wilayah (Region)
SELECT
    dr.RegionName,
    SUM(fic.Charges) AS TotalCharges
FROM
    FactInsuranceCharges fic
JOIN
    DimRegion dr ON fic.RegionSK = dr.RegionSK
GROUP BY
    dr.RegionName
ORDER BY
    TotalCharges DESC;
GO

-- 2. Rata-rata Biaya (Charges) per Kelompok Usia (AgeGroup)
SELECT
    dc.AgeGroup,
    AVG(fic.Charges) AS AverageCharges
FROM
    FactInsuranceCharges fic
JOIN
    DimCustomer dc ON fic.CustomerSK = dc.CustomerSK
GROUP BY
    dc.AgeGroup
ORDER BY
    dc.AgeGroup;
GO

-- 3. Jumlah Pelanggan dan Total Biaya (Charges) per Kategori BMI dan Status Merokok
SELECT
    db.BMI_Category,
    dc.Smoker,
    COUNT(DISTINCT fic.CustomerSK) AS NumberOfCustomers,
    SUM(fic.Charges) AS TotalCharges,
    AVG(fic.Charges) AS AverageChargesPerCustomer
FROM
    FactInsuranceCharges fic
JOIN
    DimBMI db ON fic.BMISK = db.BMISK
JOIN
    DimCustomer dc ON fic.CustomerSK = dc.CustomerSK
GROUP BY
    db.BMI_Category,
    dc.Smoker
ORDER BY
    db.BMI_Category,
    dc.Smoker;
GO

-- 4. Distribusi Biaya berdasarkan Jumlah Anak
SELECT
    dch.ChildrenGroup,
    SUM(fic.Charges) as TotalCharges,
    AVG(fic.Charges) as AverageCharges,
    COUNT(*) as NumberOfPolicies
FROM
    FactInsuranceCharges fic
JOIN
    DimChildren dch ON fic.ChildrenSK = dch.ChildrenSK
GROUP BY
    dch.ChildrenGroup
ORDER BY
    dch.ChildrenGroup;
GO