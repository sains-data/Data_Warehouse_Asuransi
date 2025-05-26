# Misi 1 – Pergudangan Data Asuransi  
## Perancangan Data Warehouse untuk Industri Asuransi Kesehatan

Repositori ini berisi perancangan dan analisis untuk sebuah data warehouse yang bertujuan untuk meningkatkan pengelolaan dan analisis data dalam industri asuransi kesehatan. Proyek ini berfokus pada penanganan tantangan dalam mengelola dan menganalisis data pelanggan secara efisien untuk mendukung pengambilan keputusan bisnis

---

## 1. Profil Industri dan Masalah Bisnis

Industri asuransi kesehatan sangat bergantung pada pengelolaan dan analisis data pelanggan yang efektif untuk pengambilan keputusan strategis. Data seperti usia pelanggan, status merokok, indeks massa tubuh (BMI), jumlah anak tanggungan, dan wilayah geografis sangat penting dalam proses penilaian risiko dan penetapan premi.

Masalah utama yang dihadapi perusahaan asuransi adalah bagaimana mengintegrasikan data dari berbagai sumber ke dalam satu platform yang terstruktur dan dapat digunakan untuk analisis mendalam. Untuk itu, diperlukan sebuah *data warehouse* yang mampu menyatukan informasi penting dan menyajikan data dalam bentuk yang mudah dianalisis oleh berbagai pihak.

---

## 2. Daftar Stakeholder dan Tujuan Bisnis

Berikut ini adalah stakeholder utama yang terlibat dan tujuan bisnis yang ingin dicapai melalui sistem *data warehouse*:

| **Stakeholder**         | **Tujuan Bisnis**                                                                 |
|-------------------------|-----------------------------------------------------------------------------------|
| **Manajer Keuangan**    | Mengetahui distribusi dan rata-rata biaya klaim di tiap wilayah.                 |
| **Analis Data**         | Melakukan segmentasi pelanggan berdasarkan risiko (usia, perokok, BMI).          |
| **Manajer Operasional** | Memantau pengaruh jumlah anak tanggungan terhadap beban biaya.                  |
| **Eksekutif Perusahaan**| Menentukan strategi premi dan kebijakan berdasarkan profil pelanggan.           |
| **Tim Pemasaran**       | Menyesuaikan penawaran produk ke wilayah dan kelompok pelanggan tertentu.        |

---

## 3. Fakta dan Dimensi

Struktur *data warehouse* dirancang menggunakan pendekatan **Skema Bintang (Star Schema)**. Skema ini digunakan untuk mempermudah analisis biaya asuransi berdasarkan karakteristik pelanggan. Perancangan ini sepenuhnya disesuaikan dengan struktur yang telah diimplementasikan pada Misi 4.


### Tabel Fakta

| **Nama Tabel**         | **Deskripsi**                                                                 |
|------------------------|-------------------------------------------------------------------------------|
| `FactInsuranceCharges` | Tabel pusat yang menyimpan data biaya asuransi (`charges`) dan foreign key ke setiap tabel dimensi. |

**Kolom:**
- `ChargesSK` (Primary Key)  
- `Charges`  
- `CustomerSK` (FK ke DimCustomer)  
- `RegionSK` (FK ke DimRegion)  
- `BMISK` (FK ke DimBMI)  
- `ChildrenSK` (FK ke DimChildren)

---

### Tabel Dimensi

| **Nama Tabel**   | **Kolom Utama**                                                      | **Deskripsi**                                                                 |
|------------------|----------------------------------------------------------------------|--------------------------------------------------------------------------------|
| `DimCustomer`    | `CustomerSK`, `Age`, `Sex`, `Smoker`, `AgeGroup`                    | Menyimpan informasi dasar pelanggan dan klasifikasi kelompok usia.            |
| `DimRegion`      | `RegionSK`, `RegionName`                                             | Menyimpan informasi wilayah geografis pelanggan.                              |
| `DimBMI`         | `BMISK`, `BMI_Value`, `BMI_Category`                                | Menyimpan nilai dan kategori indeks massa tubuh (BMI).                        |
| `DimChildren`    | `ChildrenSK`, `NumberOfChildren`, `ChildrenGroup`                   | Mencatat jumlah anak tanggungan pelanggan dan klasifikasinya.                |

## 4. Sumber Data & Metadata

Dataset yang digunakan dalam proyek ini bersumber dari Kaggle dengan nama `insurance.csv`. Dataset ini merupakan data publik yang berisi informasi pelanggan asuransi kesehatan di Amerika Serikat. Data ini mencakup atribut-atribut penting yang mencerminkan faktor risiko dan karakteristik demografis pelanggan yang memengaruhi biaya asuransi.

Dataset ini digunakan sebagai dasar dalam membangun skema konseptual dan melakukan proses ETL pada sistem data warehouse. Seluruh proses, mulai dari ekstraksi, transformasi, hingga pemuatan data ke dalam tabel staging dan dimensi dilakukan berdasarkan struktur data ini.

### Ringkasan Dataset

- **Jumlah Baris:** 1.338 entri
- **Sifat Data:** Bersih, tanpa nilai kosong
- **Format:** CSV (Comma-Separated Values)

### Atribut-Atribut Dataset

| **Atribut** | **Deskripsi**                                                                 |
|-------------|---------------------------------------------------------------------------------|
| `age`       | Usia pelanggan dalam satuan tahun.                                             |
| `sex`       | Jenis kelamin pelanggan (`male` atau `female`).                               |
| `bmi`       | Indeks Massa Tubuh pelanggan. Digunakan untuk mengukur risiko kesehatan.      |
| `children`  | Jumlah anak tanggungan pelanggan. Mempengaruhi beban biaya.                   |
| `smoker`    | Status merokok pelanggan (`yes` atau `no`).                                   |
| `region`    | Wilayah tempat tinggal pelanggan (`southeast`, `northwest`, dll).             |
| `charges`   | Biaya asuransi tahunan dalam dolar AS (nilai numerik utama untuk dianalisis). |

### Tujuan Penggunaan

Dataset ini digunakan untuk:

- Mengembangkan struktur *data warehouse* berbasis skema bintang.
- Mengisi tabel fakta dan dimensi melalui proses ETL.
- Menyediakan dasar bagi kueri analitik dan visualisasi biaya premi.
- Mendukung segmentasi pelanggan berdasarkan karakteristik risiko.

### Sumber Dataset

- Kaggle: [`https://www.kaggle.com/datasets/mirichoi0218/insurance`](https://www.kaggle.com/datasets/mirichoi0218/insurance)

---

Struktur ini memungkinkan analisis biaya asuransi berdasarkan berbagai faktor risiko yang relevan bagi perusahaan asuransi. Desain ini juga sepenuhnya telah direalisasikan dan diuji pada implementasi sistem Misi 4, termasuk proses ETL, pembuatan kueri analitik, dan visualisasi dalam Power BI.

