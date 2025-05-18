# 📊 Data Warehouse Asuransi Kesehatan – Misi 3

## 🎯 Tujuan Proyek
Membangun gudang data (**data warehouse**) menggunakan skema bintang (**star schema**) dan arsitektur **three-tier**, untuk menganalisis klaim asuransi kesehatan berdasarkan wilayah, status perokok, usia, dan waktu.

---

## 🔄 Alur Aliran Data
CSV (insurance_with_random_dates.csv)
↓
Staging (staging)
↓ [ETL SQL]
Dimensi & Fakta (Data Warehouse)
↓
Power BI (Visualisasi)

Data dikumpulkan dari file CSV dan dimasukkan ke SQL Server melalui tabel staging. Setelah transformasi dan pembersihan, data dimuat ke tabel fakta dan dimensi, lalu divisualisasikan menggunakan Power BI.

---

## 🏗️ Arsitektur Three-Tier

### 1. **Staging Layer**
- **Tabel**: `staging`
- **Sumber**: `insurance_with_random_dates.csv`
- **Fungsi**: menyimpan data mentah

### 2. **Data Warehouse Layer**
- **Tabel Fakta**:
  - `Fakta_Klaim_Asuransi`
- **Tabel Dimensi**:
  - `Dim_Pelanggan`, `Dim_Waktu`, `Dim_Wilayah`
- **Fungsi**: menyimpan data yang telah dibersihkan dan siap dianalisis

### 3. **Presentation Layer**
- **Alat**: Power BI Desktop
- **Fungsi**: menyajikan laporan analitik interaktif
- **Output**: Lihat `docs/dashboard BI.pdf`

---

## 🔁 ETL Pipeline (Extract, Transform, Load)

1. **Extract**: Ambil data dari file CSV
2. **Transform**: Bersihkan data, ubah format nilai, generate ID dengan CTE
3. **Load**:
   - Masukkan data ke `Dim_Pelanggan`, `Dim_Waktu`, `Dim_Wilayah`
   - Gabungkan ke `Fakta_Klaim_Asuransi`

📁 Lihat skrip ETL: [`sql/etl_script.sql`](sql/etl_script.sql)

---

## 📊 Visualisasi

Dashboard dibangun menggunakan Power BI Desktop dengan grafik:
- 📍 Jumlah klaim per wilayah
- 🚬 Rata-rata klaim berdasarkan status perokok
- 📈 Tren klaim bulanan
- 👥 Distribusi klaim berdasarkan usia dan kategori BMI

📎 Preview: [`docs/dashboard BI.pdf`](docs/dashboard%20BI.pdf)

---

## 🛠️ Tools dan Teknologi

| Kebutuhan      | Alat yang Digunakan           |
|----------------|-------------------------------|
| Database       | SQL Server Express + SSMS     |
| Visualisasi    | Power BI Desktop              |
| Data Source    | Dataset Kaggle (`insurance.csv`) |
| Transformasi   | SQL Query (`CTE`, `INSERT`)   |

---

## 👥 Anggota Kelompok 4 RA

- Evan Aprianto – 121450024  
- Kiwit Novitasari – 121450126  
- Ibrahim Al-Kahfi – 122450100  
- Meira Listyaningrum – 122450011  
- Salwa Farhanatussaidah – 122450055

---

## 🔗 Referensi

- [Dataset Kaggle – Insurance](https://www.kaggle.com/datasets/mirichoi0218/insurance)  
