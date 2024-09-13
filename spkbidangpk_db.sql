-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 13, 2024 at 03:37 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spkbidangpk_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang_pengawasan`
--

CREATE TABLE `barang_pengawasan` (
  `id` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  `pelaku_usaha_id` int(11) NOT NULL,
  `penanggung_jawab` varchar(255) DEFAULT NULL,
  `nama_barang` varchar(255) DEFAULT NULL,
  `merk_barang` varchar(255) DEFAULT NULL,
  `sni` varchar(50) DEFAULT 'Tidak Dicek',
  `mkg` varchar(50) DEFAULT 'Tidak Dicek',
  `label` varchar(50) DEFAULT 'Tidak Dicek',
  `k3l` varchar(50) DEFAULT 'Tidak Dicek',
  `keterangan` text DEFAULT NULL,
  `berkas_hasil_pengawasan` varchar(255) DEFAULT NULL,
  `nama_distributor` varchar(255) DEFAULT NULL,
  `bukti_pengembalian_barang` varchar(255) DEFAULT NULL,
  `jenis_pelanggaran` varchar(255) DEFAULT NULL,
  `tindak_lanjut_pelanggaran` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `barang_pengawasan`
--

INSERT INTO `barang_pengawasan` (`id`, `log_id`, `pelaku_usaha_id`, `penanggung_jawab`, `nama_barang`, `merk_barang`, `sni`, `mkg`, `label`, `k3l`, `keterangan`, `berkas_hasil_pengawasan`, `nama_distributor`, `bukti_pengembalian_barang`, `jenis_pelanggaran`, `tindak_lanjut_pelanggaran`) VALUES
(1, 64, 9, 'Adiyatma Pratama W.', 'Barang F', 'Merk F', 'Sesuai', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'ABCD', 'file_buktipelanggaran_example.pdf', NULL, NULL, NULL, NULL),
(2, 64, 9, 'Andi Setiawan', 'Barang G', 'Merk G', 'Tidak Dicek', 'Tidak Sesuai', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(3, 64, 9, 'Fajar Nugroho', 'Barang H', 'Merk H', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(6, 64, 1, 'Adiyatma Pratama W.', 'Barang A', 'Merk A', 'Tidak Sesuai', 'Tidak Sesuai', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(7, 64, 9, 'Andi Setiawan', 'Barang I', 'Merk I', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(8, 64, 1, 'Fajar Nugroho', 'Barang B', 'Merk B', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(9, 64, 3, 'Gita Lestari', 'Barang C', 'Merk C', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(10, 64, 1, 'Dian Sari', 'Barang AA', 'Merk AA', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(11, 64, 1, 'Adiyatma Pratama W.', 'Barang BB', 'Merk BB', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(12, 64, 1, 'Fajar Nugroho', 'Barang AB', 'Merk AB', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(14, 64, 1, 'Fajar Nugroho', 'Barang BC', 'Merk BC', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(15, 64, 1, 'Adiyatma Pratama W.', 'Barang CC', 'Merk CC', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(16, 64, 1, 'Fajar Nugroho', 'Barang AD', 'Merk AD', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(17, 64, 1, 'Gita Lestari', 'Barang AE', 'Merk AE', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(18, 64, 1, 'Gita Lestari', 'FF', 'FF', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(19, 64, 3, 'Adiyatma Pratama W.', 'DDD', 'DDD', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', NULL, NULL, NULL, NULL, NULL, NULL),
(20, 64, 1, 'Adiyatma Pratama W.', 'EEE', 'EEE', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL),
(21, 64, 2, 'Adiyatma Pratama W.', 'FED', 'FED', 'Tidak Dicek', 'Tidak Sesuai', 'Tidak Dicek', 'Tidak Dicek', 'None', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `biaya_transportasi`
--

CREATE TABLE `biaya_transportasi` (
  `id` int(11) NOT NULL,
  `nama_daerah` varchar(255) DEFAULT NULL,
  `harga_tol` float DEFAULT NULL,
  `total_biaya_transportasi` int(11) DEFAULT NULL,
  `estimasi_perjalanan` float DEFAULT NULL,
  `total_biaya_bahan_bakar` int(11) DEFAULT NULL,
  `jarak_daerah` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `biaya_transportasi`
--

INSERT INTO `biaya_transportasi` (`id`, `nama_daerah`, `harga_tol`, `total_biaya_transportasi`, `estimasi_perjalanan`, `total_biaya_bahan_bakar`, `jarak_daerah`) VALUES
(1, 'Kota Cirebon', 159000, 759000, 2.05, 600000, 140),
(2, 'Kota Tasikmalaya', 5000, 605000, 2.45, 600000, 110),
(3, 'Kota Banjar', 5000, 605000, 3.18, 600000, 146),
(4, 'Kota Bandung', 0, 350000, 0.25, 350000, 10),
(5, 'Kota Bekasi', 133000, 733000, 2.18, 600000, 132),
(6, 'Kota Depok', 141000, 841000, 2.36, 700000, 166),
(7, 'Kabupaten Bogor', 89000, 789000, 2.56, 700000, 187),
(8, 'Kota Cimahi', 0, 350000, 0.33, 350000, 11.4),
(9, 'Kota Sukabumi', 4000, 454000, 2.15, 450000, 94.8),
(10, 'Kabupaten Bandung Barat', 0, 350000, 0.27, 350000, 17.3),
(11, 'Kabupaten Purwakarta', 32000, 482000, 1.08, 450000, 61.2),
(12, 'Kabupaten Karawang', 56500, 506500, 1.3, 450000, 91.8),
(13, 'Kabupaten Bandung', 0, 350000, 1.27, 350000, 51.1),
(14, 'Kabupaten Subang', 0, 350000, 1.28, 350000, 58.7),
(15, 'Kabupaten Indramayu', 140500, 740500, 2.32, 600000, 145),
(16, 'Kabupaten Sumedang', 5000, 355000, 0.59, 350000, 58.6),
(17, 'Kabupaten Majalengka', 126000, 726000, 1.44, 600000, 106),
(18, 'Kabupaten Cirebon', 124500, 724500, 1.56, 600000, 130),
(19, 'Kabupaten Kuningan', 124500, 824500, 2.39, 700000, 166),
(20, 'Kabupaten Ciamis', 5000, 605000, 2.46, 600000, 121),
(21, 'Kabupaten Tasikmalaya', 5000, 605000, 3.56, 600000, 153),
(22, 'Kabupaten Garut', 5000, 605000, 3.55, 600000, 135),
(23, 'Kabupaten Cianjur', 4000, 454000, 1.24, 450000, 64.6),
(24, 'Kabupaten Bekasi', 133000, 733000, 1.52, 600000, 108),
(25, 'Kabupaten Pangandaran', 5000, 705000, 4.42, 700000, 193),
(26, 'Kota Bogor', 89000, 789000, 2.5, 700000, 181),
(27, 'Kabupaten Sukabumi', 4000, 454000, 2.23, 450000, 99.4);

-- --------------------------------------------------------

--
-- Table structure for table `bobot_kriteria`
--

CREATE TABLE `bobot_kriteria` (
  `id` int(11) NOT NULL,
  `kriteria` varchar(255) DEFAULT NULL,
  `nilai_kriteria` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bobot_kriteria`
--

INSERT INTO `bobot_kriteria` (`id`, `kriteria`, `nilai_kriteria`) VALUES
(1, 'Biaya Transportasi', 0.4),
(2, 'Jarak Daerah', 0.25),
(3, 'Estimasi Perjalanan', 0.35);

-- --------------------------------------------------------

--
-- Table structure for table `data_pegawai`
--

