-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 10, 2019 at 02:19 PM
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
-- Table structure for table `imb_spasial`
--

CREATE TABLE `imb_spasial` (
  `id` int(11) NOT NULL,
  `id_jenis_perizinan` tinyint(4) NOT NULL,
  `id_subzona` tinyint(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `imb_spasial`
--

INSERT INTO `imb_spasial` (`id`, `id_jenis_perizinan`, `id_subzona`) VALUES
(1, 97, 1),
(2, 97, 12),
(3, 99, 12);

-- --------------------------------------------------------

--
-- Table structure for table `imb_spasial_itbx`
--

CREATE TABLE `imb_spasial_itbx` (
  `id` int(11) NOT NULL,
  `id_imb_spasial` tinyint(6) NOT NULL,
  `status_itbx` varchar(2) NOT NULL COMMENT 'I, T, B, TB, X'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `imb_spasial_itbx`
--

INSERT INTO `imb_spasial_itbx` (`id`, `id_imb_spasial`, `status_itbx`) VALUES
(1, 1, 'X'),
(2, 2, 'B'),
(3, 3, 'B'),
(4, 3, 'B');

-- --------------------------------------------------------

--
-- Table structure for table `imb_spasial_itbx_detail`
--

CREATE TABLE `imb_spasial_itbx_detail` (
  `id` int(11) NOT NULL,
  `id_imb_spasial_itbx` tinyint(6) NOT NULL,
  `daftar_bangunan_diizinkan` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `imb_spasial_itbx_detail`
--

INSERT INTO `imb_spasial_itbx_detail` (`id`, `id_imb_spasial_itbx`, `daftar_bangunan_diizinkan`) VALUES
(1, 2, 'Rumah Sangat Kecil'),
(2, 2, 'Rumah Kecil');

-- --------------------------------------------------------

--
-- Table structure for table `imb_syarat_khusus`
--

CREATE TABLE `imb_syarat_khusus` (
  `id` int(11) NOT NULL,
  `id_jenis_perizinan` tinyint(4) NOT NULL,
  `no_persyaratan` tinyint(2) NOT NULL,
  `status_persyaratan` tinyint(1) NOT NULL COMMENT '0 = Terdetail (Data terstruktur, detail tambahan direlasikan ke tabel imb_syarat_khusus_detail), 1 = Utama',
  `persyaratan` varchar(300) NOT NULL,
  `urutan_persyaratan` tinyint(1) DEFAULT NULL COMMENT 'Untuk record dengan no_persyaratan sama',
  `keterangan_tambahan` varchar(300) DEFAULT NULL COMMENT 'Tata letak di paling bawah di setiap satu nomor persyaratan (ex : no 12 pada persyaratan khusus IMB A)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `imb_syarat_khusus`
--

INSERT INTO `imb_syarat_khusus` (`id`, `id_jenis_perizinan`, `no_persyaratan`, `status_persyaratan`, `persyaratan`, `urutan_persyaratan`, `keterangan_tambahan`) VALUES
(1, 97, 6, 0, 'Bukti Kepemilikan Tanah', NULL, NULL),
(2, 97, 7, 1, 'Bukti pembayaran Pajak Bumi dan Bangunan (PBB) tahun terakhir sebelum jatuh tempo (Fotokopi)', NULL, NULL),
(3, 97, 8, 1, 'Ketetapan Rencana Kota (KRK) Asli (minimal 3 set)', NULL, NULL),
(4, 97, 9, 0, 'Gambar Arsitektur', NULL, NULL),
(5, 97, 10, 1, 'IMB Terdahulu beserta gambar lampirannya (Fotokopi)', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `imb_syarat_khusus_detail`
--

CREATE TABLE `imb_syarat_khusus_detail` (
  `id` int(11) NOT NULL,
  `id_imb_syarat_khusus` tinyint(4) NOT NULL,
  `detail` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `imb_syarat_khusus_detail`
--

INSERT INTO `imb_syarat_khusus_detail` (`id`, `id_imb_syarat_khusus`, `detail`) VALUES
(1, 1, '//ptsp.atrbpn.go.id)  disertai  lampiran  gambar  situasi  lahan  yang  utuh  dan  jelas,  apabila terdapat perbedaan antara nama pemohon dengan yang tertera pada Sertipikat tanah maka dilampirkan  AJB  (Maksimal  2  kali  pergantian  kepemilikan),  atau  akta  perjanjian  kerjasama notarial atau sejenisnya.'),
(2, 1, 'surat girik harus dilengkapi dengan peta ukur untuk menunjukkan letak dan ukuran kavling dan hanya  dapat  dipergunakan  pada  permohonan  bangunan  gedung  rumah  tinggal  dan  harus melampirkan  surat  pernyataan  bahwa  tanah  yang  dikuasai  dan/atau  dimiliki  tidak  dalam sengketa dari pemohon diketahui oleh Lurah setempat (untuk penguasaan fisik tanah harus di tahun yang sama). (Fotokopi yang di legalisasi)'),
(3, 1, 'surat kavling dari Pemerintah Daerah melalui Walikota atau instansi lain yang ditunjuk Gubernur dan diketahui oleh instansi yang berwenang dan harus melampirkan surat pernyataan bahwa tanah yang dikuasai dan/atau dimiliki tidak dalam sengketa dari pemohon diketahui oleh Lurah setempat.'),
(4, 1, 'Surat Keputusan Pemberian Hak Penggunaan Atas Tanah oleh pejabat yang berwenang dari instansi pemerintah yang menguasai tanah tersebut'),
(5, 1, 'Surat Persetujuan/Penunjukan Gubernur/Walikota untuk bangunan gedung bersifat sementara, bangunan gedung di atas/bawah prasarana, bangunan gedung di atas/bawah air atau bangunan gedung khusus dan penampungan sementara'),
(6, 1, 'Rekomendasi dari Kantor Wilayah Badan Pertanahan Nasional Provinsi DKI Jakarta atau Kantor Pertanahan setempat'),
(7, 1, 'Surat Pernyataan dari instansi pemerintah khusus untuk bangunan gedung milik Pemerintah'),
(8, 1, 'Surat Keterangan Aset dari BPAD Provinsi DKIJakarta atau KIB (Kartu inventaris barang) apabila lahan yang dimiliki tidak memiliki sertipikat tanah dan merupakan lahan milik Pemerintah Provinsi DKI Jakarta'),
(9, 1, 'Jika terdapat perbedaan identitas/alamat antara permohonan dengan bukti kepemilikan tanah, maka di lengkapi dengan surat keterangan lurah (PM.1)'),
(10, 1, 'Jika nama yang tertera pada bukti kepemilikan tanah sudah meninggal dunia, maka diperlukan surat Pernyataan Ahli Waris yang diketahui Lurah dan Camat (Fotokopi yang dilegalisasi lurah)'),
(11, 9, 'Dicetak sebanyak 5 set gambar arsitektur'),
(12, 9, 'Dicetak dengan ukuran minimal A3 untuk hardcopy'),
(13, 9, 'Dilampirkan dengan CD yang berisi softcopy gambar arsitektur'),
(14, 9, 'Terdiri atas gambar situasi, denah, tampak dua arah, potongan dua arah, detail sumur resapan air hujan (SRAH), pagar, instalasi pengolahan air limbah'),
(15, 9, 'Diberi kop gambar (ditandatangani pemohon, tertulis nama pemohon, lokasi, jenis bangunan, judul gambar, skala)');

-- --------------------------------------------------------

--
-- Table structure for table `imb_syarat_umum`
--

CREATE TABLE `imb_syarat_umum` (
  `id` int(11) NOT NULL,
  `no_persyaratan` tinyint(2) NOT NULL,
  `status_persyaratan` tinyint(1) NOT NULL COMMENT '0 = Terdetail (Data terstruktur, detail tambahan direlasikan ke tabel imb_syarat_umum_detail), 1 = Utama',
  `persyaratan` varchar(250) NOT NULL,
  `urutan_persyaratan` tinyint(1) DEFAULT NULL COMMENT 'Untuk record dengan no_persyaratan sama'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `imb_syarat_umum`
--

INSERT INTO `imb_syarat_umum` (`id`, `no_persyaratan`, `status_persyaratan`, `persyaratan`, `urutan_persyaratan`) VALUES
(1, 1, 1, 'Surat permohonan yang didalamnya terdapat pernyataan kebenaran dan keabsahan dokumen & data di atas kertas bermaterai Rp 6.000', NULL),
(2, 2, 1, 'Surat kuasa yang di tandatangani bersama jika nama yang tertera di sertifikat lebih dari 1 (satu)', NULL),
(3, 3, 0, 'Identitas Pemohon/Penangung Jawab', NULL),
(4, 4, 0, 'Jika dikuasakan', NULL),
(5, 5, 0, 'Jika Badan Hukum / Badan Usaha', 1),
(6, 5, 0, 'Jika Lembaga/ Kementrian/ SKPD/ BUMN / BUMD', 2);

-- --------------------------------------------------------

--
-- Table structure for table `imb_syarat_umum_detail`
--

CREATE TABLE `imb_syarat_umum_detail` (
  `id` int(11) NOT NULL,
  `id_imb_syarat_umum` tinyint(2) NOT NULL,
  `detail` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `imb_syarat_umum_detail`
--

INSERT INTO `imb_syarat_umum_detail` (`id`, `id_imb_syarat_umum`, `detail`) VALUES
(1, 3, 'WNI :  Kartu Tanda Penduduk (KTP) dan NPWP (Fotokopi)'),
(2, 3, 'WNA : Kartu Kartu Izin Tinggal Terbatas (KITAS) atau VISA / Paspor (Fotokopi)'),
(3, 4, 'Surat kuasa di atas kertas bermaterai RP 6.000 dan KTP orang yang diberi kuasa'),
(4, 5, 'Akta pendirian dan perubahan (Kantor Pusat dan Kantor Cabang, jika ada) (Fotokopi)'),
(5, 5, 'SK pengesahan pendirian dan perubahan (Fotokopi) yang dikeluarkan oleh Kemenkunham, jika PT dan Yayasan'),
(6, 5, 'SK pengesahan pendirian dan perubahan (Fotokopi) yang dikeluarkan oleh Kementrian, jika Koperasi'),
(7, 5, 'SK pengesahan pendirian dan perubahan (Fotokopi) yang dikeluarkan oleh Pengadilan Negeri, jika CV'),
(8, 5, 'NPWP Badan Hukum (Fotokopi)'),
(9, 6, 'Surat Keputusan (SK) Pendirian Badan Usaha dari Instansi Pemerintah apabila merupakan BUMN/BUMD'),
(10, 6, 'SK Pengangkatan penanggung jawab dari SKPD/Kementrian');

-- --------------------------------------------------------

--
-- Table structure for table `imb_umum`
--

CREATE TABLE `imb_umum` (
  `id` int(11) NOT NULL,
  `id_jenis_perizinan` tinyint(4) NOT NULL,
  `fungsi` tinyint(1) NOT NULL COMMENT '1 = Rumah Tinggal, 2 = Non Rumah Tinggal',
  `luas_tanah` double DEFAULT NULL,
  `perkiraan_luas` varchar(3) DEFAULT NULL,
  `jumlah_lantai` tinyint(3) DEFAULT NULL,
  `perkiraan_lantai` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `imb_umum`
--

INSERT INTO `imb_umum` (`id`, `id_jenis_perizinan`, `fungsi`, `luas_tanah`, `perkiraan_luas`, `jumlah_lantai`, `perkiraan_lantai`) VALUES
(1, 98, 2, NULL, NULL, 8, '>'),
(2, 99, 2, NULL, NULL, 8, '< ='),
(3, 96, 1, 100, '> =', NULL, NULL),
(4, 97, 1, 100, '<', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pemohon_data_bangunan`
--

CREATE TABLE `pemohon_data_bangunan` (
  `id` int(11) NOT NULL,
  `id_pemohon` int(11) NOT NULL,
  `status_bangunan` tinyint(1) NOT NULL COMMENT '1 = Rencana, 2 = Sudah Ada Bangunan',
  `fungsi_bangunan` tinyint(1) NOT NULL COMMENT '0 = Non Rumah Tinggal, 1 = Rumah Tinggal',
  `jumlah_lantai` tinyint(3) NOT NULL,
  `tahun_rencana_penggunaan` date NOT NULL,
  `jumlah_basement` tinyint(2) NOT NULL,
  `luas_basement` double NOT NULL,
  `luas_keseluruhan_lantai` double NOT NULL,
  `no_reg_bangunan` varchar(45) NOT NULL,
  `form_krk` tinyint(1) NOT NULL COMMENT '0 = Tidak Ada, 1 = Ada',
  `form_imb` tinyint(1) NOT NULL COMMENT '0 = Tidak Ada, 1 = Ada',
  `form_slf` tinyint(1) NOT NULL COMMENT '0 = Tidak Ada, 1 = Ada',
  `form_sippt` tinyint(1) NOT NULL COMMENT '0 = Tidak Ada, 1 = Ada',
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pemohon_data_bangunan_renovasi`
--

CREATE TABLE `pemohon_data_bangunan_renovasi` (
  `id` int(11) NOT NULL,
  `id_pemohon_data_bangunan` int(11) NOT NULL,
  `fungsi` tinyint(1) NOT NULL COMMENT '0 = Non Rumah Tinggal, 1 = Rumah Tinggal',
  `jumlah_lantai` tinyint(3) NOT NULL,
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pemohon_data_diri`
--

CREATE TABLE `pemohon_data_diri` (
  `id` int(11) NOT NULL,
  `nama_pemohon` varchar(100) NOT NULL COMMENT 'Nama pemohon/nama perusahaan',
  `tipe_pemohon` tinyint(1) NOT NULL COMMENT '1 = Perseorangan, 2 = Perusahaan, 3 = Pemerintahan/BUMN/BUMD, 4 = Yayasan/Lembaga',
  `no_identitas` varchar(45) NOT NULL,
  `jenis_identitas` tinyint(1) NOT NULL COMMENT '1 = NIK, 2 = NPWP Perorangan, 3 = NPWP Perusahaan, 4 = No Induk Pegawai',
  `dirut_perusahaan` varchar(100) DEFAULT NULL,
  `npwp_dirut` varchar(45) DEFAULT NULL,
  `email` varchar(70) NOT NULL,
  `no_telp` varchar(14) NOT NULL,
  `status_kepengurusan` tinyint(1) NOT NULL COMMENT '1 = Mengurus Sendiri, 2 = Dikuasakan',
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pemohon_data_lahan`
--

CREATE TABLE `pemohon_data_lahan` (
  `id` int(11) NOT NULL,
  `id_pemohon` int(11) NOT NULL,
  `luas_tanah` double NOT NULL,
  `jenis_hak_tanah` varchar(15) NOT NULL COMMENT 'Girik, Hak Guna Bangunan, Hak Milik, Hak Pakai, HGB Diatas HPL, HPL',
  `kondisi_lahan` tinyint(1) NOT NULL COMMENT '0 = Kosong, 1 = Lahan Ada Bangunan',
  `jumlah_bidang_tanah` int(11) NOT NULL,
  `total_luas_tanah` double NOT NULL,
  `jumlah_objek_tanah_pbb` double NOT NULL,
  `total_luas_bumi_pbb` double NOT NULL,
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `perizinan_jenis`
--

CREATE TABLE `perizinan_jenis` (
  `id` int(11) NOT NULL,
  `id_paket` tinyint(1) NOT NULL,
  `jenis_perizinan` varchar(200) NOT NULL,
  `nama_lain_perizinan` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `perizinan_jenis`
--

INSERT INTO `perizinan_jenis` (`id`, `id_paket`, `jenis_perizinan`, `nama_lain_perizinan`) VALUES
(1, 5, ' Izin Kartu Juru Bor', NULL),
(2, 5, ' Surat Izin Praktik Okupasi Terapi (Di Fasilitas Kesehatan)', NULL),
(3, 5, ' Izin Praktik Dokter Gigi (di Fasilitas Kesehatan) - BUKAN Penanggung Jawab Faskes', NULL),
(4, 5, ' Izin Praktik Dokter Hewan (di Fasilitas Kesehatan)', NULL),
(5, 5, ' Izin Praktik Bidan (di Fasilitas Kesehatan)', NULL),
(6, 5, ' Izin Praktik Tenaga Gizi (di Fasilitas Kesehatan)', NULL),
(7, 5, ' Izin Praktik Perawat (di Fasilitas Kesehatan)', NULL),
(8, 5, ' Izin Praktik Bidan (Praktik Perorangan)', NULL),
(9, 5, ' Izin Pelaku Teknis Bangunan', NULL),
(10, 5, ' Izin Praktik Dokter Umum (di Fasilitas Kesehatan) - Penanggung Jawab Faskes', NULL),
(11, 5, ' Izin Praktik Bidan (di Fasilitas Kesehatan)', NULL),
(12, 5, ' Izin Praktik Dokter Gigi Spesialis (Praktik Perorangan)', NULL),
(13, 5, ' Izin Praktik Dokter Spesialis (Praktik Perorangan)', NULL),
(14, 5, ' Izin Praktik Apoteker (di Fasilitas Kesehatan) - Pelayanan Kefarmasian, BUKAN Penanggung Jawab', NULL),
(15, 5, ' Izin Praktik Dokter Gigi Spesialis (di Fasilitas Kesehatan) - BUKAN Penanggung Jawab Faskes', NULL),
(16, 5, ' Izin Praktik Dokter Gigi (di Fasilitas Kesehatan) - Penanggung Jawab Faskes', NULL),
(17, 5, ' Izin Praktik Radiografer (di Fasilitas Kesehatan)', NULL),
(18, 5, ' Kartu pencari kerja (AK 1)', NULL),
(19, 5, ' Tanda Daftar Penyehat Tradisional (di Fasilitas Kesehatan)', NULL),
(20, 5, ' Izin Praktik Perawat (di Fasilitas Kesehatan)', NULL),
(21, 5, ' Izin Praktik Dokter Spesialis (di Fasilitas Kesehatan) - BUKAN Penanggung Jawab Faskes', NULL),
(22, 5, ' Izin Praktik Refraksionis Optisien (di Fasilitas Kesehatan)', NULL),
(23, 5, ' Izin Praktik Tenaga Gizi (di Fasilitas Kesehatan)', NULL),
(24, 5, ' Laporan Keberadaan Tenaga Asing', NULL),
(25, 5, ' Izin Ahli Kecantikan', NULL),
(26, 5, ' Izin Praktik Perekam Medis (Di Fasilitas Kesehatan)', NULL),
(27, 5, ' Izin Praktik Dokter Gigi Spesialis (di Fasilitas Kesehatan) - BUKAN Penanggung Jawab Faskes', NULL),
(28, 5, ' Surat Izin Praktik Teknisi Kardiovaskuler (di Fasilitas Kesehatan)', NULL),
(29, 5, ' Izin Praktik Dokter Umum (Praktik Perorangan)', NULL),
(30, 5, ' Izin Praktik Perekam Medis (Di Fasilitas Kesehatan)', NULL),
(31, 5, ' Izin Praktik Fisioterapis (Di Fasilitas Kesehatan)', NULL),
(32, 5, ' Izin Praktik Ahli Teknologi Laboratorium Medik (Di Fasilitas Kesehatan)', NULL),
(33, 5, ' Izin Praktik Optometris (Di Fasilitas Kesehatan)', NULL),
(34, 5, ' Surat Izin Praktik Teknisi Gigi (Di Fasilitas Kesehatan)', NULL),
(35, 5, ' Izin Praktik Penata Anestesi (di Fasilitas Kesehatan)', NULL),
(36, 5, ' Izin Praktik Perawat (Praktik Perorangan)', NULL),
(37, 5, ' Izin Praktik Dokter Umum (di Fasilitas Kesehatan) - BUKAN Penanggung Jawab Faskes', NULL),
(38, 5, ' Izin Praktik Dokter Gigi Spesialis (di Fasilitas Kesehatan) - Penanggung Jawab Faskes', NULL),
(39, 5, ' Izin Praktik Fisioterapis (Di Fasilitas Kesehatan)', NULL),
(40, 5, ' Izin Praktik Tenaga Teknis Kefarmasian (di Fasilitas Kesehatan)', NULL),
(41, 5, ' Izin Praktik Dokter Umum (Praktik Perorangan)', NULL),
(42, 5, ' Izin Praktik Dokter Gigi (Praktik Perorangan)', NULL),
(43, 5, ' Izin Praktik Dokter Spesialis (Praktik Perorangan)', NULL),
(44, 5, ' Izin Praktik Apoteker (di Fasilitas Kesehatan) - Pelayanan Kefarmasian, Penanggung Jawab', NULL),
(45, 5, ' Izin Praktik Tenaga Teknis Kefarmasian (di Fasilitas Kesehatan)', NULL),
(46, 5, ' Izin Praktik Apoteker (di Fasilitas Kesehatan) - Pelayanan Kefarmasian, Penanggung Jawab', NULL),
(47, 5, ' Izin Praktik Elektromedis (Di Fasilitas Kesehatan)', NULL),
(48, 5, ' Izin Praktik Apoteker (di Fasilitas Kesehatan) - Fasilitas Produksi', NULL),
(49, 5, ' Izin Praktik Dokter Gigi (di Fasilitas Kesehatan) - BUKAN Penanggung Jawab Faskes', NULL),
(50, 5, ' Izin Praktik Dokter Umum (di Fasilitas Kesehatan) - BUKAN Penanggung Jawab Faskes', NULL),
(51, 5, ' Izin Praktik Dokter Gigi Spesialis (Praktik Perorangan)', NULL),
(52, 5, ' Izin Praktik Radiografer (di Fasilitas Kesehatan)', NULL),
(53, 5, ' Izin Praktik Refraksionis Optisien (di Fasilitas Kesehatan)', NULL),
(54, 5, ' Izin Praktik Ortotik Prostetik (Di Fasilitas Kesehatan)', NULL),
(55, 5, ' Izin Praktik Apoteker (di Fasilitas Kesehatan) - Fasilitas Distribusi Penyaluran', NULL),
(56, 5, ' Izin Praktik Apoteker (di Fasilitas Kesehatan) - Pelayanan Kefarmasian, BUKAN Penanggung Jawab', NULL),
(57, 5, ' Izin Praktik Dokter Gigi (Praktik Perorangan)', NULL),
(58, 5, ' Izin Praktik Bidan (Praktik Perorangan)', NULL),
(59, 5, ' Izin Praktik Perawat Gigi (di Fasilitas Kesehatan)', NULL),
(60, 5, ' Izin Praktik Dokter Hewan (Praktik Perorangan)', NULL),
(61, 5, ' Izin Praktik Apoteker (di Fasilitas Kesehatan) - Fasilitas Distribusi Penyaluran', NULL),
(62, 5, ' Izin Praktik Perawat Gigi (di Fasilitas Kesehatan)', NULL),
(63, 5, ' Izin Praktik Penata Anestesi (di Fasilitas Kesehatan)', NULL),
(64, 5, ' Izin Praktik Dokter Umum (di Fasilitas Kesehatan) - Penanggung Jawab Faskes', NULL),
(65, 5, ' Izin Praktik Dokter Spesialis (di Fasilitas Kesehatan) - Penanggung Jawab Faskes', NULL),
(66, 5, ' Izin Praktik Ahli Teknologi Laboratorium Medik (Di Fasilitas Kesehatan)', NULL),
(67, 5, ' Izin Praktik Dokter Gigi Spesialis (di Fasilitas Kesehatan) - Penanggung Jawab Faskes', NULL),
(68, 5, ' Izin Tahan Jenazah', NULL),
(69, 5, ' Izin Pengabuan Jenazah/Kerangka', NULL),
(70, 5, ' Izin Mengangkut Jenazah Ke Luar Negeri/Ke Luar Wilayah Provinsi DKI Jakarta', NULL),
(71, 5, ' Surat Keterangan Umum', NULL),
(72, 5, ' Surat Keterangan Sebagai Pengantar Pembuatan SKCK', NULL),
(73, 5, ' Izin Penggalian dan Pemindahan Jenazah/Kerangka Jenazah', NULL),
(74, 5, ' Surat Keterangan Tidak Mampu (SKTM)', NULL),
(75, 5, ' Surat Izin Praktik Terapi Wicara (di Fasilitas Kesehatan)', NULL),
(76, 5, ' Izin Praktik Ahli Kesehatan Masyarakat (di Fasilitas Kesehatan)', NULL),
(77, 5, ' Pencabutan Izin Praktik Dokter Hewan (di Fasilitas Kesehatan)', NULL),
(78, 5, ' Pencabutan Izin Praktik Dokter Hewan (Praktik Perorangan)', NULL),
(79, 5, ' Izin Praktik Dokter Gigi (di Fasilitas Kesehatan)', NULL),
(80, 5, ' Izin Praktik Dokter Gigi (di Fasilitas Kesehatan) - Penanggung Jawab Faskes', NULL),
(81, 5, ' Izin Praktik Dokter Spesialis (di Fasilitas Kesehatan) - Penanggung Jawab Faskes', NULL),
(82, 5, ' Tanda Daftar Penyehat Tradisional (Praktik Perorangan)', NULL),
(83, 5, ' Izin Praktik Tenaga Kesehatan Tradisional (Praktik Perorangan)', NULL),
(84, 5, ' Izin Praktik Tenaga Sanitarian (Di Fasilitas Kesehatan)', NULL),
(85, 5, ' Izin Praktik Dokter Gigi Spesialis (di Fasilitas Kesehatan)', NULL),
(86, 5, ' Izin Praktik Perawat (Praktik Perorangan)', NULL),
(87, 5, ' Izin Tukang Gigi', NULL),
(88, 5, ' Izin Pedagang Eceran Obat', NULL),
(89, 5, ' Izin Praktik Dokter Spesialis (di Fasilitas Kesehatan) - BUKAN Penanggung Jawab Faskes', NULL),
(90, 5, ' Izin Praktik Dokter Spesialis (di Fasilitas Kesehatan)', NULL),
(91, 5, ' Izin Praktik Dokter Umum (di Fasilitas Kesehatan)', NULL),
(92, 5, ' Kartu Tanda Berjualan Daging', NULL),
(93, 5, ' Tanda Daftar Keahlian Keselamatan Kebakaran', NULL),
(94, 2, ' Izin Penyelenggaraan Reklame: Luas Bidang < 24 m², memiliki TLB BR, atau berada di luar Kawasan Kendali Ketat', NULL),
(95, 2, ' Izin Penyelenggaraan Reklame: Luas Bidang > 24 m², atau memiliki LED, atau berada di Kawasan Kendali Ketat', NULL),
(96, 2, ' Izin Mendirikan Bangunan: Bangunan Rumah tinggal luas tanah >= 100 m² , kondisi tanah tidak harus kosong, dan jumlah lantai s.d. 3 lantai termasuk Cluster/Town House;  Pemugaran Cagar Budaya Golongan', 'IMB C'),
(97, 2, ' Izin Mendirikan Bangunan: Bangunan Rumah tinggal luas tanah < 100 m², kondisi tanah kosong atau di atasnya terdapat bangunan tua yang akan dibongkar, dan jumlah lantai s.d 2 lantai', 'IMB D'),
(98, 2, ' Izin Mendirikan Bangunan: Bangunan Non-rumah tinggal jumlah lantai > 8 lantai,  IMB Pondasi', 'IMB A'),
(99, 2, ' Izin Mendirikan Bangunan: Bangunan Non-rumah tinggal jumlah lantai < = 8 lantai,  Rumah Tinggal Pemugaran Cagar Budaya Golongan A,  IMB Reklame,  IMB Menara', 'IMB B'),
(100, 2, ' Izin Penyelenggaraan Reklame: Tidak memiliki TLB BR (Tata Letak Bangunan, Bangunan Reklame)', NULL),
(101, 2, ' Paket IMB 3 JAM (KRK-SPPL-GPA-IMB) Untuk bangunan non Rumah Tinggal', NULL),
(102, 2, ' Rekomendasi Keselamatan Kebakaran Bangunan <= 8 lantai', NULL),
(103, 2, ' Sertifikat Layak Fungsi: Bangunan Rumah tinggal luas tanah > 100 m² dan jumlah lantai s.d 3 lantai termasuk Cluster/Town House, Pemugaran Cagar Budaya Golongan B dan C;  Bangunan Gudang luas tanah < ', NULL),
(104, 2, ' Sertifikat Layak Fungsi: Bangunan Non-rumah tinggal jumlah lantai > 8 lantai', NULL),
(105, 2, ' Sertifikat Layak Fungsi: Bangunan Non-rumah tinggal jumlah lantai ? 8 Lantai;  Rumah Tinggal Pemugaran Cagar Budaya Golongan A', NULL),
(106, 2, ' Rekomendasi Keselamatan Kebakaran Bangunan > 8 lantai', NULL),
(107, 2, ' Surat Kelayakan Konstruksi Menara (SKKM)', NULL),
(108, 2, ' Sertifikat Layak Fungsi: Bangunan Rumah tinggal luas tanah < 100 m² dan jumlah lantai s.d 2 lantai', NULL),
(109, 2, ' Sertifikat Keselamatan Kebakaran (Bangunan ? 8 lantai)', NULL),
(110, 2, ' Pengesahan Gambar Perencanaan Arsitektur Bangunan Non-Rumah Tinggal jumlah lantai > 8', NULL),
(111, 2, ' Rekomendasi Perolehan/Peralihan/Penjaminan Hak Guna Bangunan/Hak Pakai Atau Hak Lainnya Di Atas Bidang Tanah Hak Pengelolaan', NULL),
(112, 2, ' Persetujuan Prinsip Pelampauan Koefisien Lantai Bangunan (KLB)', NULL),
(113, 2, ' Sertifikat Keselamatan Kebakaran (Bangunan > 8 lantai)', NULL),
(114, 2, ' Izin Pelaksanaan Penempatan Bangunan Pelengkap', NULL),
(115, 2, ' Persetujuan Rencana Teknis Bongkar', NULL),
(116, 2, ' Izin Peil Lantai Bangunan (PLB)', NULL),
(117, 3, ' Izin Membangun Prasarana', NULL),
(118, 3, ' Izin Trase Jalan, Jembatan, Saluran, atau Utilitas', NULL),
(119, 3, ' Persetujuan Prinsip Trase Jalan, Jembatan, Saluran, atau Utilitas', NULL),
(120, 3, ' Rekomendasi Saluran Kabel Tegangan Tinggi', NULL),
(121, 3, ' Izin Pelaksanaan Storing Jaringan Utilitas', NULL),
(122, 3, ' Rekomendasi Loading Test', NULL),
(123, 3, ' Izin Pelaksanaan Penempatan Jaringan Utilitas (IPPJU)', NULL),
(124, 3, ' Izin Pendirian SD', NULL),
(125, 3, ' Izin Pendirian Satuan PAUD', NULL),
(126, 3, ' Izin Pendirian Satuan PAUD', NULL),
(127, 3, ' Izin Pendirian Non Panti Sosial', NULL),
(128, 3, ' Izin Pendirian Taman Kanak-Kanak', NULL),
(129, 3, ' Izin Pendirian Taman Kanak-Kanak', NULL),
(130, 3, ' Izin Pendirian SMP', NULL),
(131, 3, ' Izin Pendirian SMA', NULL),
(132, 3, ' Izin Pendirian SMK', NULL),
(133, 3, ' Izin Pendirian SD', NULL),
(134, 3, ' Izin Pendirian SMP', NULL),
(135, 3, ' Izin Pendirian SMK', NULL),
(136, 3, ' Izin Pendirian RS Tipe C dan D', NULL),
(137, 3, ' Izin Puskesmas Kecamatan', NULL),
(138, 3, ' Izin Pendirian Panti Sosial', NULL),
(139, 3, ' Izin Puskesmas Kelurahan', NULL),
(140, 3, ' Izin Puskesmas Kecamatan', NULL),
(141, 3, ' Izin Pendirian SMA', NULL),
(142, 3, ' Izin Puskesmas Kelurahan', NULL),
(143, 3, ' Izin Puskesmas Kecamatan', NULL),
(144, 3, ' Izin Puskesmas Kelurahan', NULL),
(145, 1, ' Cetak Ulang Peta atau Gambar Ketataruangan', NULL),
(146, 1, ' Izin Prinsip Pemanfaatan Ruang', NULL),
(147, 1, ' Tata Letak Bangunan untuk Bangunan Reklame', NULL),
(148, 1, ' Penjaminan Hak Guna Bangunan/Hak Pakai Atau Hak Lainnya Diatas Bidang Tanah Hak Pengelolaan Tanah', NULL),
(149, 1, ' Ketetapan Rencana Kota untuk Konsultasi BKPRD : Ketetapan Rencana Kota : Kecil Luas tanah < 1000 m², untuk semua jenis bangunan rumah tinggal dan non-rumah tinggal', NULL),
(150, 1, ' Ketetapan Rencana Kota: Kecil Luas tanah < 1000 m², untuk semua jenis bangunan rumah tinggal dan non-rumah tinggal', NULL),
(151, 1, ' Permohonan Hak Diatas Bidang Tanah Eks Desa atau Tanah Eks Kota Praja', NULL),
(152, 1, ' Ketetapan Rencana Kota: Besar Luas tanah > 5000 m², untuk semua jenis bangunan rumah tinggal dan non-rumah tinggal', NULL),
(153, 1, ' Rekomendasi Zona Menara', NULL),
(154, 1, ' Tata Letak Bangunan untuk Bangunan Menara', NULL),
(155, 1, ' Ketetapan Rencana Kota untuk Konsultasi BKPRD: Ketetapan Rencana Kota : Sedang Luas tanah ? 1000 m² hingga luas tanah berukuran < 5000 m², untuk semua jenis bangunan rumah tinggal dan non-rumah tingg', NULL),
(156, 1, ' Peta Situasi Ukur/Pengukuran Lahan', NULL),
(157, 1, ' Ketetapan Rencana Kota untuk Konsultasi BKPRD : Ketetapan Rencana Kota : Besar Luas tanah ? 5000 m², untuk semua jenis bangunan rumah tinggal dan non-rumah tinggal', NULL),
(158, 1, ' Ketetapan Rencana Kota: Sedang Luas tanah > 1000 m² hingga luas tanah berukuran < 5000 m², untuk semua jenis bangunan rumah tinggal dan non-rumah tinggal', NULL),
(159, 1, ' Persetujuan Prinsip Pembebasan Lokasi/Tanah', NULL),
(160, 1, ' Pengesahan Gambar Perencanaan Arsitektur Bangunan Non-Rumah Tinggal jumlah lantai < 8', NULL),
(161, 1, ' Izin Lingkungan - Dokumen Pengelolaan Lingkungan Hidup (DPLH KELAS A)', NULL),
(162, 1, ' Persetujuan KA ANDAL', NULL),
(163, 1, ' Izin Lingkungan - Dokumen Evaluasi Lingkungan Hidup (DELH)', NULL),
(164, 1, ' Izin Pengeboran Air Tanah', NULL),
(165, 1, ' Persetujuan Analisa Dampak Lalu Lintas', NULL),
(166, 1, ' Izin Lingkungan - Analisis Mengenai Dampak Lingkungan', NULL),
(167, 1, ' Izin Lingkungan - Surat Pernyataan Pengelolaan Lingkungan', NULL),
(168, 1, ' Izin Pemanfaatan Air Bawah Tanah Sumur Bor', NULL),
(169, 1, ' Izin Lingkungan - Upaya Pengelolaan Lingkungan dan Upaya Pemantauan Lingkungan Kelas B (UKL UPL Kelas B)', NULL),
(170, 1, ' Surat Keputusan Kelayakan Lingkungan', NULL),
(171, 1, ' Izin Pemanfaatan Air Bawah Tanah Sumur Pantek', NULL),
(172, 1, ' Izin Penggunaan Bangunan di lokasi Taman dan Jalur Hijau', NULL),
(173, 1, ' Izin Dewatering', NULL),
(174, 1, ' Izin Penyimpanan Sementara Limbah Bahan Berbahaya dan Beracun', NULL),
(175, 1, ' Izin Instalasi Pengolahan Air Limbah', NULL),
(176, 1, ' Izin Pemanfaatan Perairan di Luar Pelabuhan', NULL),
(177, 1, ' Izin Pembuangan Air Limbah', NULL),
(178, 1, ' Tanda Daftar Wisata Sungai, Danau atau Waduk untuk jenis Wisata Dayung Perorangan', NULL),
(179, 1, ' Tanda Daftar Kawasan Pariwisata', NULL),
(180, 1, ' Tanda Daftar Kawasan Pariwisata Perorangan', NULL),
(181, 1, ' Tanda Daftar Wisata Sungai, Danau atau Waduk untuk jenis Wisata Dayung', NULL),
(182, 1, ' Rekomendasi Calon Lahan Kompensasi Penggunaan Kawasan Hutan', NULL),
(183, 1, ' Izin Pemanfaatan wilayah perairan untuk kegiatan industri dan pemotongan kapal, pariwisata, kepelabuhanan, floating repair, floating terminal, floating storage', NULL),
(184, 1, ' Rekomendasi Izin Pinjam Pakai Kawasan Hutan Untuk Pembangunan Fasilitas Umum Non Komersial', NULL),
(185, 1, ' Izin Perumahan', NULL),
(186, 1, ' Persetujuan Prinsip Industri untuk Industri di Luar Kawasan Industri/Kawasan Berikat', NULL),
(187, 1, ' Izin Pemakaian Lokasi Taman dan Jalur Hijau untuk Bedeng Proyek (Direksi Keet), Material dan Sejenisnya', NULL),
(188, 1, ' Izin Pemakaian Lokasi Taman dan Jalur Hijau untuk Shooting Film, Bazar, Perlombaan, dan Kegiatan Lain', NULL),
(189, 1, ' Izin Pemakaian Lokasi Taman dan Jalur Hijau untuk Perkemahan', NULL),
(190, 1, ' Izin Pemakaian lokasi kebun bibit Dinas Kehutanan', NULL),
(191, 1, ' Izin Penggunaan Tanah Makam (Makam Baru/Perpanjangan/Tumpangan)', NULL),
(192, 1, ' Izin Pengepul Limbah Minyak Goreng', NULL),
(193, 4, ' Izin Operasional Prasarana dan Sarana Olahraga Prestasi', NULL),
(194, 4, ' Izin Operasional Prasarana dan Sarana Olahraga Edukasi', NULL),
(195, 4, ' Izin Sarana Pelayanan Kesehatan Tradisional', NULL),
(196, 4, ' Rekomendasi Impor Hasil Perikanan', NULL),
(197, 4, ' Pas Kecil dan Sertifikat Kesempurnaan', NULL),
(198, 4, ' Sertifikat Laik Sehat Usaha Hotel, Restoran dan Rumah Makan', NULL),
(199, 4, ' Sertifikat Laik Sehat Usaha Depo Air Minum', NULL),
(200, 4, ' Sertifikat Laik Sehat Penyehatan Makanan bagi Usaha Jasa Boga', NULL),
(201, 4, ' Rekomendasi Impor Induk Ikan', NULL),
(202, 4, ' Izin Pemanfaatan Air Permukaan', NULL),
(203, 4, ' Penetapan Status, Perubahan Status, Peremajaan dan Balik Nama Kendaraan Angkutan Umum', NULL),
(204, 4, ' Izin Penyelenggaraan Kegiatan Keolahragaan dan Kepemudaan (Hanya dalam Satu Kecamatan)', NULL),
(205, 4, ' Izin Penyelenggaraan Kegiatan Keolahragaan dan Kepemudaan (Antar Kota/Kabupaten dalam Satu Provinsi)', NULL),
(206, 4, ' Izin Usaha Jasa Konstruksi (Besar/Menengah/Kecil)', NULL),
(207, 4, ' Izin Usaha Pusat Perbelanjaan (IUPP)', NULL),
(208, 4, ' Rekomendasi Pemasukan/Pengeluaran Unggas dari/ke luar negeri', NULL),
(209, 4, ' Izin Usaha Toko Swalayan (IUTS)', NULL),
(210, 4, ' Rekomendasi Undian Gratis Berhadiah', NULL),
(211, 4, ' Izin Pemasukan/Pengeluaran Daging', NULL),
(212, 4, ' Rekomendasi Impor Produk Hewan', NULL),
(213, 4, ' Rekomendasi Impor Bahan Baku Pakan Ternak', NULL),
(214, 4, ' Izin Pemasukan Ternak', NULL),
(215, 4, ' Izin Pool', NULL),
(216, 4, ' Rekomendasi Impor', NULL),
(217, 4, ' Izin Penyelenggaraan Kegiatan Keolahragaan dan Kepemudaan (Antar Kecamatan dalam Satu Kota/ Kabupaten)', NULL),
(218, 4, ' Rekomendasi Impor Benih Ikan', NULL),
(219, 4, ' Izin Pengeluaran Produk Hewan', NULL),
(220, 4, ' Rekomendasi Impor Ikan Hidup', NULL),
(221, 4, ' Izin Kegiatan Pengumpulan Uang dan Barang', NULL),
(222, 4, ' Izin Pemasukan Produk Hewan', NULL),
(223, 4, ' Izin Usaha Pusat Perbelanjaan (IUPP)', NULL),
(224, 4, ' Rekomendasi Impor Pakan dan Obat Ikan', NULL),
(225, 4, ' Izin Pemasukan/Pengeluaran hewan kesayangan, unggas dan eksotik', NULL),
(226, 4, ' Rekomendasi Impor Ikan Hias dan Tanaman Air', NULL),
(227, 4, ' Rekomendasi Teknis Kesehatan Masyarakat Veteriner', NULL),
(228, 4, ' Rekomendasi Impor Pakan Hewan Kesayangan', NULL),
(229, 4, ' Rekomendasi Pemasukan / Pengeluaran Hewan', NULL),
(230, 4, ' Izin Pemasukan/ Pengeluaran Hewan dan Produk Hewan (domestik)', NULL),
(231, 4, ' Izin Usaha Toko Swalayan (IUTS)', NULL),
(232, 4, ' Surat Izin Usaha Perdagangan (SIUP) Besar Perorangan', NULL),
(233, 4, ' Surat Izin Usaha Perdagangan (SIUP) Besar', NULL),
(234, 4, ' Izin Distributor Obat Hewan', NULL),
(235, 4, ' Izin Rumah Kost', NULL),
(236, 4, ' Izin Tempat Sementara Penampungan Hewan', NULL),
(237, 4, ' Izin Petshop', NULL),
(238, 4, ' Surat Izin Usaha Perdagangan (SIUP) Kecil Perorangan', NULL),
(239, 4, ' Rekomendasi Izin Operasional Rumah Sakit Kelas A', NULL),
(240, 4, ' Izin Pembentukan Kantor Cabang Pelaksana Penempatan Tenaga Kerja Indonesia Swasta', NULL),
(241, 4, ' Izin Penyelenggaraan Angkutan Orang Dengan Kendaraan Bermotor Umum Dalam Trayek (Baru/Perpanjangan Dalam Wilayah Provinsi DKI Jakarta)', NULL),
(242, 4, ' Tanda Daftar Bioskop', NULL),
(243, 4, ' Izin Prinsip Perluasan Penanaman Modal Dalam Negeri (PMDN)', NULL),
(244, 4, ' Tanda Daftar Perkumpulan atau Organisasi Sosial', NULL),
(245, 4, ' Izin Operasional Lembaga Pelayanan Penempatan Tenaga Kerja Dengan Disabilitas', NULL),
(246, 4, ' Izin Operasional Lembaga Kursus dan Pelatihan (LKP)', NULL),
(247, 4, ' Izin Toko Obat Hewan', NULL),
(248, 4, ' Surat Izin Usaha Perdagangan (SIUP) Menengah', NULL),
(249, 4, ' Izin Depo / Toko Obat Hewan', NULL),
(250, 4, ' Izin Usaha Pengolahan Daging', NULL),
(251, 4, ' Izin Penyelenggaraan Perparkiran Di Luar Ruang Milik Jalan', NULL),
(252, 4, ' Izin Usaha Perikanan Budidaya', NULL),
(253, 4, ' Izin Usaha Persusuan', NULL),
(254, 4, ' Izin Usaha Industri (Kecil)', NULL),
(255, 4, ' Izin Operasional Rumah Sakit Kelas C', NULL),
(256, 4, ' Tanda Daftar Yayasan', NULL),
(257, 4, ' Izin Usaha Pemotongan Ternak', NULL),
(258, 4, ' Surat Persetujuan Pengoperasian Kapal Angkutan Penyeberangan', NULL),
(259, 4, ' Izin Pembukaan Kantor Cabang Penanaman Modal Dalam Negeri (PMDN) atau Penanaman Modal Asing (PMA)', NULL),
(260, 4, ' Kartu Tanda Daftar Usaha Orang Perseorangan untuk Usaha Jasa Konstruksi', NULL),
(261, 4, ' Pertimbangan Teknis Angkutan Antar Kota Antar Propinsi', NULL),
(262, 4, ' Izin insidental (angkutan lebaran)', NULL),
(263, 4, ' Izin Pengangkutan Daging', NULL),
(264, 4, ' Rekomendasi Produksi Alat Kesehatan', NULL),
(265, 4, ' Izin Operasional Perusahaan Penyedia Jasa Pekerja/Buruh', NULL),
(266, 4, ' Izin Usaha Rumah Sakit Hewan', NULL),
(267, 4, ' Tanda Daftar Perusahaan (TDP) Perseroan Terbatas (PT)', NULL),
(268, 4, ' Izin Klinik Pratama', NULL),
(269, 4, ' Tanda Daftar Angkutan Kereta Api Wisata Perorangan', NULL),
(270, 4, ' Izin Usaha Klinik Hewan', NULL),
(271, 4, ' Rekomendasi Produksi Perbekalan Kesehatan Rumah Tangga', NULL),
(272, 4, ' Izin Usaha/Yayasan Rumah Duka', NULL),
(273, 4, ' Izin Cabang Pedagang Besar Farmasi (Pengakuan Pedagang Besar Farmasi Cabang)', NULL),
(274, 4, ' Pertimbangan Teknis Angkutan Pariwisata', NULL),
(275, 4, ' Surat Izin Usaha Perdagangan Minuman Beralkohol untuk Pengecer, Penjual Langsung dan TBB Sebagai Pengecer', NULL),
(276, 4, ' Izin Operasional Rumah Sakit Kelas B Non Pendidikan', NULL),
(277, 4, ' Rekomendasi Instalasi Karantina Hewan/ Produk Hewan/ Pakan Hewan Sementara', NULL),
(278, 4, ' Izin Laboratorium Klinik (Madya)', NULL),
(279, 4, ' Izin Klinik Pratama Perorangan', NULL),
(280, 4, ' Izin Klinik Utama', NULL),
(281, 4, ' Tanda Daftar Perusahaan (TDP) Persekutuan Firma (Fa)', NULL),
(282, 4, ' Tanda Daftar Angkutan Kereta Api Wisata', NULL),
(283, 4, ' Tanda Daftar Perusahaan (TDP) Perseroan Terbatas (PT)', NULL),
(284, 4, ' Izin Ambulans', NULL),
(285, 4, ' Izin Usaha Pelayanan Angkutan di Bidang Kebersihan', NULL),
(286, 4, ' Tanda Daftar Perusahaan (TDP) Perusahaan Perorangan (PO)', NULL),
(287, 4, ' Izin Usaha Pemusnahan/Pemanfaatan Sampah dan Air kotor', NULL),
(288, 4, ' Industri Pengolahan Kayu (Lanjutan/Terpadu)', NULL),
(289, 4, ' IZIN PANTI SEHAT (PENGOBATAN TRADISIONAL/PIJAT TUNA NETRA)', NULL),
(290, 4, ' Rekomendasi Produksi Kosmetik', NULL),
(291, 4, ' Izin Usaha Penyediaan Tenaga Listrik (IUPTL)', NULL),
(292, 4, ' Rekomendasi Izin Usaha sebagai Importir, Produsen dan Eksportir Obat Hewan', NULL),
(293, 4, ' Tanda Daftar Perusahaan (TDP) Perusahaan Perorangan (PO)', NULL),
(294, 4, ' Rekomendasi Pedagang Besar Farmasi', NULL),
(295, 4, ' Izin Usaha Jasa Tally', NULL),
(296, 4, ' Rekomendasi Penyalur Alat Kesehatan', NULL),
(297, 4, ' Izin Operasional Prasarana dan Sarana Olahraga Rekreasi', NULL),
(298, 4, ' Pengesahan Pemakaian dan Pengolahan Bahan Kimia Berbahaya di Tempat Kerja', NULL),
(299, 4, ' Izin Penangkapan Ikan 5-30 GT', NULL),
(300, 4, ' Izin lembaga pelatihan kerja atau balai latihan kerja luar negeri', NULL),
(301, 4, ' Tanda Daftar Gudang (TDG) Perorangan', NULL),
(302, 4, ' Izin Klinik Utama', NULL),
(303, 4, ' Izin Klinik Utama', NULL),
(304, 4, ' Izin Operasional Rumah Sakit Kelas B Non Pendidikan', NULL),
(305, 4, ' Tanda Daftar Usaha Pariwisata Kecamatan', NULL),
(306, 4, ' Izin Apotek', NULL),
(307, 4, ' Tanda Daftar Perusahaan (TDP) Perseroan Terbatas (PT)', NULL),
(308, 4, ' Tanda Daftar Perusahaan (TDP) Persekutuan Komanditer (CV)', NULL),
(309, 4, ' Izin angkutan barang untuk melewati jalan-jalan tertentu', NULL),
(310, 4, ' Izin Usaha Krematorium (pengabuan)', NULL),
(311, 4, ' Izin Prinsip Penanaman Modal Dalam Negeri (PMDN)', NULL),
(312, 4, ' Izin Usaha Jasa Penunjang Tenaga Listrik (IUJPTL)', NULL),
(313, 4, ' Izin Usaha Pengelolaan Sampah', NULL),
(314, 4, ' Rekomendasi Surat Izin Penangkapan Ikan >30 GT', NULL),
(315, 4, ' Izin Apotek', NULL),
(316, 4, ' Izin Kapal Pengangkut Ikan <30 GT (SIKPI)', NULL),
(317, 4, ' Tanda Daftar Perusahaan (TDP) Bentuk Usaha Lainnya (BUL)', NULL),
(318, 4, ' Izin Usaha Industri Primer Hasil Hutan (Kayu/Bukan Kayu)', NULL),
(319, 4, ' Surat Izin Usaha Perdagangan (SIUP) Besar Perubahan', NULL),
(320, 4, ' Rekomendasi Penyelenggaraan Perjalanan Haji Khusus', NULL),
(321, 4, ' Surat Izin Usaha Perdagangan (SIUP) Menengah Perorangan Perubahan', NULL),
(322, 4, ' Izin Usaha/Yayasan Rumah Abu', NULL),
(323, 4, ' Tanda Daftar Usaha Perikanan (TDUP)', NULL),
(324, 4, ' Kartu Izin Usaha (KIU), Kartu Izin Operasi (KIO), Kartu Pengawasan (KP)', NULL),
(325, 4, ' Izin Usaha Pengeboran Air Bawah Tanah', NULL),
(326, 4, ' Izin Laboratorium Klinik (Pratama)', NULL),
(327, 4, ' Izin Usaha Mikro dan Kecil (IUMK)', NULL),
(328, 4, ' Tanda Daftar Perusahaan (TDP) Bentuk Usaha Lainnya (BUL)', NULL),
(329, 4, ' Tanda Daftar Perusahaan (TDP) Persekutuan Komanditer (CV)', NULL),
(330, 4, ' Izin Pengedar/Penampung Tumbuhan dan Satwa Liar Yang Tidak Dilindungi dan Non Appendix CITES', NULL),
(331, 4, ' Tanda Daftar Perusahaan (TDP) Koperasi', NULL),
(332, 4, ' Izin Distributor Pakan Hewan Kesayangan', NULL),
(333, 4, ' Izin Usaha Angkutan Jenazah', NULL),
(334, 4, ' Izin Operasional Rumah Sakit Kelas D', NULL),
(335, 4, ' Tanda Daftar Jasa Manajemen Hotel Perorangan', NULL),
(336, 4, ' Tanda Daftar Perusahaan (TDP) Koperasi', NULL),
(337, 4, ' Tanda Daftar Jasa Manajemen Hotel', NULL),
(338, 4, ' Surat Izin Usaha Perdagangan (SIUP) Mikro', NULL),
(339, 4, ' Rekomendasi Izin Kapal Pengangkut Ikan >30 GT', NULL),
(340, 4, ' Izin Operasional Pusat Kegiatan Belajar Masyarakat (PKBM)', NULL),
(341, 4, ' Tanda Pencatatan Kapal Penangkap Ikan <5 GT', NULL),
(342, 4, ' Izin Operasional Rumah Sakit Kelas C', NULL),
(343, 4, ' Izin Penyelenggaraan Pendidikan dan Pelatihan Mengemudi', NULL),
(344, 4, ' Izin Usaha Pelayaran Rakyat', NULL),
(345, 4, ' Tanda Daftar Pertunjukan Temporer (Lokal/Izin Ground Breaking)', NULL),
(346, 4, ' Izin Operasional Rumah Sakit Kelas D', NULL),
(347, 4, ' Izin Penutupan Kantor Cabang Penanaman Modal Dalam Negeri (PMDN) atau Penanaman Modal Asing (PMA)', NULL),
(348, 4, ' Izin Usaha Penangkapan Ikan', NULL),
(349, 4, ' Izin Toko Alat Kesehatan', NULL),
(350, 4, ' Izin Klinik Pratama', NULL),
(351, 4, ' Rekomendasi Industri Farmasi', NULL),
(352, 4, ' Izin Lembaga Pelatihan Kerja', NULL),
(353, 4, ' Izin Sarana Upaya Pelayanan Hemodialisa di Dalam Rumah Sakit', NULL),
(354, 4, ' Tanda Daftar Perusahaan (TDP) Persekutuan Firma (Fa)', NULL),
(355, 4, ' Tanda Daftar Bioskop Perorangan', NULL),
(356, 4, ' Izin Penyelenggaraan Pendidikan Khusus', NULL),
(357, 4, ' Izin Distributor Daging', NULL),
(358, 4, ' Rekomendasi Izin Lembaga Konservasi', NULL),
(359, 4, ' Izin Cabang Penyalur Alat Kesehatan', NULL),
(360, 4, ' Izin Usaha Penanaman Modal Dalam Negeri (PMDN) |', NULL),
(361, 4, ' Izin Pengelolaan Terminal Untuk Kepentingan Sendiri Pelabuhan Pengumpan', NULL),
(362, 4, ' Surat izin usaha Lembaga Penempatan Tenaga Kerja Swasta Antar Kerja Lokal', NULL),
(363, 4, ' Izin Usaha Bongkar Muat Barang', NULL),
(364, 4, ' Tempat Penampungan Terdaftar (TPT)', NULL),
(365, 4, ' Tanda Daftar Perusahaan (TDP) Bentuk Usaha Lainnya (BUL)', NULL),
(366, 4, ' Izin Penyelenggaraan Angkutan Orang', NULL),
(367, 4, ' Tanda Daftar Perusahaan (TDP) Persekutuan Komanditer (CV)', NULL),
(368, 4, ' Tanda Daftar Perusahaan (TDP) Persekutuan Firma (Fa)', NULL),
(369, 4, ' Izin Kegiatan Penunjang Dalam Terminal', NULL),
(370, 4, ' Izin Operasional Perusahaan Pengendalian Hama (Pest Control)', NULL),
(371, 4, ' Izin Usaha Pengelolaan Pasar Rakyat Untuk Pengelolaan Pasar Tradisional', NULL),
(372, 4, ' TANDA DAFTAR PERTUNJUKAN TEMPORER (ASING)', NULL),
(373, 4, ' Tanda Daftar Gudang (TDG)', NULL),
(374, 4, ' Izin Klinik Pratama Perorangan', NULL),
(375, 4, ' Izin Usaha Angkutan Penyeberangan', NULL),
(376, 4, ' Surat Izin Usaha Perdagangan (SIUP) Besar Perorangan', NULL),
(377, 4, ' Surat Izin Usaha Perdagangan (SIUP) Kecil', NULL),
(378, 4, ' Tanda Daftar Usaha Biro Perjalanan Wisata Perorangan', NULL),
(379, 4, ' Surat Izin Usaha Perdagangan Bahan Berbahaya Sebagai Pengecer Terdaftar Bahan Berbahaya (PT-B2)', NULL),
(380, 4, ' Izin Usaha Mikro Obat Tradisional', NULL),
(381, 4, ' Izin Usaha Jasa Pelayanan Pemakaman', NULL),
(382, 4, ' Surat Izin Usaha Perdagangan (SIUP) Kecil', NULL),
(383, 4, ' Izin Pengumpul Limbah Bahan Berbahaya dan Beracun', NULL),
(384, 4, ' Izin Panti Pengobat Tradisional', NULL),
(385, 4, ' Izin Operasional Lembaga Penyedia dan Penyalur Pramuwisma', NULL),
(386, 4, ' Rekomendasi Satuan Pendidikan Kerjasama (TK/SD/SMP/SMA/SMK)', NULL),
(387, 4, ' Surat Izin Usaha Perdagangan (SIUP) Menengah', NULL),
(388, 4, ' Izin Penambahan Jenis Produksi Alat Kesehatan', NULL),
(389, 4, ' Izin Penangkapan Ikan Andon', NULL),
(390, 4, ' Izin Prinsip Perubahan Penanaman Modal Dalam Negeri (PMDN)', NULL),
(391, 4, ' Tanda Daftar Gudang (TDG)', NULL),
(392, 4, ' Tanda Daftar Gudang (TDG) Perorangan', NULL),
(393, 4, ' Izin Usaha Toko Swalayan (IUTS)', NULL),
(394, 4, ' Surat Tanda Pendaftaran Waralaba untuk Penerima Waralaba (Baru/Lanjutan)', NULL),
(395, 4, ' Tanda Daftar Perusahaan (TDP) Koperasi', NULL),
(396, 4, ' Tanda Daftar Penyediaan Tenaga Listrik', NULL),
(397, 4, ' Izin Kegiatan Yayasan', NULL),
(398, 4, ' Rekomendasi Laboratorium Klinik Umum Tipe Utama', NULL),
(399, 4, ' Surat Izin Usaha Perdagangan (SIUP) Kecil Perorangan', NULL),
(400, 4, ' Izin Usaha Depo Peti Kemas', NULL),
(401, 4, ' Tanda Daftar Usaha Biro Perjalanan Wisata', NULL),
(402, 4, ' Izin Penyelenggaraan Angkutan Orang Dengan Kendaraan Bermotor Umum Tidak Dalam Trayek (Baru/Perpanjangan Dalam Wilayah Provinsi DKI Jakarta)', NULL),
(403, 4, ' Surat persetujuan pendirian bursa kerja khusus', NULL),
(404, 4, ' Tanda Daftar Perusahaan (TDP) Perusahaan Perorangan (PO)', NULL),
(405, 4, ' Izin Operasional Lembaga Pendidikan Informal', NULL),
(406, 4, ' Rekomendasi Industri Obat Tradisional', NULL),
(407, 4, ' Rekomendasi Usaha Pengolahan Tulang dan Bulu Ayam', NULL),
(408, 4, ' Surat Izin Usaha Perdagangan (SIUP) Menengah Perorangan', NULL),
(409, 4, ' Rekomendasi Pengumpul Limbah Bahan Berbahaya dan Beracun Skala Nasional', NULL),
(410, 4, ' Izin Penyelenggaraan Optikal', NULL),
(411, 4, ' Izin Usaha Kecil Obat Tradisional (UKOT)', NULL),
(412, 4, ' Rekomendasi Izin Penggunaan Kawasan Hutan', NULL),
(413, 4, ' Izin Toko Daging/ Swalayan yang menjual daging', NULL),
(414, 4, ' Izin Klinik Pratama', NULL),
(415, 4, ' Izin Klinik Pratama Perorangan', NULL),
(416, 4, ' Rekomendasi Penerbitan Surat Izin Usaha Perdagangan Minuman Beralkohol Untuk Distributor', NULL),
(417, 4, ' Rekomendasi Pedagang Besar Farmasi yang Mendistribusikan Psikotropika', NULL),
(418, 4, ' Sertifikat Produksi Pangan Industri Rumah Tangga', NULL),
(419, 4, ' Izin Kartu Pengenal Instalasi Bor', NULL),
(420, 4, ' Izin Pemakaian Lokasi Taman Pemakaman untuk shooting film', NULL),
(421, 4, ' Izin Usaha Industri (Besar)', NULL),
(422, 4, ' Surat Keterangan Usaha', NULL),
(423, 4, ' Izin Usaha Industri (Menengah)', NULL),
(424, 4, ' Izin Operasional Penyediaan Tenaga Listrik', NULL),
(425, 4, ' Izin Kelayakan Tempat Penampungan Calon Tenaga Kerja Indonesia', NULL),
(426, 4, ' Izin Operasional Concrete Batching Plant', NULL),
(427, 4, ' Izin Penebangan Pohon Pelindung', NULL),
(428, 4, ' Wajib Lapor Ketenagakerjaan', NULL),
(429, 4, ' Tanda Daftar Gudang (TDG) Perorangan', NULL),
(430, 4, ' Tanda Daftar Gudang (TDG)', NULL),
(431, 4, ' Surat Keterangan Domisili Yayasan', NULL),
(432, 4, ' Surat Keterangan Domisili Organisasi', NULL),
(433, 4, ' Surat Keterangan Domisili Organisasi', NULL),
(434, 4, ' Surat Keterangan Domisili Yayasan', NULL),
(435, 4, ' Surat Keterangan Domisili Usaha', NULL),
(436, 4, ' Surat Pengantar KPR', NULL),
(437, 4, ' Rekomendasi Penelitian (Riset/Penelitian Lebih Dari Satu Wilayah Kota Administrasi)', NULL),
(438, 4, ' Rekomendasi Penelitian (Riset/Penelitian Dalam Satu Wilayah Kota Administrasi)', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `perizinan_paket`
--

CREATE TABLE `perizinan_paket` (
  `id` int(11) NOT NULL,
  `nama_paket` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `perizinan_paket`
--

INSERT INTO `perizinan_paket` (`id`, `nama_paket`) VALUES
(1, 'Pengembangan Kawasan'),
(2, 'Pembangunan Gedung/Kawasan'),
(3, 'Pembangunan Prasarana/Infrastruktur'),
(4, 'Usaha/Kegiatan/Operasional'),
(5, 'Administrasi Keprofesian/Kependudukan');

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
-- Table structure for table `zona`
--

CREATE TABLE `zona` (
  `id` int(11) NOT NULL,
  `nama_zona` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zona`
--

INSERT INTO `zona` (`id`, `nama_zona`) VALUES
(1, 'ZONA TERBUKA HIJAU LINDUNG'),
(2, 'ZONA HUTAN KOTA'),
(3, 'ZONA TAMAN KOTA'),
(4, 'ZONA PEMAKAMAN'),
(5, 'ZONA JALUR HIJAU'),
(6, 'ZONA HIJAU REKREASI'),
(7, 'ZONA TERBUKA HIJAU BUDIDAYA DI WIL. PULAU'),
(8, 'ZONA PEMERINTAHAN NASIONAL'),
(9, 'ZONA PERWAKILAN NEGARA ASING'),
(10, 'ZONA PEMERINTAHAN DAERAH'),
(11, 'ZONA PERUMAHAN KAMPUNG'),
(12, 'ZONA PERUMAHAN KDB SEDANG - TINGGI'),
(13, 'ZONA PERUMAHAN VERTIKAL'),
(14, 'ZONA PERUMAHAN KDB RENDAH'),
(15, 'ZONA PERUMAHAN VERTIKAL KDB RENDAH'),
(16, 'ZONA PERUMAHAN DI WILAYAH PULAU'),
(17, 'ZONA PERKANTORAN, PERDAGANGAN & JASA'),
(18, 'ZONA PERKANTORAN, PERDAGANGAN & JASA KDB RENDAH'),
(19, 'ZONA PERDAGANGAN & JASA DI WIL. PULAU'),
(20, 'ZONA CAMPURAN'),
(21, 'ZONA PELAYANAN UMUM & SOSIAL'),
(22, 'ZONA INDUSTRI & PERGUDANGAN'),
(23, 'ZONA PERTAMBANGAN DI WIL. PULAU'),
(24, 'ZONA TERBUKA BIRU'),
(25, 'ZONA KONSERVASI PERAIRAN LAUT'),
(26, 'ZONA PEMANFAATAN UMUM PERAIRAN LAUT');

-- --------------------------------------------------------

--
-- Table structure for table `zona_sub`
--

CREATE TABLE `zona_sub` (
  `id` int(11) NOT NULL,
  `id_zona` tinyint(3) NOT NULL,
  `kode_subzona` varchar(7) NOT NULL,
  `subzona` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zona_sub`
--

INSERT INTO `zona_sub` (`id`, `id_zona`, `kode_subzona`, `subzona`) VALUES
(1, 1, 'L.1', 'Suaka & Pelestarian Alam'),
(2, 1, 'L.2', 'Sempadan Lindung'),
(3, 2, 'L.3', 'Inti Konservasi Pulau'),
(4, 3, 'H.1', 'Hutan Kota'),
(5, 3, 'H.2', 'Taman Kota/ Lingkungan'),
(6, 4, 'H.3', 'Pemakaman'),
(7, 5, 'H.4', 'Jalur Hijau'),
(8, 5, 'H.5', 'Hijau Tegangan Tinggi'),
(9, 5, 'H.6', 'Hijau Pengaman Jalur KA'),
(10, 6, 'H.7', 'Hijau Rekreasi'),
(11, 7, 'H.8', 'Hijau Budidaya di Wil. Pulau'),
(12, 8, 'P.1', 'Pemerintah Nasional'),
(13, 9, 'P.2', 'Perwakilan Negara Asing'),
(14, 10, 'P.3', 'Pemerintah Daerah'),
(15, 11, 'R.1', 'Rumah Kampung'),
(16, 12, 'R.2', 'Rumah Sangat Kecil'),
(17, 12, 'R.3', 'Rumah Kecil'),
(18, 12, 'R.4', 'Rumah Sedang'),
(19, 12, 'R.5', 'Rumah Besar'),
(20, 12, 'R.6', 'Rumah Flat'),
(21, 13, 'R.7', 'Rumah Susun'),
(22, 13, 'R.8', 'Rumah Susun Umum'),
(23, 14, 'R.9', 'Rumah KDB Rendah'),
(24, 15, 'R.10', 'Rumah Vertikall KDB Rendah'),
(25, 16, 'R.11', 'Perumahan di Wilayah Pulau'),
(26, 17, 'K.1', 'Perkantoran'),
(27, 17, 'K.2', 'Perdagangan & Jasa'),
(28, 18, 'K.3', 'Perkantoran KDB Rendah'),
(29, 18, 'K.4', 'Perdagangan & Jasa KDB Rendah'),
(30, 19, 'K.5', 'Perdagangan & Jasa di Wil. Pulau'),
(31, 20, 'C.1', 'Campuran'),
(32, 21, 'S.1', 'Prasarana Pendidikan'),
(33, 21, 'S.2', 'Prasarana Kesehatan'),
(34, 21, 'S.3', 'Prasarana Ibadah'),
(35, 21, 'S.4', 'Prasarana Sosial Budaya'),
(36, 21, 'S.5', 'Prasarana Olah Raga & Rekreasi'),
(37, 21, 'S.6', 'Prasarana Pelayanan Umum'),
(38, 21, 'S.7', 'Prasarana Terminal'),
(39, 22, 'I.1', 'Industri'),
(40, 22, 'G.1', 'Pergudangan'),
(41, 23, 'T.1', 'Pertambangan di Wilayah Pulau'),
(42, 24, 'B.1', 'Terbuka Biru'),
(43, 25, 'PP.1', 'Konservasi Perairan Laut'),
(44, 26, 'PP.2', 'Pemanfaatan Umum Perairan Laut');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `imb_spasial`
--
ALTER TABLE `imb_spasial`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `imb_spasial_itbx`
--
ALTER TABLE `imb_spasial_itbx`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `imb_spasial_itbx_detail`
--
ALTER TABLE `imb_spasial_itbx_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `imb_syarat_khusus`
--
ALTER TABLE `imb_syarat_khusus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `imb_syarat_khusus_detail`
--
ALTER TABLE `imb_syarat_khusus_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `imb_syarat_umum`
--
ALTER TABLE `imb_syarat_umum`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `imb_syarat_umum_detail`
--
ALTER TABLE `imb_syarat_umum_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `imb_umum`
--
ALTER TABLE `imb_umum`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pemohon_data_bangunan`
--
ALTER TABLE `pemohon_data_bangunan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pemohon_data_bangunan_renovasi`
--
ALTER TABLE `pemohon_data_bangunan_renovasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pemohon_data_diri`
--
ALTER TABLE `pemohon_data_diri`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pemohon_data_lahan`
--
ALTER TABLE `pemohon_data_lahan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `perizinan_jenis`
--
ALTER TABLE `perizinan_jenis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `perizinan_paket`
--
ALTER TABLE `perizinan_paket`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permohonan`
--
ALTER TABLE `permohonan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `zona`
--
ALTER TABLE `zona`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `zona_sub`
--
ALTER TABLE `zona_sub`
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
-- AUTO_INCREMENT for table `imb_spasial`
--
ALTER TABLE `imb_spasial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `imb_spasial_itbx`
--
ALTER TABLE `imb_spasial_itbx`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `imb_spasial_itbx_detail`
--
ALTER TABLE `imb_spasial_itbx_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `imb_syarat_khusus`
--
ALTER TABLE `imb_syarat_khusus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `imb_syarat_khusus_detail`
--
ALTER TABLE `imb_syarat_khusus_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `imb_syarat_umum`
--
ALTER TABLE `imb_syarat_umum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `imb_syarat_umum_detail`
--
ALTER TABLE `imb_syarat_umum_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `imb_umum`
--
ALTER TABLE `imb_umum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pemohon_data_bangunan`
--
ALTER TABLE `pemohon_data_bangunan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pemohon_data_bangunan_renovasi`
--
ALTER TABLE `pemohon_data_bangunan_renovasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pemohon_data_diri`
--
ALTER TABLE `pemohon_data_diri`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pemohon_data_lahan`
--
ALTER TABLE `pemohon_data_lahan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `perizinan_jenis`
--
ALTER TABLE `perizinan_jenis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=439;

--
-- AUTO_INCREMENT for table `perizinan_paket`
--
ALTER TABLE `perizinan_paket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `permohonan`
--
ALTER TABLE `permohonan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `zona`
--
ALTER TABLE `zona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `zona_sub`
--
ALTER TABLE `zona_sub`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
