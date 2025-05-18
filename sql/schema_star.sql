-- Tabel Dimensi

CREATE TABLE Dim_Waktu (
    ID_Waktu INT PRIMARY KEY,
    Tanggal DATE,
    Bulan INT,
    Kuartal INT,
    Tahun INT
);

CREATE TABLE Dim_Pelanggan (
    ID_Pelanggan INT PRIMARY KEY,
    Usia INT,
    Jenis_Kelamin VARCHAR(10),
    Status_Perokok VARCHAR(10)
);

CREATE TABLE Dim_Wilayah (
    ID_Wilayah INT PRIMARY KEY,
    Nama_Wilayah VARCHAR(50)
);

-- Tabel Fakta

CREATE TABLE Fakta_Klaim_Asuransi (
    ID_Klaim INT PRIMARY KEY,
    ID_Pelanggan INT,
    ID_Waktu INT,
    ID_Wilayah INT,
    Jumlah_Anak INT,
    BMI DECIMAL(5,2),
    Total_Klaim DECIMAL(12,2),
    FOREIGN KEY (ID_Pelanggan) REFERENCES Dim_Pelanggan(ID_Pelanggan),
    FOREIGN KEY (ID_Waktu) REFERENCES Dim_Waktu(ID_Waktu),
    FOREIGN KEY (ID_Wilayah) REFERENCES Dim_Wilayah(ID_Wilayah)
);