CREATE TABLE `data_pegawai` (
  `id` int(11) NOT NULL,
  `nama_pegawai` varchar(100) NOT NULL,
  `nip` varchar(50) NOT NULL,
  `jabatan` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `data_pegawai`
--

INSERT INTO `data_pegawai` (`id`, `nama_pegawai`, `nip`, `jabatan`) VALUES
(72, 'Andi Setiawan', '1234567890', 'Kepala'),
(73, 'Budi Santoso', '0987654321', 'Wakil Kepala Bidang'),
(74, 'Adiyatma Pratama W.', '2345678901', 'Staf Anggota'),
(75, 'Dian Sari', '9876543210', 'Staf Anggota'),
(76, 'Eko Prasetyo', '3456789012', 'Staf Anggota'),
(77, 'Fajar Nugroho', '8765432109', 'Staf Anggota'),
(78, 'Gita Lestari', '4567890123', 'Staf Anggota'),
(79, 'Hadi Wibowo', '7654321098', 'Staf Anggota'),
(80, 'Indah Permata', '5678901234', 'Staf Anggota'),
(81, 'Joko Widodo', '6543210987', 'Staf Anggota'),
(82, 'Kiki Amalia', '6789012345', 'Staf Anggota'),
(83, 'Lina Marlina', '5432109876', 'Staf Anggota'),
(84, 'Mira Puspita', '7890123456', 'Staf Anggota'),
(85, 'Nina Kartika', '4321098765', 'Staf Anggota'),
(86, 'Oki Susanto', '8901234567', 'Staf Anggota'),
(87, 'Putri Anindya', '3210987654', 'Staf Anggota'),
(88, 'Rudi Hartono', '9012345678', 'Staf Anggota'),
(89, 'Sari Ayu', '2109876543', 'Staf Anggota'),
(90, 'Toni Gunawan', '0123456789', 'Staf Anggota'),
(91, 'Yudi Prasetyo', '1123456789', 'Lainnya'),
(93, 'Rahmat Wijaya', '12090909', 'Staf Anggota'),
(96, 'Zulvan F', '12412559823', 'Lainnya');

-- --------------------------------------------------------

--
-- Table structure for table `hasilperencanaan`
--

CREATE TABLE `hasilperencanaan` (
  `id` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  `nama_daerah` varchar(255) NOT NULL,
  `nama_pelaku_usaha_1` varchar(255) DEFAULT NULL,
  `nama_pelaku_usaha_2` varchar(255) DEFAULT NULL,
  `pelaku_usaha_id_1` int(11) DEFAULT NULL,
  `pelaku_usaha_id_2` int(11) DEFAULT NULL,
  `status_lokasi_1` varchar(50) DEFAULT 'Belum Terawasi',
  `status_lokasi_2` varchar(50) DEFAULT 'Belum Terawasi',
  `pengawas_1` varchar(255) DEFAULT NULL,
  `pengawas_2` varchar(255) DEFAULT NULL,
  `pengawas_3` varchar(255) DEFAULT NULL,
  `pengawas_4` varchar(255) DEFAULT NULL,
  `anggaran_biaya` float NOT NULL,
  `status_pengawasan` varchar(255) DEFAULT NULL,
  `catatan` text DEFAULT NULL,
  `status_pelanggaran` varchar(50) DEFAULT NULL,
  `status_tindak_lanjut_pelanggaran` varchar(255) DEFAULT NULL,
  `indikasi_pelanggaran` varchar(50) NOT NULL DEFAULT 'Tidak'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hasilperencanaan`
--

INSERT INTO `hasilperencanaan` (`id`, `log_id`, `nama_daerah`, `nama_pelaku_usaha_1`, `nama_pelaku_usaha_2`, `pelaku_usaha_id_1`, `pelaku_usaha_id_2`, `status_lokasi_1`, `status_lokasi_2`, `pengawas_1`, `pengawas_2`, `pengawas_3`, `pengawas_4`, `anggaran_biaya`, `status_pengawasan`, `catatan`, `status_pelanggaran`, `status_tindak_lanjut_pelanggaran`, `indikasi_pelanggaran`) VALUES
(1, 64, 'Kota Bandung', 'Toko A', 'Toko B', 1, 2, 'Sudah Terawasi', 'Sudah Terawasi', 'Gita Lestari', 'Adiyatma Pratama W.', 'Fajar Nugroho', 'Dian Sari', 350000, 'Selesai Terawasi', '', 'Tidak Ada', 'Surat Peringatan', 'Ya'),
(2, 64, 'Kabupaten Bandung', 'Toko C', 'Toko D', 3, 4, 'Belum Terawasi', 'Belum Terawasi', 'Adiyatma Pratama W.', 'Andi Setiawan', 'Gita Lestari', 'Sari Ayu', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(3, 64, 'Kota Bekasi', NULL, NULL, 5, 6, 'Belum Terawasi', 'Belum Terawasi', 'Mira Puspita', 'Lina Marlina', 'Andi Setiawan', 'Adiyatma Pratama W.', 733000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(4, 64, 'Kabupaten Bekasi', NULL, NULL, 7, 8, 'Belum Terawasi', 'Belum Terawasi', 'Zulvan F', 'Lina Marlina', 'Toni Gunawan', 'Gita Lestari', 733000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(5, 64, 'Kota Bogor', NULL, NULL, 9, 10, 'Sudah Terawasi', 'Belum Terawasi', 'Adiyatma Pratama W.', 'Andi Setiawan', 'Budi Santoso', 'Fajar Nugroho', 789000, 'Terawasi Sebagian', '', 'Tidak Ada', NULL, 'Ya'),
(6, 64, 'Kabupaten Bogor', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 789000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(7, 64, 'Kota Cimahi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(8, 64, 'Kabupaten Cirebon', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 724500, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(9, 64, 'Kota Cirebon', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 759000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(10, 64, 'Kota Depok', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 841000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(11, 64, 'Kota Sukabumi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 454000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(12, 64, 'Kabupaten Sukabumi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 454000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(13, 64, 'Kota Tasikmalaya', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(14, 64, 'Kabupaten Tasikmalaya', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(15, 64, 'Kabupaten Bandung Barat', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(16, 64, 'Kabupaten Ciamis', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(17, 64, 'Kabupaten Cianjur', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 454000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(18, 64, 'Kabupaten Garut', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(19, 64, 'Kabupaten Indramayu', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 740500, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(20, 64, 'Kabupaten Karawang', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 506500, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(21, 64, 'Kabupaten Kuningan', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 824500, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(22, 64, 'Kabupaten Majalengka', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 726000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(23, 64, 'Kabupaten Pangandaran', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 705000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(24, 64, 'Kabupaten Purwakarta', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 482000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(25, 64, 'Kabupaten Subang', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, 'Tidak'),
(26, 64, 'Kabupaten Sumedang', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 355000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(27, 64, 'Kabupaten Indramayu', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 740500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(33, 84, 'Kota Bandung', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(34, 84, 'Kabupaten Bandung', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(35, 84, 'Kota Bekasi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 733000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(36, 84, 'Kabupaten Bekasi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 733000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(37, 84, 'Kota Bogor', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 789000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(38, 84, 'Kabupaten Bogor', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 789000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(39, 84, 'Kota Cimahi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(40, 84, 'Kabupaten Cirebon', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 724500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(41, 84, 'Kota Cirebon', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 759000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(42, 84, 'Kota Depok', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 841000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(43, 84, 'Kota Sukabumi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 454000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(44, 84, 'Kabupaten Sukabumi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 454000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(45, 84, 'Kota Tasikmalaya', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(46, 84, 'Kabupaten Tasikmalaya', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(47, 84, 'Kabupaten Bandung Barat', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(48, 84, 'Kabupaten Ciamis', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(49, 84, 'Kabupaten Cianjur', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 454000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(50, 84, 'Kabupaten Garut', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(51, 84, 'Kabupaten Indramayu', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 740500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(52, 84, 'Kabupaten Karawang', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 506500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(53, 84, 'Kabupaten Kuningan', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 824500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(54, 84, 'Kabupaten Majalengka', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 726000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(55, 84, 'Kabupaten Pangandaran', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 705000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(56, 84, 'Kabupaten Purwakarta', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 482000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(57, 84, 'Kabupaten Subang', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(58, 84, 'Kabupaten Sumedang', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 355000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(59, 84, 'Kabupaten Indramayu', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 740500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(60, 85, 'Kota Bandung', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(61, 85, 'Kabupaten Bandung', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(62, 85, 'Kota Bekasi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 733000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(63, 85, 'Kabupaten Bekasi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 733000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(64, 85, 'Kota Bogor', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 789000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(65, 85, 'Kabupaten Bogor', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 789000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(66, 85, 'Kota Cimahi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(67, 85, 'Kabupaten Cirebon', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 724500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(68, 85, 'Kota Cirebon', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 759000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(69, 85, 'Kota Depok', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 841000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(70, 85, 'Kota Sukabumi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 454000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(71, 85, 'Kabupaten Sukabumi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 454000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(72, 85, 'Kota Tasikmalaya', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(73, 85, 'Kabupaten Tasikmalaya', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(74, 85, 'Kabupaten Bandung Barat', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(75, 85, 'Kabupaten Ciamis', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(76, 85, 'Kabupaten Cianjur', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 454000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(77, 85, 'Kabupaten Garut', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(78, 85, 'Kabupaten Indramayu', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 740500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(79, 85, 'Kabupaten Karawang', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 506500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(80, 85, 'Kabupaten Kuningan', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 824500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(81, 85, 'Kabupaten Majalengka', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 726000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(82, 85, 'Kabupaten Pangandaran', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 705000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(83, 85, 'Kabupaten Purwakarta', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 482000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(84, 85, 'Kabupaten Subang', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(85, 85, 'Kabupaten Sumedang', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 355000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(86, 85, 'Kabupaten Indramayu', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 740500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(87, 86, 'Kota Bandung', NULL, NULL, 1, 2, 'Belum Terawasi', 'Belum Terawasi', 'Gita Lestari', 'Budi Santoso', 'Mira Puspita', 'Nina Kartika', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(88, 86, 'Kabupaten Bandung', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(89, 86, 'Kota Bekasi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 733000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(90, 86, 'Kabupaten Bekasi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 733000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(91, 86, 'Kota Bogor', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 789000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(92, 86, 'Kabupaten Bogor', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 789000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(93, 86, 'Kota Cimahi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(94, 86, 'Kabupaten Cirebon', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 724500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(95, 86, 'Kota Cirebon', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 759000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(96, 86, 'Kota Depok', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 841000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(97, 86, 'Kota Sukabumi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 454000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(98, 86, 'Kabupaten Sukabumi', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 454000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(99, 86, 'Kota Tasikmalaya', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(100, 86, 'Kabupaten Tasikmalaya', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(101, 86, 'Kabupaten Bandung Barat', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(102, 86, 'Kabupaten Ciamis', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(103, 86, 'Kabupaten Cianjur', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 454000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(104, 86, 'Kabupaten Garut', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 605000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(105, 86, 'Kabupaten Indramayu', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 740500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(106, 86, 'Kabupaten Karawang', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 506500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(107, 86, 'Kabupaten Kuningan', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 824500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(108, 86, 'Kabupaten Majalengka', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 726000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(109, 86, 'Kabupaten Pangandaran', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 705000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(110, 86, 'Kabupaten Purwakarta', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 482000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(111, 86, 'Kabupaten Subang', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 350000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(112, 86, 'Kabupaten Sumedang', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 355000, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0'),
(113, 86, 'Kabupaten Indramayu', NULL, NULL, NULL, NULL, 'Belum Terawasi', 'Belum Terawasi', '', '', '', '', 740500, 'Belum Terawasi', '', 'Tidak Ada', NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `hasilperhitungan`
--

CREATE TABLE `hasilperhitungan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `log_id` bigint(20) DEFAULT NULL,
  `nama_daerah` varchar(100) DEFAULT NULL,
  `weighted_sum` float DEFAULT NULL,
  `adjusted_weighted_sum` float DEFAULT NULL,
  `anggaran_biaya` float DEFAULT NULL,
  `peringkat` int(11) DEFAULT NULL,
  `jumlah_lokasi` int(11) DEFAULT NULL,
  `nama_pelaku_usaha` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status_lokasi` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`status_lokasi`)),
  `pengawas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`pengawas`)),
  `status_pengawasan` varchar(50) DEFAULT 'Belum',
  `catatan` text DEFAULT NULL,
  `gagal` tinyint(1) DEFAULT 0,
  `terdapat_pelanggaran` tinyint(1) DEFAULT 0,
  `status_pelanggaran` varchar(255) DEFAULT 'Tidak Ada',
  `status_tindak_lanjut_pelanggaran` varchar(255) DEFAULT 'Tidak Ada',
  `indikasi_pelanggaran` varchar(10) DEFAULT 'Tidak'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hasilperhitungan`
--

INSERT INTO `hasilperhitungan` (`id`, `log_id`, `nama_daerah`, `weighted_sum`, `adjusted_weighted_sum`, `anggaran_biaya`, `peringkat`, `jumlah_lokasi`, `nama_pelaku_usaha`, `status_lokasi`, `pengawas`, `status_pengawasan`, `catatan`, `gagal`, `terdapat_pelanggaran`, `status_pelanggaran`, `status_tindak_lanjut_pelanggaran`, `indikasi_pelanggaran`) VALUES
(244, 35, 'Kota Bandung', 0.8, NULL, 350000, 1, 4, '[\"\", \"\", \"\", \"\"]', '[\"1\", \"0\", \"0\", \"0\"]', '[\"ZZ\", \"\", \"\", \"\"]', 'Belum', 'AAA', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(245, 35, 'Kabupaten Bandung Barat', 0.735581, NULL, 350000, 2, 4, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 1, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(246, 35, 'Kota Cimahi', 0.714992, NULL, 350000, 3, 4, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 1, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(247, 35, 'Kabupaten Sumedang', 0.53855, NULL, 355000, 4, 4, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(248, 35, 'Kabupaten Bandung', 0.478625, NULL, 350000, 5, 4, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(249, 35, 'Kabupaten Subang', 0.47563, NULL, 350000, 6, 4, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(250, 35, 'Kabupaten Cianjur', 0.384334, NULL, 454000, 7, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(251, 35, 'Kabupaten Purwakarta', 0.376241, NULL, 482000, 8, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(252, 35, 'Kota Sukabumi', 0.353802, NULL, 454000, 9, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(253, 35, 'Kabupaten Sukabumi', 0.352063, NULL, 454000, 10, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(254, 35, 'Kabupaten Karawang', 0.344992, NULL, 506500, 11, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(255, 35, 'Kota Tasikmalaya', 0.271108, NULL, 605000, 12, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(256, 35, 'Kabupaten Ciamis', 0.270157, NULL, 605000, 13, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(257, 35, 'Kota Banjar', 0.261839, NULL, 605000, 14, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(258, 35, 'Kabupaten Garut', 0.259939, NULL, 605000, 15, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(259, 35, 'Kabupaten Tasikmalaya', 0.259008, NULL, 605000, 16, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(260, 35, 'Kabupaten Majalengka', 0.254355, NULL, 726000, 17, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(261, 35, 'Kabupaten Bekasi', 0.249597, NULL, 733000, 18, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(262, 35, 'Kabupaten Cirebon', 0.249006, NULL, 724500, 19, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(263, 35, 'Kota Bekasi', 0.232975, NULL, 733000, 20, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(264, 35, 'Kabupaten Indramayu', 0.228286, NULL, 740500, 21, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(265, 35, 'Kota Cirebon', 0.228181, NULL, 759000, 22, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(266, 35, 'Kabupaten Pangandaran', 0.220731, NULL, 705000, 23, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(267, 35, 'Kota Bogor', 0.212965, NULL, 789000, 24, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(268, 35, 'Kabupaten Bogor', 0.212084, NULL, 789000, 25, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(269, 35, 'Kabupaten Kuningan', 0.207205, NULL, 824500, 26, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(270, 35, 'Kota Depok', 0.204272, NULL, 841000, 27, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(514, 45, 'Kota Bandung', 0.8, 0, 350000, 6, 4, '[\"Borma\", \"Transmart\", \"B Mart\", \"Griya\"]', '[\"1\", \"1\", \"1\", \"1\"]', '[\"Zulvan\", \"Saka\", \"Rahmat\", \"Adiyatma\"]', 'Selesai', 'Gagal dilakukan pengawasan pada periode sebelumnya.', 1, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(515, 45, 'Kabupaten Bandung Barat', 0.735581, 0, 350000, 7, 4, '[\"Star Mall\", \"Budget Mart\", \"Pure Market\", \"Nova Mall\"]', '[\"1\", \"1\", \"1\", \"1\"]', '[\"Zaidan\", \"Furqon\", \"Farras\", \"Vemi\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(516, 45, 'Kota Cimahi', 0.714992, 0, 350000, 8, 4, '[\"Bright Mart\", \"Elite Supermarket\", \"EcoMart\", \"Fusion Plaza\"]', '[\"1\", \"1\", \"1\", \"1\"]', '[\"Januar\", \"Bagas\", \"Vanessa\", \"Kayla\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(517, 45, 'Kabupaten Sumedang', 0.53855, 0, 355000, 9, 4, '[\"Harmony Market\", \"Gold Mall\", \"Trendy Supermarket\", \"Quick Shop\"]', '[\"1\", \"1\", \"1\", \"1\"]', '[\"Layla\", \"Arkan\", \"Arya\", \"Santhy\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(518, 45, 'Kabupaten Bandung', 0.478625, 0, 350000, 10, 4, '[\"Victory Mall\", \"Nova Mart\", \"Permata Mart\", \"Kuda Store\"]', '[\"1\", \"1\", \"1\", \"1\"]', '[\"Rudi\", \"Dodi\", \"Bagas\", \"Luna\"]', 'Selesai', 'None', 0, 1, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(519, 45, 'Kabupaten Subang', 0.47563, 1.47563, 350000, 1, 4, '[\"Mega Mart\", \"Super Store\", \"Family Mart\", \"Happy Shop\"]', '[\"1\", \"1\", \"1\", \"0\"]', '[\"Zaidan\", \"Fadhil\", \"Antonio\", \"Aqli\"]', 'Sebagian', 'None', 0, 1, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(520, 45, 'Kabupaten Cianjur', 0.384334, 0, 454000, 11, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(521, 45, 'Kabupaten Purwakarta', 0.376241, 0, 482000, 12, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(522, 45, 'Kota Sukabumi', 0.353802, 0, 454000, 13, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(523, 45, 'Kabupaten Sukabumi', 0.352063, 0.352063, 454000, 4, 3, '[\"Fresh Mart\", \"Prime Plaza\", \"Grand Bazaar\", \"\"]', '[\"0\", \"1\", \"0\", \"0\"]', '[\"Zaidan\", \"Fadhil\", \"Adiyatma\", \"Aulia\"]', 'Sebagian', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(524, 45, 'Kabupaten Karawang', 0.344992, 1.34499, 506500, 2, 3, '[\"City Mall\", \"Rainbow Mart\", \"Sunny Supermarket\", \"\"]', '[\"0\", \"1\", \"1\", \"0\"]', '[\"Dimas\", \"Deni\", \"Fauzan\", \"Reni\"]', 'Sebagian', 'None', 0, 1, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(525, 45, 'Kota Tasikmalaya', 0.271108, 1.27111, 605000, 3, 3, '[\"Daily Goods\", \"Urban Mall\", \"Green Market\", \"\"]', '[\"0\", \"1\", \"0\", \"0\"]', '[\"Juan\", \"Bima\", \"Arya\", \"Layla\"]', 'Sebagian', 'None', 0, 1, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(526, 45, 'Kabupaten Ciamis', 0.270157, 0.270157, 605000, 5, 3, '[\"Shop Ease\", \"Town Square\", \"Royal Market\", \"\"]', '[\"0\", \"1\", \"1\", \"0\"]', '[\"Antonio\", \"Zulvan\", \"Aqli\", \"Vemi\"]', 'Sebagian', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(527, 45, 'Kota Banjar', 0.261839, 0, 605000, 14, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(528, 45, 'Kabupaten Garut', 0.259939, 0, 605000, 15, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(529, 45, 'Kabupaten Tasikmalaya', 0.259008, 0, 605000, 16, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 1, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(530, 45, 'Kabupaten Majalengka', 0.254355, 0, 726000, 17, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(531, 45, 'Kabupaten Bekasi', 0.249597, 0, 733000, 18, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(532, 45, 'Kabupaten Cirebon', 0.249006, 0, 724500, 19, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(533, 45, 'Kota Bekasi', 0.232975, 0, 733000, 20, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(534, 45, 'Kabupaten Indramayu', 0.228286, 0, 740500, 21, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(535, 45, 'Kota Cirebon', 0.228181, 0, 759000, 22, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 1, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(536, 45, 'Kabupaten Pangandaran', 0.220731, 0, 705000, 23, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(537, 45, 'Kota Bogor', 0.212965, 0, 789000, 24, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(538, 45, 'Kabupaten Bogor', 0.212084, 0, 789000, 25, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(539, 45, 'Kabupaten Kuningan', 0.207205, 0, 824500, 26, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 1, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(540, 45, 'Kota Depok', 0.204272, 0, 841000, 27, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(865, 58, 'Kota Bandung', 1, 0, 350000, 14, 4, '[\"Toko 1\", \"Mal 1\", \"Toko 2\", \"Supermarket 1\"]', '[\"1\", \"1\", \"1\", \"1\"]', '[\"AA\", \"AB\", \"AC\", \"AD\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(866, 58, 'Kota Cimahi', 0.88445, 1.88445, 350000, 1, 4, '[\"\", \"\", \"\", \"\"]', '[\"1\", \"1\", \"1\", \"0\"]', '[\"A\", \"\", \"\", \"\"]', 'Sebagian', 'Gagal dan Terdapat Pelanggaran.', 1, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(867, 58, 'Kabupaten Bandung Barat', 0.868583, 0, 350000, 15, 4, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(868, 58, 'Kabupaten Sumedang', 0.585333, 0, 355000, 16, 4, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(869, 58, 'Kabupaten Bandung', 0.517821, 0, 350000, 17, 4, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(870, 58, 'Kabupaten Subang', 0.510949, 0, 350000, 18, 4, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(871, 58, 'Kabupaten Cianjur', 0.417634, 0, 454000, 19, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(872, 58, 'Kabupaten Purwakarta', 0.412325, 0, 482000, 20, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(873, 58, 'Kota Sukabumi', 0.375439, 0, 454000, 21, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(874, 58, 'Kabupaten Sukabumi', 0.372759, 0, 454000, 22, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(875, 58, 'Kabupaten Karawang', 0.370948, 0, 506500, 23, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(876, 58, 'Kota Tasikmalaya', 0.289847, 0, 605000, 24, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(877, 58, 'Kabupaten Ciamis', 0.287635, 0.287635, 605000, 2, 3, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 1, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(878, 58, 'Kabupaten Majalengka', 0.277186, 0.277186, 726000, 3, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Sebagian', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(879, 58, 'Kota Banjar', 0.276044, 0.276044, 605000, 4, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Sebagian', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(880, 58, 'Kabupaten Garut', 0.274571, 0.274571, 605000, 5, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(881, 58, 'Kabupaten Tasikmalaya', 0.272323, 0.272323, 605000, 6, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Sebagian', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(882, 58, 'Kabupaten Bekasi', 0.27171, 0.27171, 733000, 7, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(883, 58, 'Kabupaten Cirebon', 0.268557, 0.268557, 724500, 8, 2, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Sebagian', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(884, 58, 'Kota Bekasi', 0.250073, 0.250073, 733000, 9, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(885, 58, 'Kota Cirebon', 0.244993, 0.244993, 759000, 10, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(886, 58, 'Kabupaten Indramayu', 0.244018, 0.244018, 740500, 11, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Sebagian', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(887, 58, 'Kabupaten Pangandaran', 0.231331, 0.231331, 705000, 12, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Sebagian', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(888, 58, 'Kota Bogor', 0.226252, 0.226252, 789000, 13, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(889, 58, 'Kabupaten Bogor', 0.224988, 0, 789000, 25, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(890, 58, 'Kabupaten Kuningan', 0.221471, 0, 824500, 26, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(891, 58, 'Kota Depok', 0.218605, 0, 841000, 27, 1, '[\"\", \"\", \"\", \"\"]', '[\"0\", \"0\", \"0\", \"0\"]', '[\"\", \"\", \"\", \"\"]', 'Selesai', 'None', 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(892, 59, 'Kota Bandung', 1, NULL, 350000, 1, 4, '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(893, 59, 'Kota Cimahi', 0.88445, NULL, 350000, 2, 4, '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(894, 59, 'Kabupaten Bandung Barat', 0.868583, NULL, 350000, 3, 4, '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(895, 59, 'Kabupaten Sumedang', 0.585333, NULL, 355000, 4, 4, '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(896, 59, 'Kabupaten Bandung', 0.517821, NULL, 350000, 5, 4, '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(897, 59, 'Kabupaten Subang', 0.510949, NULL, 350000, 6, 4, '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(898, 59, 'Kabupaten Cianjur', 0.417634, NULL, 454000, 7, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(899, 59, 'Kabupaten Purwakarta', 0.412325, NULL, 482000, 8, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(900, 59, 'Kota Sukabumi', 0.375439, NULL, 454000, 9, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(901, 59, 'Kabupaten Sukabumi', 0.372759, NULL, 454000, 10, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(902, 59, 'Kabupaten Karawang', 0.370948, NULL, 506500, 11, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(903, 59, 'Kota Tasikmalaya', 0.289847, NULL, 605000, 12, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(904, 59, 'Kabupaten Ciamis', 0.287635, NULL, 605000, 13, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(905, 59, 'Kabupaten Majalengka', 0.277186, NULL, 726000, 14, 2, '[\"\", \"\"]', '[\"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(906, 59, 'Kota Banjar', 0.276044, NULL, 605000, 15, 2, '[\"\", \"\"]', '[\"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(907, 59, 'Kabupaten Garut', 0.274571, NULL, 605000, 16, 2, '[\"\", \"\"]', '[\"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(908, 59, 'Kabupaten Tasikmalaya', 0.272323, NULL, 605000, 17, 2, '[\"\", \"\"]', '[\"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(909, 59, 'Kabupaten Bekasi', 0.27171, NULL, 733000, 18, 2, '[\"\", \"\"]', '[\"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(910, 59, 'Kabupaten Cirebon', 0.268557, NULL, 724500, 19, 2, '[\"\", \"\"]', '[\"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(911, 59, 'Kota Bekasi', 0.250073, NULL, 733000, 20, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(912, 59, 'Kota Cirebon', 0.244993, NULL, 759000, 21, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(913, 59, 'Kabupaten Indramayu', 0.244018, NULL, 740500, 22, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(914, 59, 'Kabupaten Pangandaran', 0.231331, NULL, 705000, 23, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(915, 59, 'Kota Bogor', 0.226252, NULL, 789000, 24, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(916, 59, 'Kabupaten Bogor', 0.224988, NULL, 789000, 25, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(917, 59, 'Kabupaten Kuningan', 0.221471, NULL, 824500, 26, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(918, 59, 'Kota Depok', 0.218605, NULL, 841000, 27, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(946, 61, 'Kota Bandung', 1, NULL, 350000, 1, 4, '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(947, 61, 'Kota Cimahi', 0.88445, NULL, 350000, 2, 4, '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(948, 61, 'Kabupaten Bandung Barat', 0.868583, NULL, 350000, 3, 4, '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(949, 61, 'Kabupaten Sumedang', 0.585333, NULL, 355000, 4, 4, '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(950, 61, 'Kabupaten Bandung', 0.517821, NULL, 350000, 5, 4, '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(951, 61, 'Kabupaten Subang', 0.510949, NULL, 350000, 6, 4, '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(952, 61, 'Kabupaten Cianjur', 0.417634, NULL, 454000, 7, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(953, 61, 'Kabupaten Purwakarta', 0.412325, NULL, 482000, 8, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(954, 61, 'Kota Sukabumi', 0.375439, NULL, 454000, 9, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(955, 61, 'Kabupaten Sukabumi', 0.372759, NULL, 454000, 10, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(956, 61, 'Kabupaten Karawang', 0.370948, NULL, 506500, 11, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(957, 61, 'Kota Tasikmalaya', 0.289847, NULL, 605000, 12, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(958, 61, 'Kabupaten Ciamis', 0.287635, NULL, 605000, 13, 3, '[\"\", \"\", \"\"]', '[\"\", \"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(959, 61, 'Kabupaten Majalengka', 0.277186, NULL, 726000, 14, 2, '[\"\", \"\"]', '[\"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(960, 61, 'Kota Banjar', 0.276044, NULL, 605000, 15, 2, '[\"\", \"\"]', '[\"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(961, 61, 'Kabupaten Garut', 0.274571, NULL, 605000, 16, 2, '[\"\", \"\"]', '[\"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(962, 61, 'Kabupaten Tasikmalaya', 0.272323, NULL, 605000, 17, 2, '[\"\", \"\"]', '[\"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(963, 61, 'Kabupaten Bekasi', 0.27171, NULL, 733000, 18, 2, '[\"\", \"\"]', '[\"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(964, 61, 'Kabupaten Cirebon', 0.268557, NULL, 724500, 19, 2, '[\"\", \"\"]', '[\"\", \"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(965, 61, 'Kota Bekasi', 0.250073, NULL, 733000, 20, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(966, 61, 'Kota Cirebon', 0.244993, NULL, 759000, 21, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(967, 61, 'Kabupaten Indramayu', 0.244018, NULL, 740500, 22, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(968, 61, 'Kabupaten Pangandaran', 0.231331, NULL, 705000, 23, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(969, 61, 'Kota Bogor', 0.226252, NULL, 789000, 24, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(970, 61, 'Kabupaten Bogor', 0.224988, NULL, 789000, 25, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(971, 61, 'Kabupaten Kuningan', 0.221471, NULL, 824500, 26, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak'),
(972, 61, 'Kota Depok', 0.218605, NULL, 841000, 27, 1, '[\"\"]', '[\"\"]', '[\"\", \"\", \"\", \"\"]', 'Belum', NULL, 0, 0, 'Tidak Ada', 'Tidak Ada', 'Tidak');

-- --------------------------------------------------------

--
-- Table structure for table `logperhitungan`
--

CREATE TABLE `logperhitungan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp(),
  `username` varchar(50) NOT NULL,
  `status` varchar(50) DEFAULT 'Butuh Penanganan'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logperhitungan`
--

INSERT INTO `logperhitungan` (`id`, `tanggal`, `username`, `status`) VALUES
(35, '2024-07-12 12:58:52', 'admin', 'Selesai'),
(45, '2024-07-13 22:37:26', 'admin', 'Selesai'),
(58, '2024-07-15 03:56:58', 'Adiyatma Pratama W.', 'Selesai'),
(59, '2024-07-17 03:31:37', 'Bidang Perlindungan Konsumen', 'Selesai'),
(61, '2024-07-30 03:49:09', 'Bidang Perlindungan Konsumen', 'Butuh Penanganan'),
(62, '2024-08-14 07:04:49', 'Bidang Perlindungan Konsumen', 'Butuh Penanganan'),
(63, '2024-08-14 07:09:00', 'Bidang Perlindungan Konsumen', 'Butuh Penanganan'),
(64, '2024-08-14 07:12:41', 'Bidang Perlindungan Konsumen', 'Sedang Berlangsung'),
(84, '2024-08-28 15:53:09', 'Bidang Perlindungan Konsumen', 'Lengkapi Data'),
(85, '2024-08-28 15:53:54', 'Bidang Perlindungan Konsumen', 'Lengkapi Data'),
(86, '2024-08-28 15:58:35', 'Bidang Perlindungan Konsumen', 'Sedang Berlangsung');

-- --------------------------------------------------------

--
-- Table structure for table `pelakuusaha`
--

CREATE TABLE `pelakuusaha` (
  `id` int(11) NOT NULL,
  `nama_daerah` varchar(255) NOT NULL,
  `nama_pelaku_usaha` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `kategori_usaha` varchar(255) NOT NULL,
  `jumlah_diawasi` int(11) DEFAULT 0,
  `jumlah_pelanggaran` int(11) DEFAULT 0,
  `tanggal_pengawasan` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelakuusaha`
