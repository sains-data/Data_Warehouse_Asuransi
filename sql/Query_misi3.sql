-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2025 at 05:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `misi 3`
--

-- --------------------------------------------------------

--
-- Table structure for table `agregat_klaim_wilayah_bulanan`
--

CREATE TABLE `agregat_klaim_wilayah_bulanan` (
  `id_agregat` int(11) NOT NULL,
  `id_wilayah` varchar(10) DEFAULT NULL,
  `tahun` smallint(6) DEFAULT NULL,
  `bulan` tinyint(4) DEFAULT NULL,
  `jumlah_klaim` int(11) DEFAULT NULL,
  `rata_rata_klaim` decimal(10,2) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agregat_klaim_wilayah_bulanan`
--
ALTER TABLE `agregat_klaim_wilayah_bulanan`
  ADD PRIMARY KEY (`id_agregat`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agregat_klaim_wilayah_bulanan`
--
ALTER TABLE `agregat_klaim_wilayah_bulanan`
  MODIFY `id_agregat` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
