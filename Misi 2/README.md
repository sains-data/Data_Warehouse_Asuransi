---
# Misi 2 - Perancangan Skema Konseptual Data Warehouse

---

# 1. Ringkasan Kebutuhan dari Misi

Industri asuransi kesehatan menghadapi tantangan besar dalam mengelola dan menganalisis volume data yang terus meningkat, khususnya dalam konteks penentuan biaya premi dan penilaian risiko pelanggan. Untuk mendukung pengambilan keputusan yang akurat, dibutuhkan sebuah sistem *data warehouse* yang mampu mengintegrasikan berbagai atribut pelanggan ke dalam satu platform analitik terstruktur.

Proyek ini berfokus pada perancangan skema konseptual *data warehouse* yang mampu mendukung analisis biaya asuransi berdasarkan data pelanggan. Sistem ini bertujuan untuk menyediakan fondasi analitik bagi berbagai pihak dalam perusahaan, termasuk manajemen, analis, dan tim pemasaran.

# 2. Skema Konseptual Multidimensi

Model data dirancang menggunakan pendekatan **skema bintang (star schema)**. Struktur ini terdiri dari satu tabel fakta FactInsuranceCharges dan beberapa tabel dimensi yang merepresentasikan karakteristik pelanggan asuransi kesehatan.

**Tabel Fakta:**

- FactInsuranceCharges: Menyimpan nilai biaya asuransi Charges dan foreign key ke setiap tabel dimensi.

**Tabel Dimensi:**

- `DimCustomer`: Informasi usia, jenis kelamin, status merokok, dan kelompok usia AgeGroup.
- `DimRegion`: Wilayah geografis tempat tinggal pelanggan.
- `DimBMI`: Nilai BMI BMI_Value dan kategorinya BMI_Category.
- `DimChildren`: Jumlah anak tanggungan dan pengelompokan jumlah anak ChildrenGroup.

# 3. Penjelasan Tiap Komponen

- **FactInsuranceCharges**: Menyimpan data numerik utama Charges yang dianalisis serta foreign key untuk menghubungkan dengan setiap tabel dimensi.

- **DimCustomer**: Menjelaskan karakteristik pelanggan seperti usia, jenis kelamin, dan status merokok. Dilengkapi dengan kolom tambahan AgeGroup untuk segmentasi usia.

- **DimRegion**: Mewakili wilayah geografis pelanggan. Digunakan untuk menganalisis distribusi biaya berdasarkan lokasi.

- **DimBMI**: Berisi nilai BMI pelanggan dan kategori BMI (underweight, normal, overweight, obese). Kategori ini digunakan untuk mengelompokkan risiko kesehatan.

- **DimChildren**: Menyimpan jumlah anak tanggungan pelanggan dan kategori berdasarkan jumlah tersebut, seperti 0, 1–2, 3, yang dapat memengaruhi beban premi.

# 4. Justifikasi Desain Konseptual

Model multidimensi dengan skema bintang dipilih karena memberikan fleksibilitas dalam analisis dan performa kueri yang tinggi. Setiap dimensi memungkinkan pengguna melakukan eksplorasi data dengan mudah (drill-down, roll-up, slice, dice), serta mendukung penyusunan laporan dan visualisasi yang efisien.

Tabel fakta memusatkan metrik utama (Charges), sedangkan tabel dimensi menyediakan konteks yang relevan untuk analisis. Dengan struktur ini, perusahaan dapat mengevaluasi biaya berdasarkan profil pelanggan dan wilayah tanpa kompleksitas relasional yang tinggi.

# 5. Kesesuaian dengan Sumber Data

Sumber data berasal dari dataset publik insurance.csv dari Kaggle yang berisi informasi pelanggan asuransi kesehatan di AS. Dataset ini digunakan sebagai dasar perancangan skema.

| **Atribut Dataset** | **Penggunaan**                | **Keterangan**                                      |
|---------------------|-------------------------------|-----------------------------------------------------|
| `age`               | DimCustomer.Age               | Usia pelanggan, diklasifikasikan ke dalam AgeGroup |
| `sex`               | DimCustomer.Sex               | Jenis kelamin                                       |
| `smoker`            | DimCustomer.Smoker            | Status merokok                                      |
| `region`            | DimRegion.RegionName          | Wilayah geografis                                   |
| `bmi`               | DimBMI.BMI_Value              | Nilai BMI                                           |
| -                   | DimBMI.BMI_Category           | Kategori BMI (hasil transformasi)                   |
| `children`          | DimChildren.NumberOfChildren  | Jumlah anak tanggungan                              |
| -                   | DimChildren.ChildrenGroup     | Kelompok jumlah anak                                |
| `charges`           | FactInsuranceCharges.Charges  | Biaya asuransi (fakta utama yang dianalisis)       |

Dataset terdiri dari 1.338 baris, tidak memiliki data kosong, dan siap digunakan dalam proses ETL ke dalam struktur *data warehouse*.