--

INSERT INTO `pelakuusaha` (`id`, `nama_daerah`, `nama_pelaku_usaha`, `alamat`, `kategori_usaha`, `jumlah_diawasi`, `jumlah_pelanggaran`, `tanggal_pengawasan`) VALUES
(1, 'Kota Bandung', 'Toko A', 'Jl. ABC No. 1', 'Bahan Pokok', 2, 2, '2024-08-15 00:33:55'),
(2, 'Kota Bandung', 'Toko B', 'Jl. BCD No. 2', 'Toserba', 2, 3, '2024-08-15 00:33:55'),
(3, 'Kabupaten Bandung', 'Toko C', 'Jl. CDE No. 3', 'Bahan Bangunan', 5, 1, '2024-08-15 00:33:55'),
(4, 'Kabupaten Bandung', 'Toko D', 'Jl. DEF No. 4', 'Farmasi/Apotek', 3, 2, '2024-08-15 00:33:55'),
(5, 'Kota Bekasi', 'Toko E', 'Jl. EFG No. 5', 'Elektronik', 1, 2, '2024-08-15 00:33:55'),
(6, 'Kota Bekasi', 'Toko F', 'Jl. FGH No. 6', 'Pakaian', 1, 4, '2024-08-15 00:33:55'),
(7, 'Kabupaten Bekasi', 'Toko G', 'Jl. GHI No. 7', 'Material Konstruksi', 2, 1, '2024-08-15 00:33:55'),
(8, 'Kabupaten Bekasi', 'Toko H', 'Jl. HIJ No. 8', 'Perlengkapan Rumah Tangga', 2, 1, '2024-08-15 00:33:55'),
(9, 'Kota Bogor', 'Toko I', 'Jl. IJK No. 9', 'Bahan Pokok', 4, 2, '2024-08-15 00:33:55'),
(10, 'Kota Bogor', 'Toko J', 'Jl. JKL No. 10', 'Toserba', 2, 5, '2024-08-15 00:33:55'),
(11, 'Kabupaten Bogor', 'Toko K', 'Jl. KLM No. 11', 'Bahan Bangunan', 0, 0, '2024-08-12 17:05:43'),
(12, 'Kabupaten Bogor', 'Toko L', 'Jl. LMN No. 12', 'Farmasi/Apotek', 0, 0, '2024-08-12 17:05:43'),
(13, 'Kota Cimahi', 'Toko M', 'Jl. MNO No. 13', 'Elektronik', 0, 0, '2024-08-12 17:05:43'),
(14, 'Kota Cimahi', 'Toko N', 'Jl. NOP No. 14', 'Pakaian', 0, 0, '2024-08-12 17:05:43'),
(15, 'Kabupaten Cirebon', 'Toko O', 'Jl. OPQ No. 15', 'Material Konstruksi', 0, 0, '2024-08-12 17:05:43'),
(16, 'Kabupaten Cirebon', 'Toko P', 'Jl. PQR No. 16', 'Perlengkapan Rumah Tangga', 0, 0, '2024-08-12 17:05:43'),
(17, 'Kota Cirebon', 'Toko Q', 'Jl. QRS No. 17', 'Bahan Pokok', 0, 0, '2024-08-12 17:05:43'),
(18, 'Kota Cirebon', 'Toko R', 'Jl. RST No. 18', 'Toserba', 0, 0, '2024-08-12 17:05:43'),
(19, 'Kota Depok', 'Toko S', 'Jl. STU No. 19', 'Bahan Bangunan', 0, 0, '2024-08-12 17:05:43'),
(20, 'Kota Depok', 'Toko T', 'Jl. TUV No. 20', 'Farmasi/Apotek', 0, 0, '2024-08-12 17:05:43'),
(21, 'Kabupaten Sukabumi', 'Toko U', 'Jl. UVW No. 21', 'Elektronik', 0, 0, '2024-08-12 17:05:43'),
(22, 'Kabupaten Sukabumi', 'Toko V', 'Jl. VWX No. 22', 'Pakaian', 0, 0, '2024-08-12 17:05:43'),
(23, 'Kota Tasikmalaya', 'Toko W', 'Jl. WXY No. 23', 'Material Konstruksi', 0, 0, '2024-08-12 17:05:43'),
(24, 'Kota Tasikmalaya', 'Toko X', 'Jl. XYZ No. 24', 'Perlengkapan Rumah Tangga', 0, 0, '2024-08-12 17:05:43'),
(25, 'Kabupaten Tasikmalaya', 'Toko Y', 'Jl. YZA No. 25', 'Bahan Pokok', 0, 0, '2024-08-12 17:05:43'),
(26, 'Kabupaten Tasikmalaya', 'Toko Z', 'Jl. ZAB No. 26', 'Toserba', 0, 0, '2024-08-12 17:05:43'),
(27, 'Kabupaten Bandung Barat', 'Toko AA', 'Jl. AAB No. 27', 'Bahan Bangunan', 0, 0, '2024-08-12 17:05:43'),
(28, 'Kabupaten Bandung Barat', 'Toko AB', 'Jl. ABC No. 28', 'Farmasi/Apotek', 0, 0, '2024-08-12 17:05:43'),
(29, 'Kabupaten Ciamis', 'Toko AC', 'Jl. ACC No. 29', 'Elektronik', 0, 0, '2024-08-12 17:05:43'),
(30, 'Kabupaten Ciamis', 'Toko AD', 'Jl. ADD No. 30', 'Pakaian', 0, 0, '2024-08-12 17:05:43'),
(31, 'Kabupaten Cianjur', 'Toko AE', 'Jl. AEE No. 31', 'Material Konstruksi', 0, 0, '2024-08-12 17:05:43'),
(32, 'Kabupaten Cianjur', 'Toko AF', 'Jl. AFF No. 32', 'Perlengkapan Rumah Tangga', 0, 0, '2024-08-12 17:05:43'),
(33, 'Kabupaten Garut', 'Toko AG', 'Jl. AGG No. 33', 'Bahan Pokok', 0, 0, '2024-08-12 17:05:43'),
(34, 'Kabupaten Garut', 'Toko AH', 'Jl. AHH No. 34', 'Toserba', 0, 0, '2024-08-12 17:05:43'),
(35, 'Kabupaten Indramayu', 'Toko AI', 'Jl. AII No. 35', 'Bahan Bangunan', 0, 0, '2024-08-12 17:05:43'),
(36, 'Kabupaten Indramayu', 'Toko AJ', 'Jl. AJJ No. 36', 'Farmasi/Apotek', 0, 0, '2024-08-12 17:05:43'),
(37, 'Kabupaten Karawang', 'Toko AK', 'Jl. AKK No. 37', 'Elektronik', 0, 0, '2024-08-12 17:05:43'),
(38, 'Kabupaten Karawang', 'Toko AL', 'Jl. ALL No. 38', 'Pakaian', 0, 0, '2024-08-12 17:05:43'),
(39, 'Kabupaten Kuningan', 'Toko AM', 'Jl. AMM No. 39', 'Material Konstruksi', 0, 0, '2024-08-12 17:05:43'),
(40, 'Kabupaten Kuningan', 'Toko AN', 'Jl. ANN No. 40', 'Perlengkapan Rumah Tangga', 0, 0, '2024-08-12 17:05:43'),
(41, 'Kabupaten Majalengka', 'Toko AO', 'Jl. AOO No. 41', 'Bahan Pokok', 0, 0, '2024-08-12 17:05:43'),
(42, 'Kabupaten Majalengka', 'Toko AP', 'Jl. APP No. 42', 'Toserba', 0, 0, '2024-08-12 17:05:43'),
(43, 'Kabupaten Pangandaran', 'Toko AQ', 'Jl. AQQ No. 43', 'Bahan Bangunan', 0, 0, '2024-08-12 17:05:43'),
(44, 'Kabupaten Pangandaran', 'Toko AR', 'Jl. ARR No. 44', 'Farmasi/Apotek', 0, 0, '2024-08-12 17:05:43'),
(45, 'Kabupaten Purwakarta', 'Toko AS', 'Jl. ASS No. 45', 'Elektronik', 0, 0, '2024-08-12 17:05:43'),
(46, 'Kabupaten Purwakarta', 'Toko AT', 'Jl. ATT No. 46', 'Pakaian', 0, 0, '2024-08-12 17:05:43'),
(47, 'Kabupaten Subang', 'Toko AU', 'Jl. AUU No. 47', 'Material Konstruksi', 0, 0, '2024-08-12 17:05:43'),
(48, 'Kabupaten Subang', 'Toko AV', 'Jl. AVV No. 48', 'Perlengkapan Rumah Tangga', 0, 0, '2024-08-12 17:05:43'),
(49, 'Kabupaten Sumedang', 'Toko AW', 'Jl. AWW No. 49', 'Bahan Pokok', 0, 0, '2024-08-12 17:05:43'),
(50, 'Kabupaten Sumedang', 'Toko AX', 'Jl. AXX No. 50', 'Toserba', 0, 0, '2024-08-12 17:05:43'),
(51, 'Kabupaten Indramayu', 'Toko AY', 'Jl. AYY No. 51', 'Bahan Bangunan', 0, 0, '2024-08-12 17:05:43'),
(52, 'Kabupaten Indramayu', 'Toko AZ', 'Jl. AZZ No. 52', 'Farmasi/Apotek', 0, 0, '2024-08-12 17:05:43');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggaran_pengawasan`
--

CREATE TABLE `pelanggaran_pengawasan` (
  `id` int(11) NOT NULL,
  `tanggal_pengawasan` datetime NOT NULL,
  `nama_daerah` varchar(255) NOT NULL,
  `nama_pelaku_usaha` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `jenis_pelanggaran` varchar(255) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `status_tindak_lanjut_pelanggaran` varchar(255) NOT NULL,
  `status_pelanggaran` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggaran_pengawasan`
