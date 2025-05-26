
INSERT INTO FactInsuranceCharges (
    Charges,
    CustomerSK,
    RegionSK,
    BMISK,
    ChildrenSK
)
SELECT
    s.charges,
    dc.CustomerSK,
    dr.RegionSK,
    db.BMISK,
    dch.ChildrenSK
FROM
    Staging_InsuranceData s
JOIN
    DimCustomer dc ON s.age = dc.Age
                   AND s.sex = dc.Sex
                   AND s.smoker = dc.Smoker
                   AND dc.AgeGroup = CASE -- Pastikan logika AgeGroup sama dengan saat mengisi DimCustomer
                                       WHEN s.age <= 29 THEN 'Remaja'
                                       WHEN s.age > 29 AND s.age <= 54 THEN 'Dewasa'
                                       WHEN s.age > 54 THEN 'Lansia'
                                       ELSE 'Tidak Diketahui'
                                   END
JOIN
    DimRegion dr ON s.region = dr.RegionName
JOIN
    DimBMI db ON s.bmi = db.BMI_Value
               AND db.BMI_Category = CASE -- Pastikan logika BMI_Category sama
                                         WHEN s.bmi < 18.5 THEN 'Underweight'
                                         WHEN s.bmi >= 18.5 AND s.bmi < 25 THEN 'Normal'
                                         WHEN s.bmi >= 25 AND s.bmi < 30 THEN 'Overweight'
                                         WHEN s.bmi >= 30 THEN 'Obese'
                                         ELSE 'Tidak Diketahui'
                                     END
JOIN
    DimChildren dch ON s.children = dch.NumberOfChildren
                     AND dch.ChildrenGroup = CASE -- Pastikan logika ChildrenGroup sama
                                               WHEN s.children = 0 THEN '0 Anak'
                                               WHEN s.children >= 1 AND s.children <= 2 THEN '1-2 Anak'
                                               WHEN s.children >= 3 THEN '3+ Anak'
                                               ELSE 'Tidak Diketahui'
                                           END;