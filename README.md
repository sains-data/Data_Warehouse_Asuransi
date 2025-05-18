# 📊 Data Warehouse Asuransi Kesehatan – Misi 3

## 🎯 Tujuan Proyek
Membangun gudang data (data warehouse) menggunakan skema bintang (**star schema**) dan arsitektur **three-tier**, untuk menganalisis klaim asuransi kesehatan berdasarkan wilayah, status perokok, usia, dan waktu.

## 🏗️ Arsitektur Three-Tier
1. **Staging Area**  
   - Tabel: `staging`  
   - Sumber: file CSV (`insurance_with_random_dates.csv`)  
   - Tujuan: menyimpan data mentah dari file eksternal

2. **Data Warehouse Layer**  
   - Tabel fakta dan dimensi dalam skema bintang:
     - `Fakta_Klaim_Asuransi`
     - `Dim_Pelanggan`, `Dim_Waktu`, `Dim_Wilayah`

3. **Presentation Layer**  
   - Alat: Power BI Desktop  
   - Menampilkan dashboard analitik klaim asuransi (disimpan di `docs/dashboard BI.pdf`)

## 📦 Struktur Repository

├── data/
│ └── insurance_with_random_dates.csv
│
├── docs/
│ ├── dashboard BI.pdf
│ └── star_schema_diagram.png
│
├── sql/
│ ├── etl_script.sql
│ ├── schema_star.sql
│ └── staging.sql
│
└── README.md


- `data/` – Dataset hasil preprocessing dengan kolom `tanggal_klaim`
- `docs/` – Laporan dashboard Power BI & diagram skema bintang
- `sql/` – Skrip SQL:
  - `staging.sql`: membuat tabel staging
  - `schema_star.sql`: membuat tabel dimensi & fakta
  - `etl_script.sql`: ETL dari staging ke data warehouse

## 🔁 Proses ETL

1. Dataset asuransi (`insurance.csv`) ditambahkan kolom `tanggal_klaim`
2. Data dimasukkan ke SQL Server ke dalam `staging`
3. Data dibersihkan dan diolah ke dalam:
   - `Dim_Pelanggan` (dari kolom age, sex, smoker)
   - `Dim_Wilayah` (dari region)
   - `Dim_Waktu` (dari tanggal_klaim)
   - `Fakta_Klaim_Asuransi` (menggabungkan semua dimensi)

ETL dilakukan dengan query `WITH CTE` dan `INSERT INTO` yang terdokumentasi dalam `etl_script.sql`.

## 📊 Visualisasi

Visualisasi dibuat menggunakan Power BI Desktop:
- Jumlah klaim per wilayah
- Rata-rata klaim per status perokok
- Tren klaim bulanan
- Distribusi klaim berdasarkan usia dan kategori BMI

📎 Lihat hasil dashboard di `docs/dashboard BI.pdf`

## 🛠️ Tools dan Teknologi

| Tujuan        | Alat yang Digunakan           |
|---------------|-------------------------------|
| Database      | SQL Server Express + SSMS     |
| Visualisasi   | Power BI Desktop              |
| Data Source   | CSV dataset dari Kaggle       |
| Transformasi  | SQL query (CTE + Insert)      |

## 👥 Anggota Kelompok

- Evan Aprianto – 121450024  
- Kiwit Novitasari – 121450126  
- Ibrahim Al-Kahfi – 122450100  
- Meira Listyaningrum – 122450011  
- Salwa Farhanatussaidah – 122450055

## 🔗 Referensi

- [Dataset Kaggle – Insurance](https://www.kaggle.com/datasets/mirichoi0218/insurance)  