--

INSERT INTO `pelanggaran_pengawasan` (`id`, `tanggal_pengawasan`, `nama_daerah`, `nama_pelaku_usaha`, `alamat`, `jenis_pelanggaran`, `keterangan`, `status_tindak_lanjut_pelanggaran`, `status_pelanggaran`) VALUES
(1, '2024-08-01 00:00:00', 'Kota Bandung', 'Toko A', 'Jl. ABC No.1', 'SNI', 'Produk tidak memenuhi standar SNI', 'Pemanggilan/Surat Peringatan', 'Sedang Diproses'),
(2, '2024-08-02 00:00:00', 'Kota Cimahi', 'Toko B', 'Jl. DBD No.2', 'MKG', 'Tidak memenuhi syarat MKG', 'Pemantauan Lanjutan', 'Selesai'),
(3, '2024-08-03 00:00:00', 'Kota Depok', 'Toko C', 'Jl. EFG No.3', 'Label', 'Label tidak sesuai dengan produk', 'Sanksi', 'Sedang Diproses'),
(4, '2024-08-04 00:00:00', 'Kota Bogor', 'Toko D', 'Jl. HIJ No.4', 'K3L', 'Produk tidak aman secara K3L', 'Sudah Aman', 'Selesai'),
(5, '2024-08-05 00:00:00', 'Kota Bekasi', 'Toko E', 'Jl. KLM No.5', 'SNI', 'Produk tidak terdaftar di SNI', 'Pemantauan Akhir', 'Selesai'),
(6, '2024-08-06 00:00:00', 'Kota Tasikmalaya', 'Toko F', 'Jl. NOP No.6', 'MKG', 'Tidak memiliki sertifikat MKG', 'Pemanggilan/Surat Peringatan', 'Sedang Diproses'),
(7, '2024-08-07 00:00:00', 'Kota Cirebon', 'Toko G', 'Jl. QRS No.7', 'Label', 'Label produk tidak terbaca', 'Pemantauan Lanjutan', 'Selesai'),
(8, '2024-08-08 00:00:00', 'Kota Sukabumi', 'Toko H', 'Jl. TUV No.8', 'K3L', 'Tidak ada penjelasan K3L pada produk', 'Sanksi', 'Sedang Diproses'),
(9, '2024-08-09 00:00:00', 'Kota Banjar', 'Toko I', 'Jl. WXY No.9', 'SNI', 'Tidak ada kode SNI pada produk', 'Sudah Aman', 'Selesai'),
(10, '2024-08-10 00:00:00', 'Kota Tasikmalaya', 'Toko J', 'Jl. ZAB No.10', 'MKG', 'Tidak lulus tes MKG', 'Pemantauan Akhir', 'Selesai'),
(11, '2024-08-11 00:00:00', 'Kota Tasikmalaya', 'Toko K', 'Jl. CDE No.11', 'Label', 'Label produk salah cetak', 'Pemanggilan/Surat Peringatan', 'Sedang Diproses'),
(12, '2024-08-12 00:00:00', 'Kota Bekasi', 'Toko L', 'Jl. FGH No.12', 'K3L', 'Tidak sesuai standar K3L', 'Pemantauan Lanjutan', 'Selesai'),
(13, '2024-08-13 00:00:00', 'Kota Cimahi', 'Toko M', 'Jl. IJK No.13', 'SNI', 'SNI produk tidak valid', 'Sanksi', 'Sedang Diproses'),
(14, '2024-08-14 00:00:00', 'Kota Depok', 'Toko N', 'Jl. LMN No.14', 'MKG', 'Sertifikasi MKG palsu', 'Sudah Aman', 'Selesai'),
(15, '2024-08-15 00:00:00', 'Kota Bogor', 'Toko O', 'Jl. OPQ No.15', 'Label', 'Label produk tidak sesuai', 'Pemanggilan/Surat Peringatan', 'Sedang Diproses'),
(16, '2024-08-16 00:00:00', 'Kota Sukabumi', 'Toko P', 'Jl. RST No.16', 'K3L', 'Tidak ada informasi K3L pada produk', 'Pemantauan Akhir', 'Selesai'),
(17, '2024-08-17 00:00:00', 'Kota Banjar', 'Toko Q', 'Jl. UVW No.17', 'SNI', 'Produk tidak bersertifikat SNI', 'Sanksi', 'Sedang Diproses'),
(18, '2024-08-18 00:00:00', 'Kota Bandung', 'Toko R', 'Jl. XYZ No.18', 'MKG', 'Sertifikat MKG tidak sah', 'Sudah Aman', 'Selesai'),
(19, '2024-08-19 00:00:00', 'Kota Cirebon', 'Toko S', 'Jl. ABC No.19', 'Label', 'Label produk tidak jelas', 'Pemantauan Lanjutan', 'Selesai'),
(20, '2024-08-20 00:00:00', 'Kota Bogor', 'Toko T', 'Jl. DBD No.20', 'K3L', 'Tidak ada petunjuk K3L', 'Pemanggilan/Surat Peringatan', 'Sedang Diproses');

