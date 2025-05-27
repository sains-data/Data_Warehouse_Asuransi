## I. Ringkasan Proyek dan Latar Belakang

### 1.1 Ringkasan Proyek
Proyek ini bertujuan membangun sistem **data warehouse** untuk menganalisis biaya asuransi kesehatan berbasis dataset publik `insurance.csv` dari Kaggle. Pendekatan yang digunakan adalah **star schema** dengan proses **ETL** menggunakan SQL Server dan visualisasi menggunakan **Power BI**. Proyek ini didokumentasikan di [GitHub](https://github.com/sains-data/Data_Warehouse_Asuransi).

### 1.2 Latar Belakang
Industri asuransi membutuhkan integrasi data yang efektif untuk mendukung analisis seperti penetapan premi dan evaluasi produk. Tantangan utama adalah fragmentasi data dari berbagai sumber yang belum terstruktur.

---

## II. Tujuan dan Ruang Lingkup

### 2.1 Tujuan Sistem
* Menyediakan data terstruktur untuk analisis biaya premi.
* Membantu segmentasi pelanggan berdasarkan usia, status merokok, BMI, dan anak tanggungan.
* Menyediakan laporan dan dasbor interaktif bagi stakeholder.

### 2.2 Ruang Lingkup
* **Sumber data:** insurance.csv
* **Skema:** Star Schema
* **ETL tools:** SQL Server Management Studio (SSMS)
* **Visualisasi:** Power BI
* **Output:** Tabel dimensi & fakta, kueri SQL, dashboard

---

## III. Metode dan Pengembangan

### 3.1 Metodologi: Waterfall
Tahapan meliputi:
1. Spesifikasi kebutuhan
2. Desain konseptual, logikal, dan fisikal
3. Implementasi ETL dan visualisasi
4. Evaluasi akhir

### 3.2 Teknologi
* SQL Server (SSMS)
* Power BI
* GitHub

---

## IV. Analisis Kebutuhan dan Desain

### 4.1 Stakeholder & Tujuan Bisnis

| Stakeholder         | Tujuan                           |
| ------------------- | -------------------------------- |
| Manajer Keuangan    | Analisis distribusi biaya klaim  |
| Analis Data         | Segmentasi risiko pelanggan      |
| Manajer Operasional | Pantau anak tanggungan           |
| Eksekutif           | Penetapan premi & kebijakan      |
| Tim Pemasaran       | Strategi produk berdasar wilayah |

### 4.2 Fakta dan Dimensi
* **Fakta Utama:** Biaya asuransi (charges)
* **Dimensi:** Customer, Region, BMI, Children

---

## V. Desain Data Warehouse

### 5.1 Skema Bintang
* **Tabel Fakta:** `FactInsuranceCharges`
* **Dimensi:** `DimCustomer`, `DimRegion`, `DimBMI`, `DimChildren`

### 5.2 Desain Logikal
Contoh struktur `DimCustomer`:

```sql
CustomerSK INT PRIMARY KEY IDENTITY,
Age INT NOT NULL,
Sex VARCHAR(10) NOT NULL,
Smoker VARCHAR(3) NOT NULL,
AgeGroup VARCHAR(20) NOT NULL
