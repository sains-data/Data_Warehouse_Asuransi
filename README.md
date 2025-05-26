# 📊 Proyek Data Warehouse: Analisis Biaya Asuransi Kesehatan

Selamat datang di repository Proyek Data Warehouse untuk Analisis Biaya Asuransi Kesehatan! Proyek ini bertujuan untuk merancang, membangun, dan mengimplementasikan solusi data warehouse guna menganalisis faktor-faktor yang memengaruhi biaya asuransi kesehatan.

## 📜 Ringkasan Proyek dan Latar Belakang

Industri asuransi kesehatan sangat bergantung pada data untuk pengambilan keputusan, mulai dari penilaian risiko hingga penentuan premi yang kompetitif. Tantangan utama yang dihadapi adalah bagaimana mengintegrasikan dan menganalisis data pelanggan yang beragam secara efisien untuk mendapatkan wawasan yang dapat ditindaklanjuti. Proyek ini bertujuan untuk membangun data warehouse yang mengkonsolidasikan data pelanggan asuransi, memungkinkan analisis biaya yang komprehensif, segmentasi risiko yang lebih akurat, dan mendukung strategi bisnis berbasis data. Sumber data utama untuk proyek ini adalah dataset publik dari Kaggle yang berisi informasi demografis dan biaya asuransi pelanggan.

## 🎯 Tujuan dan Ruang Lingkup Sistem

**Tujuan Utama Sistem:**
* Menyediakan platform data terpusat dan terstruktur untuk analisis biaya klaim/premi asuransi kesehatan.
* Mendukung pembuatan laporan analitik dan dasbor interaktif untuk stakeholder seperti Manajer Keuangan, Analis Data, dan Tim Pemasaran.
* Memungkinkan segmentasi pelanggan berdasarkan berbagai faktor risiko seperti usia, status merokok, BMI, dan jumlah anak tanggungan.
* Membantu Eksekutif Perusahaan dalam menentukan strategi premi dan kebijakan berdasarkan profil pelanggan yang lebih akurat.

**Ruang Lingkup Sistem:**
* **Data Sumber:** Menggunakan dataset `insurance.csv` dari Kaggle yang berisi atribut `age`, `sex`, `bmi`, `children`, `smoker`, `region`, dan `charges`.
* **Model Data:** Mengimplementasikan model data dimensional dengan **Skema Bintang (Star Schema)**.
* **Proses ETL:** Ekstraksi data dari file CSV, transformasi (termasuk pembuatan atribut turunan seperti `AgeGroup`, `BMI_Category`, `ChildrenGroup`), dan pemuatan ke dalam data warehouse dilakukan menggunakan pendekatan SQL-based di SSMS, termasuk pemanfaatan fitur "Import Flat File" di SSMS untuk pemuatan awal ke tabel staging.
* **Output Analitik:** Kueri SQL analitik yang disimpan dalam file `analysis_queries.sql`  dan visualisasi/laporan yang dibuat menggunakan Power BI.

## ⚙️ Metodologi

Proyek ini dikembangkan menggunakan metodologi **Waterfall**, yang mencakup tahapan-tahapan beriku:
1.  **Misi 1:** Spesifikasi Kebutuhan (Analisis Kebutuhan Bisnis dan Teknis).
2.  **Misi 2:** Desain Konseptual (Perancangan skema multidimensional).
3.  **Misi 3:** Desain Logikal dan Fisikal (Detail struktur tabel, tipe data, indeks, dan arsitektur)[cite: 37].
4.  **Misi 4:** Implementasi, Pelaporan, dan Produksi (Pembuatan DW, ETL, kueri analitik, pelaporan, dan dokumentasi).

**Tools yang Digunakan:**
* **Database Server:** Microsoft SQL Server
* **Manajemen Database & Kueri:** SQL Server Management Studio (SSMS)
* **ETL (Extract, Transform, Load):** Pendekatan SQL-based menggunakan SSMS (termasuk SSMS Import Flat File Wizard untuk ekstraksi awal ke tabel staging).
* **Pelaporan & Visualisasi:** Microsoft Power BI
* **Version Control & Dokumentasi:** GitHub

## 🔍 Analisis Kebutuhan (Misi 1)

