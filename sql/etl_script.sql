WITH WilayahCTE AS (
    SELECT DISTINCT region,
        ROW_NUMBER() OVER (ORDER BY region) AS ID_Wilayah
    FROM staging
)
INSERT INTO Dim_Wilayah (ID_Wilayah, Nama_Wilayah)
SELECT ID_Wilayah, region FROM WilayahCTE;

WITH PelangganCTE AS (
    SELECT DISTINCT age, sex, smoker,
        ROW_NUMBER() OVER (ORDER BY age, sex, smoker) AS ID_Pelanggan
    FROM staging
)
INSERT INTO Dim_Pelanggan (ID_Pelanggan, Usia, Jenis_Kelamin, Status_Perokok)
SELECT ID_Pelanggan, age, sex, smoker FROM PelangganCTE;

WITH WaktuCTE AS (
    SELECT DISTINCT tanggal_klaim,
        ROW_NUMBER() OVER (ORDER BY tanggal_klaim) AS ID_Waktu
    FROM staging
)
INSERT INTO Dim_Waktu (ID_Waktu, Tanggal, Bulan, Kuartal, Tahun)
SELECT 
    ID_Waktu,
    tanggal_klaim,
    MONTH(tanggal_klaim),
    DATEPART(QUARTER, tanggal_klaim),
    YEAR(tanggal_klaim)
FROM WaktuCTE;

WITH FaktaCTE AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY s.age, s.charges) AS ID_Klaim,
        p.ID_Pelanggan,
        w.ID_Waktu,
        r.ID_Wilayah,
        s.children AS Jumlah_Anak,
        s.bmi,
        s.charges AS Total_Klaim
    FROM staging s
    JOIN Dim_Pelanggan p
        ON s.age = p.Usia AND s.sex = p.Jenis_Kelamin AND s.smoker = p.Status_Perokok
    JOIN Dim_Waktu w
        ON s.tanggal_klaim = w.Tanggal
    JOIN Dim_Wilayah r
        ON s.region = r.Nama_Wilayah
)
INSERT INTO Fakta_Klaim_Asuransi (
    ID_Klaim, ID_Pelanggan, ID_Waktu, ID_Wilayah, Jumlah_Anak, BMI, Total_Klaim
)
SELECT ID_Klaim, ID_Pelanggan, ID_Waktu, ID_Wilayah, Jumlah_Anak, BMI, Total_Klaim FROM FaktaCTE;
