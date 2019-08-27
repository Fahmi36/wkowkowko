-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 27, 2019 at 05:52 AM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pelayanan`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(60) NOT NULL,
  `level` tinyint(1) NOT NULL COMMENT '1 = Superadmin, 2 = Back Office',
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pemohon`
--

CREATE TABLE `pemohon` (
  `id` int(11) NOT NULL,
  `nama_pemohon` varchar(100) NOT NULL COMMENT 'Nama pemohon/nama perusahaan',
  `status_pemohon` tinyint(1) NOT NULL COMMENT '1 = Perorangan, 2 = Perusahaan, 3 = Pemerintahan/BUMN/BUMD',
  `no_identitas` varchar(45) NOT NULL,
  `jenis_identitas` tinyint(1) NOT NULL COMMENT '1 = NIK, 2 = NPWP Perorangan, 3 = NPWP Perusahaan, 4 = No Induk Pegawai',
  `dirut_perusahaan` varchar(100) DEFAULT NULL,
  `npwp_dirut` varchar(45) DEFAULT NULL,
  `email` varchar(70) NOT NULL,
  `no_telp` varchar(14) NOT NULL,
  `status_kepengurusan` tinyint(1) NOT NULL COMMENT '1 = Mengurus Sendiri, 2 = Tidak Mengurus Sendiri',
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `permohonan`
--

CREATE TABLE `permohonan` (
  `id` int(11) NOT NULL,
  `id_pemohon` int(11) NOT NULL,
  `id_tujuan_izin` int(11) NOT NULL,
  `status_izin` tinyint(1) NOT NULL COMMENT '1 = Izin Baru, 2 = Sedang diproses',
  `token` varchar(45) NOT NULL,
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tujuan_izin`
--

CREATE TABLE `tujuan_izin` (
  `id` int(11) NOT NULL,
  `tujuan` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tujuan_izin`
--

INSERT INTO `tujuan_izin` (`id`, `tujuan`) VALUES
(1, 'Mengembangkan Kawasan'),
(2, 'Membangun Gedung/Bangunan'),
(3, 'Membangun Prasarana/Infrastruktur'),
(4, 'Berusaha/Beraktivitas/Berkegiatan/Operasional'),
(5, 'Administrasi Keprofesian/Kependudukan');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pemohon`
--
ALTER TABLE `pemohon`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permohonan`
--
ALTER TABLE `permohonan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tujuan_izin`
--
ALTER TABLE `tujuan_izin`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pemohon`
--
ALTER TABLE `pemohon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permohonan`
--
ALTER TABLE `permohonan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tujuan_izin`
--
ALTER TABLE `tujuan_izin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