-- --------------------------------------------------------

--
-- Table structure for table `pelaporan_pelanggaran`
--

CREATE TABLE `pelaporan_pelanggaran` (
  `id` int(11) NOT NULL,
  `tanggal_pelaporan` datetime NOT NULL,
  `nama_pelapor` varchar(255) NOT NULL,
  `nama_daerah` varchar(255) NOT NULL,
  `nama_pelaku_usaha` varchar(255) NOT NULL,
  `nama_produk` varchar(255) NOT NULL,
  `nama_merk_produk` varchar(255) NOT NULL,
  `jenis_pelanggaran` varchar(255) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `bukti_pelanggaran` text DEFAULT NULL,
  `status_pelanggaran` varchar(50) NOT NULL,
  `status_tindak_lanjut_pelanggaran` varchar(255) NOT NULL,
  `bukti_pengembalian` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelaporan_pelanggaran`
--

INSERT INTO `pelaporan_pelanggaran` (`id`, `tanggal_pelaporan`, `nama_pelapor`, `nama_daerah`, `nama_pelaku_usaha`, `nama_produk`, `nama_merk_produk`, `jenis_pelanggaran`, `keterangan`, `bukti_pelanggaran`, `status_pelanggaran`, `status_tindak_lanjut_pelanggaran`, `bukti_pengembalian`) VALUES
(1, '2024-08-11 00:00:00', 'Pelapor A', 'Kota Bandung', '1', 'Produk A', 'Merk A', 'Label, MKG', 'Lorem Ipsum', 'file_buktipelanggaran_example.pdf', 'Sedang Diproses', 'Pemanggilan', NULL),
(2, '2024-08-11 00:00:00', 'Pelapor A', 'Kota Bandung', '1', 'Produk A', 'Merk A', 'MKG, K3L', 'Lorem Ipsum', 'file_buktipelanggaran_example.pdf', 'Sedang Diproses', 'Pemanggilan', NULL),
(4, '2024-08-01 00:00:00', 'Pelapor B', 'Kota Bekasi', '2', 'Produk A', 'Merk B', 'Label', 'BBB', 'file_buktipelanggaran_example.pdf', 'Sedang Diproses', 'Pemanggilan', NULL),
(5, '2024-07-31 00:00:00', 'Pelaku C', 'Kota Bogor', '12', 'Produk C', 'Merk C', 'MKG', 'CCC', 'file_buktipelanggaran_example.pdf', 'Sedang Diproses', 'Pemanggilan', NULL),
(6, '2024-08-02 00:00:00', 'Test', 'Kabupaten Sukabumi', '5', 'Test', 'Test', 'K3L, SNI', 'Test', 'file_buktipelanggaran_example.pdf', 'Sedang Diproses', 'Pemanggilan', NULL),
(7, '2024-08-08 00:00:00', 'Test 2', 'Kabupaten Bandung Barat', '18', 'Test 2', 'Test 2', 'SNI, Label', 'Test 2', 'file_buktipelanggaran_example.pdf', 'Sedang Diproses', 'Pemanggilan', NULL),
(8, '2024-08-01 00:00:00', 'Test 3', 'Kabupaten Indramayu', '19', 'Test 3', 'Test 3', 'K3L', 'Test 3', 'file_buktipelanggaran_example.pdf', 'Sedang Diproses', 'Pemanggilan', NULL),
(9, '2024-08-01 00:00:00', 'Test 3', 'Kabupaten Indramayu', '19', 'Test 3', 'Test 3', 'SNI', 'Test 3', 'file_buktipelanggaran_example.pdf', 'Sedang Diproses', 'Pemanggilan', NULL),
(10, '2024-08-06 00:00:00', 'Test 4', 'Kabupaten Purwakarta', '50', 'Test 4', 'Test 4', 'SNI, Label, K3L', 'Test 4', 'file_buktipelanggaran_example.pdf', 'Sedang Diproses', 'Pemanggilan', NULL),
(11, '2024-08-04 00:00:00', 'Test 5', 'Kabupaten Indramayu', '35', 'Test 5', 'Test 5', 'SNI, Label', 'Test 5', 'file_buktipelanggaran_example.pdf', 'Sedang Diproses', 'Pemanggilan', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `skala_biaya_bahan_bakar`
--

CREATE TABLE `skala_biaya_bahan_bakar` (
  `id` int(11) NOT NULL,
  `rentang_jarak_minimal` float NOT NULL,
  `rentang_jarak_maksimal` float NOT NULL,
  `biaya_bensin` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `skala_biaya_bahan_bakar`
--

INSERT INTO `skala_biaya_bahan_bakar` (`id`, `rentang_jarak_minimal`, `rentang_jarak_maksimal`, `biaya_bensin`) VALUES
(1, 10, 60, 350000),
(2, 61, 100, 450000),
(3, 101, 160, 600000),
(4, 161, 200, 700000);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `roles` varchar(50) DEFAULT NULL,
  `nama_pengguna` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `roles`, `nama_pengguna`) VALUES
(1, 'admin', 'admin123', 'Admin', 'Bidang Perlindungan Konsumen'),
(2, 'pengawas', 'pengawas123', 'Pengawas', 'Adiyatma Pratama W.'),
(3, 'pimpinan', 'pimpinan123', 'Struktural Inti', 'Kepala Dinas');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang_pengawasan`
--
ALTER TABLE `barang_pengawasan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `biaya_transportasi`
--
ALTER TABLE `biaya_transportasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bobot_kriteria`
--
ALTER TABLE `bobot_kriteria`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_pegawai`
--
ALTER TABLE `data_pegawai`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hasilperencanaan`
--
ALTER TABLE `hasilperencanaan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pelaku_usaha_1` (`pelaku_usaha_id_1`),
  ADD KEY `fk_pelaku_usaha_2` (`pelaku_usaha_id_2`);

--
-- Indexes for table `hasilperhitungan`
--
ALTER TABLE `hasilperhitungan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logperhitungan`
--
ALTER TABLE `logperhitungan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `pelakuusaha`
--
ALTER TABLE `pelakuusaha`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pelanggaran_pengawasan`
--
ALTER TABLE `pelanggaran_pengawasan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pelaporan_pelanggaran`
--
ALTER TABLE `pelaporan_pelanggaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skala_biaya_bahan_bakar`
--
ALTER TABLE `skala_biaya_bahan_bakar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang_pengawasan`
--
ALTER TABLE `barang_pengawasan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `biaya_transportasi`
--
ALTER TABLE `biaya_transportasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `bobot_kriteria`
--
ALTER TABLE `bobot_kriteria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `data_pegawai`
--
ALTER TABLE `data_pegawai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `hasilperencanaan`
--
ALTER TABLE `hasilperencanaan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `hasilperhitungan`
--
ALTER TABLE `hasilperhitungan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1023;

--
-- AUTO_INCREMENT for table `logperhitungan`
--
ALTER TABLE `logperhitungan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT for table `pelakuusaha`
--
ALTER TABLE `pelakuusaha`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `pelanggaran_pengawasan`
--
ALTER TABLE `pelanggaran_pengawasan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `pelaporan_pelanggaran`
--
ALTER TABLE `pelaporan_pelanggaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `skala_biaya_bahan_bakar`
--
ALTER TABLE `skala_biaya_bahan_bakar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hasilperencanaan`
--
ALTER TABLE `hasilperencanaan`
  ADD CONSTRAINT `fk_pelaku_usaha_1` FOREIGN KEY (`pelaku_usaha_id_1`) REFERENCES `pelakuusaha` (`id`),
  ADD CONSTRAINT `fk_pelaku_usaha_2` FOREIGN KEY (`pelaku_usaha_id_2`) REFERENCES `pelakuusaha` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