Analisis kebutuhan berfokus pada identifikasi stakeholder utama dan tujuan bisnis mereka dalam konteks analisis data asuransi kesehatan. Dari sini, ditentukan metrik (fakta) dan konteks (dimensi) yang krusial untuk data warehouse.

* **Stakeholder Utama & Tujuan Bisnis Kunci:**
    * **Manajer Keuangan:** Mengetahui distribusi dan rata-rata biaya klaim di tiap wilayah.
    * **Analis Data:** Membuat segmentasi pelanggan berdasarkan risiko (usia, perokok, BMI).
    * **Manajer Operasional:** Memantau jumlah anak tanggungan yang berpengaruh pada beban biaya.
    * **Eksekutif Perusahaan:** Menentukan strategi premi dan kebijakan berdasarkan profil pelanggan.
    * **Tim Pemasaran:** Menyesuaikan penawaran produk ke wilayah dan kelompok pelanggan tertentu.
* **Fakta Utama yang Diidentifikasi:** `Charges` (Biaya Asuransi).
* **Dimensi Utama yang Diidentifikasi:** `DimCustomer` (Usia, Jenis Kelamin, Status Merokok), `DimRegion` (Wilayah), `DimBMI` (Indeks Massa Tubuh), `DimChildren` (Jumlah Anak).

## 🏗️ Desain Data Warehouse (Misi 2 & 3)

Desain data warehouse ini mengadopsi **Skema Bintang (Star Schema)** untuk optimalisasi query analitik dan kemudahan pemahaman.

* **Desain Konseptual (Misi 2):**
    * **Tabel Fakta:** `FactInsuranceCharges` (menyimpan metrik `Charges`).
    * **Tabel Dimensi:**
        * `DimCustomer` (Atribut: `Age`, `Sex`, `Smoker`; Hierarki: `AgeGroup` ['Remaja', 'Dewasa', 'Lansia']).
        * `DimRegion` (Atribut: `RegionName`).
        * `DimBMI` (Atribut: `BMI_Value`; Hierarki: `BMI_Category` ['Underweight', 'Normal', 'Overweight', 'Obese']).
        * `DimChildren` (Atribut: `NumberOfChildren`; Hierarki: `ChildrenGroup` ['0 Anak', '1-2 Anak', '3+ Anak']).
* **Desain Logikal (Misi 3):**
    * Penentuan tipe data spesifik untuk setiap atribut (misalnya, `INT`, `VARCHAR`, `DECIMAL`).
    * Definisi Primary Keys (Surrogate Keys seperti `CustomerSK`, `RegionSK`, dll.) dan Foreign Keys untuk membangun relasi antara tabel fakta dan dimensi.
    * Penerapan constraints seperti `NOT NULL`.
* **Desain Fisikal (Misi 3):**
    * **Strategi Pengindeksan:**
        * Clustered Index pada Surrogate Key (PK) di setiap tabel dimensi.
        * Non-Clustered Index pada Foreign Key di tabel fakta.
        * Non-Clustered Index pada atribut yang sering difilter atau di-group pada tabel dimensi (misalnya `AgeGroup`, `BMI_Category`).
    * **Pertimbangan Penyimpanan:** Praktik standar SQL Server (pemisahan file data dan log jika di lingkungan produksi).
    * **Partisi Tabel:** Tidak diimplementasikan karena volume data sumber (1338 baris) relatif kecil.

**Arsitektur Sistem:** Menggunakan arsitektur **Three-Tier Architecture** (Sumber Data & ETL -> Server Data Warehouse -> Alat Analitik & Pelaporan).

Skrip DDL (Data Definition Language) untuk pembuatan tabel dan indeks dapat dilihat di:
* [`sql_scripts/create_tables.sql`](sql_scripts/create_tables.sql)

## 🛠️ Proses Implementasi (Misi 4)

