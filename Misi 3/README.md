# Data Warehouse untuk Industri Asuransi

## Deskripsi Proyek

Proyek ini merupakan implementasi data warehouse (DW) untuk industri asuransi oleh Kelompok 4 dari Program Studi Sains Data, Institut Teknologi Sumatera. Proyek ini mencakup:
- Perancangan skema konseptual, logikal, dan fisikal
- Pembuatan tabel dimensi dan fakta
- Penggunaan indexing untuk optimasi query
- Partisi data untuk efisiensi historis
- Visualisasi data dengan Power BI
Tujuannya adalah menyusun sistem penyimpanan data yang terstruktur dan efisien untuk mendukung **analisis risiko**, **evaluasi produk**, dan **peningkatan layanan pelanggan**.

## Struktur Data Warehouse

## Arsitektur Data Warehouse

### 1. Desain Konseptual (Star Schema)

#### Tabel Dimensi:
### 1. `dim_pelanggan`

| Kolom         | Tipe Data    | Deskripsi                                 |
|---------------|--------------|-------------------------------------------|
| id_pelanggan  | INT (PK)     | Kunci utama pelanggan                     |
| umur          | INT          | Umur pelanggan                            |
| jenis_kelamin | VARCHAR(10)  | Jenis kelamin (Laki-laki / Perempuan)     |
| bmi           | FLOAT        | Body Mass Index (Indeks Massa Tubuh)      |
| jumlah_anak   | INT          | Jumlah anak tanggungan                    |
| status_perokok| VARCHAR(10)  | Status merokok (Perokok / Tidak)          |

### 2. `dim_waktu`

| Kolom     | Tipe Data  | Deskripsi           |
|-----------|------------|---------------------|
| id_waktu  | INT (PK)   | ID waktu            |
| tanggal   | DATE       | Tanggal klaim       |
| bulan     | INT        | Bulan klaim (1-12)  |
| tahun     | INT        | Tahun klaim         |

### 3. `dim_wilayah`

| Kolom        | Tipe Data   | Deskripsi                    |
|--------------|-------------|------------------------------|
| id_wilayah   | INT (PK)    | ID unik wilayah              |
| nama_wilayah | VARCHAR(50) | Nama wilayah (kota/provinsi) |

### 4. `dim_bmi`

| Kolom         | Tipe Data   | Deskripsi                                  |
|---------------|-------------|--------------------------------------------|
| id_bmi        | INT (PK)    | ID kategori BMI                            |
| kategori_bmi  | VARCHAR(20) | Kategori BMI (Underweight, Normal, dll.)   |
| range_bmi     | VARCHAR(20) | Rentang nilai BMI, misal "18.5–24.9"       |

### 5. `dim_children`

| Kolom        | Tipe Data | Deskripsi                         |
|--------------|-----------|-----------------------------------|
| id_children  | INT (PK)  | ID entitas jumlah anak            |
| jumlah_anak  | INT       | Jumlah anak tanggungan pelanggan  |


## 🔶 Tabel Fakta

### `fact_klaim`

| Kolom        | Tipe Data | Deskripsi                                      |
|--------------|-----------|------------------------------------------------|
| id_fakta     | INT (PK)  | Kunci utama klaim                              |
| id_pelanggan | INT (FK)  | Referensi ke `dim_pelanggan`                   |
| id_waktu     | INT (FK)  | Referensi ke `dim_waktu`                       |
| id_wilayah   | INT (FK)  | Referensi ke `dim_wilayah`                     |
| biaya_klaim  | FLOAT     | Biaya medis klaim                              |

#### Skema:
Menggunakan **Star Schema** agar:
- Sederhana dan mudah dipahami
- Efisien untuk analisis agregat (klaim per bulan, per wilayah, dll)
- Mudah dikembangkan dan dikelola

---

### 2. Desain Logikal dan Fisikal

#### Indexing:
- **Primary key index** pada semua ID utama
- **Foreign key index** untuk mempercepat join antar tabel
- **Bitmap index** untuk kolom dengan sedikit kategori (seperti status perokok, jenis kelamin)
- **Composite index** pada kombinasi kolom seperti `(id_pelanggan, id_waktu)` untuk query agregasi berulang

#### Storage Layer:
- **Staging Layer**: Menyimpan data mentah dari `insurance_with_random_dates.csv`
- **Warehouse Layer**: Menyimpan data terstruktur dalam bentuk tabel fakta dan dimensi (row-store)
- **Presentation Layer**: Visualisasi data menggunakan Power BI (`.pbix`) untuk dashboard interaktif

---

### 3. Optimasi Analitik

#### Partitioning:
- **fact_klaim** dibagi berdasarkan tahun (`RANGE PARTITIONING`) untuk efisiensi akses data historis
- **dim_wilayah** dibagi berdasarkan wilayah (`LIST PARTITIONING`) untuk segmentasi geografis

#### Materialized View:
View yang menyimpan hasil agregasi untuk mempercepat query rutin:
- `mv_total_klaim_wilayah_bulanan`: Rangkuman klaim per bulan per wilayah
- `mv_klaim_per_status_perokok`: Agregasi klaim berdasarkan status merokok
- `mv_klaim_per_kategori_bmi`: Agregasi klaim berdasarkan kategori BMI

---

## 4. Tabel Agregat

Untuk menyimpan data ringkasan klaim agar query analitik seperti total dan rata-rata klaim bulanan lebih cepat dijalankan.

### Struktur Tabel:
- `id_agregat`, `id_wilayah`, `tahun`, `bulan`, `jumlah_klaim`, `rata_rata_klaim`, `last_updated`

### Proses ETL:
Data diisi secara berkala menggunakan job atau prosedur terjadwal, hasil dari query penggabungan antara tabel fakta dan dimensi waktu.

---

## Kesimpulan

Desain DW ini memungkinkan perusahaan asuransi untuk:
- Melakukan analisis risiko secara historis dan geografis
- Meningkatkan layanan berdasarkan pola klaim dan profil pelanggan
- Mengembangkan laporan dinamis dengan Power BI
- Menyimpan dan mengelola data dalam struktur optimal (Star Schema + Partisi + View)

Pengembangan lanjutan dapat mencakup:
- Penggunaan **column-store** untuk efisiensi storage
- **Kompresi data**
- **Otomatisasi pipeline ETL**

---

## Tools & Teknologi

- **SQL Server** – penyimpanan staging dan warehouse
- **Power BI** – visualisasi data
- **PostgreSQL** (alternatif indexing)
- **CSV Dataset** – data input (`insurance_with_random_dates.csv`)
