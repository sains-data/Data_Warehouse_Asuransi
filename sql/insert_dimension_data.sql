
INSERT INTO DimRegion (RegionName)
SELECT DISTINCT region
FROM Staging_InsuranceData
WHERE region IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM DimRegion WHERE RegionName = Staging_InsuranceData.region);

INSERT INTO DimChildren (NumberOfChildren, ChildrenGroup)
SELECT DISTINCT
    children AS NumberOfChildren,
    CASE
        WHEN children = 0 THEN '0 Anak'
        WHEN children >= 1 AND children <= 2 THEN '1-2 Anak'
        WHEN children >= 3 THEN '3+ Anak'
        ELSE 'Tidak Diketahui' -- Opsional, jika ada nilai null atau aneh
    END AS ChildrenGroup
FROM Staging_InsuranceData
WHERE children IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM DimChildren
    WHERE NumberOfChildren = Staging_InsuranceData.children
      AND ChildrenGroup = CASE
                            WHEN Staging_InsuranceData.children = 0 THEN '0 Anak'
                            WHEN Staging_InsuranceData.children >= 1 AND Staging_InsuranceData.children <= 2 THEN '1-2 Anak'
                            WHEN Staging_InsuranceData.children >= 3 THEN '3+ Anak'
                            ELSE 'Tidak Diketahui'
                          END
  );

INSERT INTO DimBMI (BMI_Value, BMI_Category)
SELECT DISTINCT
    bmi AS BMI_Value,
    CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi >= 18.5 AND bmi < 25 THEN 'Normal'
        WHEN bmi >= 25 AND bmi < 30 THEN 'Overweight'
        WHEN bmi >= 30 THEN 'Obese'
        ELSE 'Tidak Diketahui' -- Opsional
    END AS BMI_Category
FROM Staging_InsuranceData
WHERE bmi IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM DimBMI
    WHERE BMI_Value = Staging_InsuranceData.bmi
      AND BMI_Category = CASE
                            WHEN Staging_InsuranceData.bmi < 18.5 THEN 'Underweight'
                            WHEN Staging_InsuranceData.bmi >= 18.5 AND Staging_InsuranceData.bmi < 25 THEN 'Normal'
                            WHEN Staging_InsuranceData.bmi >= 25 AND Staging_InsuranceData.bmi < 30 THEN 'Overweight'
                            WHEN Staging_InsuranceData.bmi >= 30 THEN 'Obese'
                            ELSE 'Tidak Diketahui'
                         END
  );

INSERT INTO DimCustomer (Age, Sex, Smoker, AgeGroup)
SELECT DISTINCT
    age,
    sex,
    smoker,
    CASE
        WHEN age <= 29 THEN 'Remaja' 
        WHEN age > 29 AND age <= 54 THEN 'Dewasa' 
        WHEN age > 54 THEN 'Lansia' 
        ELSE 'Tidak Diketahui' 
    END AS AgeGroup
FROM Staging_InsuranceData
WHERE age IS NOT NULL AND sex IS NOT NULL AND smoker IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM DimCustomer dc
    WHERE dc.Age = Staging_InsuranceData.age
      AND dc.Sex = Staging_InsuranceData.sex
      AND dc.Smoker = Staging_InsuranceData.smoker
      AND dc.AgeGroup = CASE
                          WHEN Staging_InsuranceData.age <= 29 THEN 'Remaja'
                          WHEN Staging_InsuranceData.age > 29 AND Staging_InsuranceData.age <= 54 THEN 'Dewasa'
                          WHEN Staging_InsuranceData.age > 54 THEN 'Lansia'
                          ELSE 'Tidak Diketahui'
                        END
  );