Implementasi data warehouse dilakukan dengan langkah-langkah berikut:
1.  **Pembuatan Skema Database:** Menjalankan skrip DDL `create_tables.sql` di SSMS untuk membuat tabel fakta, dimensi, relasi, dan indeks di database.
2.  **Proses ETL (SQL-based):**
    * **Pembuatan Tabel Staging:** Tabel `Staging_InsuranceData` dibuat di SQL Server untuk menampung data mentah.
    * **Ekstraksi & Pemuatan Awal ke Staging:** Data dari `insurance.csv` dimuat ke `Staging_InsuranceData` menggunakan fitur "Import Flat File" di SSMS.
    * **Transformasi & Pemuatan ke Dimensi:** Skrip SQL (`insert_dimension_data.sql`) digunakan untuk:
        * Mengambil data unik dari `Staging_InsuranceData`.
        * Menurunkan atribut hierarki (`AgeGroup`, `BMI_Category`, `ChildrenGroup`) menggunakan logika `CASE`.
        * Mengisi tabel `DimCustomer`, `DimRegion`, `DimBMI`, dan `DimChildren`, dengan Surrogate Keys yang digenerate secara otomatis (`IDENTITY`).
    * **Transformasi & Pemuatan ke Tabel Fakta:** Skrip SQL (`insert_fact_data.sql`) digunakan untuk:
        * Melakukan `JOIN` antara `Staging_InsuranceData` dengan tabel-tabel dimensi untuk melakukan lookup dan mendapatkan Surrogate Keys yang sesuai.
        * Mengisi tabel `FactInsuranceCharges` dengan metrik `Charges` dan Foreign Keys yang telah didapatkan.
    * Skrip DML untuk pengisian data:
        * [`sql_scripts/insert_dimension_data.sql`](sql_scripts/insert_dimension_data.sql)
        * [`sql_scripts/insert_fact_data.sql`](sql_scripts/insert_fact_data.sql)
3.  **Pembuatan Kueri Analitik:** Mengembangkan dan menjalankan kueri SQL (`analysis_queries.sql`) untuk melakukan analisis terhadap data di dalam data warehouse.
    * Kumpulan kueri analitik: [`sql_scripts/analysis_queries.sql`](sql_scripts/analysis_queries.sql)

## ✨ Hasil Implementasi

Data warehouse yang telah diimplementasikan berhasil menyediakan platform terstruktur untuk analisis data biaya asuransi. Data dari sumber telah berhasil dimuat dan ditransformasi sesuai dengan desain.

* **Tampilan Sistem/Visualisasi (Contoh menggunakan Power BI):**
    ![Dasbor Power BI - Penjualan per Wilayah(images/dashboard_biaya_asuransi.jpg)
    * ➡️ *[Sertakan beberapa screenshot menarik dari dasbor atau laporan Power BI yang telah Anda buat. Misalnya: "Visualisasi Total Biaya per Wilayah", "Distribusi Pelanggan berdasarkan Kategori BMI dan Status Merokok".
* **Fungsionalitas Data Warehouse yang Tercapai:**
    * Kemampuan untuk melakukan query agregat untuk menganalisis biaya (`Charges`).
    * Kemampuan untuk melakukan segmentasi pelanggan berdasarkan demografi, wilayah, profil BMI, dan jumlah anak.
    * Data telah terintegrasi dan siap untuk mendukung pembuatan laporan analitik.
* **Contoh Output Kueri Analitik:**
    * ➡️ *[Contoh: "Berdasarkan kueri analisis, wilayah 'XYZ' memiliki total biaya tertinggi, sedangkan kelompok usia 'ABC' memiliki rata-rata biaya terendah." Atau tampilkan cuplikan hasil dari salah satu kueri di `analysis_queries.sql`]*

## 👥 Tim Proyek

Proyek ini dikerjakan oleh **Kelompok 4**:

* Evan Aprianto (121450024)
* Kiwit Novitasari (121450126)
* Ibrahin Al-Kahfi (122450100)
* Meira Listyaningrum (122450011)
* Salwa Farhanatussaidah (122450055)

---

**Dataset Sumber:**
* Dataset Asuransi (Insurance.csv) diambil dari: [Kaggle: Medical Cost Personal Datasets](https://www.kaggle.com/datasets/mirichoi0218/insurance)

**Struktur Repository:**
* `/sql_scripts/`: Berisi semua skrip SQL (DDL, DML, Kueri Analitik).
* `/data/`: Berisi dataset sumber `insurance.csv`.
* `/docs/`: Berisi laporan-laporan proyek per misi.
* `/images/`: (Jika ada) Berisi gambar dan screenshot untuk dokumentasi.

---
