-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.2.41-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for demo
DROP DATABASE IF EXISTS `demo`;
CREATE DATABASE IF NOT EXISTS `demo` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `demo`;

-- Dumping structure for table demo.r_kota
DROP TABLE IF EXISTS `r_kota`;
CREATE TABLE IF NOT EXISTS `r_kota` (
  `id_kota` char(4) NOT NULL,
  `nm_kota` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id_kota`),
  UNIQUE KEY `id_kota` (`id_kota`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table demo.r_kota: ~11 rows (approximately)
DELETE FROM `r_kota`;
/*!40000 ALTER TABLE `r_kota` DISABLE KEYS */;
INSERT INTO `r_kota` (`id_kota`, `nm_kota`) VALUES
	('0001', 'San Fransisco'),
	('0002', 'New York'),
	('0003', 'Tokyo'),
	('0004', 'Seoul'),
	('0005', 'Sidney'),
	('0006', 'London'),
	('0007', 'Birmingham'),
	('0008', 'Edinburgh'),
	('0009', 'Paris'),
	('0010', 'Barcelona'),
	('0011', 'Rome');
/*!40000 ALTER TABLE `r_kota` ENABLE KEYS */;

-- Dumping structure for table demo.t_pegawai
DROP TABLE IF EXISTS `t_pegawai`;
CREATE TABLE IF NOT EXISTS `t_pegawai` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  `posisi` varchar(100) DEFAULT NULL,
  `tgl_bekerja` date DEFAULT NULL,
  `kota` char(4) DEFAULT NULL,
  `gaji_pokok` double DEFAULT NULL,
  `aktif` enum('Y','N') DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- Dumping data for table demo.t_pegawai: ~5 rows (approximately)
DELETE FROM `t_pegawai`;
/*!40000 ALTER TABLE `t_pegawai` DISABLE KEYS */;
INSERT INTO `t_pegawai` (`id`, `nama`, `posisi`, `tgl_bekerja`, `kota`, `gaji_pokok`, `aktif`, `created_at`) VALUES
	(1, 'Tiger Nixon', 'Senior Manager', '2008-09-26', '0004', 1798100, 'Y', '2023-12-07 19:50:16'),
	(2, 'Garrett Winters', 'Mobile Developer', '2010-01-04', '0001', 203776, 'Y', '2023-12-07 19:49:56'),
	(3, 'Ashton Cox', 'Backend Developer', '2009-02-27', '0003', 249120, 'Y', '2023-12-07 19:44:17'),
	(4, 'Cedric Kelly', 'Network Engineer', '2010-02-12', '0003', 431076, 'Y', '2023-12-07 19:49:27'),
	(5, 'Airi Satou', 'Database Administrator', '2009-10-09', '0001', 338520, 'Y', '2023-12-07 19:45:40'),
	(6, 'Brielle Williamson', 'Backend Developer', '2009-02-14', '0001', 249399, 'Y', '2023-12-07 19:44:01'),
	(7, 'Herrod Chandler', 'Software Engineer', '2008-12-11', '0004', 418442, 'Y', '2023-12-07 19:46:29'),
	(8, 'Rhona Davidson', 'Backend Developer', '2008-12-13', '0010', 287920, 'Y', '2023-12-07 19:43:52'),
	(9, 'Colleen Hurst', 'Backend Developer', '2008-04-09', '0007', 326076, 'Y', '2023-12-07 19:44:41'),
	(10, 'Sonya Frost', 'Software Engineer', '2008-10-26', '0006', 425233, 'Y', '2023-12-07 19:46:22'),
	(11, 'Jena Gaines', 'Mobile Developer', '2009-12-09', '0002', 211684, 'Y', '2023-12-07 19:49:47'),
	(12, 'Quinn Flynn', 'Data Analyst', '2009-08-19', '0002', 3437940, 'Y', '2023-12-07 19:46:04'),
	(13, 'Gloria Little', 'Data Analyst', '2009-07-07', '0009', 346778, 'Y', '2023-12-07 19:45:52'),
	(14, 'Paul Byrd', 'Database Administrator', '2009-09-15', '0003', 322019, 'Y', '2023-12-07 19:45:31'),
	(15, 'Michael Silva', 'Project Manager', '2008-10-14', '0011', 1372100, 'Y', '2023-12-07 19:48:15'),
	(16, 'Tatyana Fitzpatrick', 'Project Manager', '2009-06-20', '0008', 1358140, 'Y', '2023-12-07 19:47:58'),
	(17, 'Haley Kennedy', 'Marketing Analyst', '2008-12-16', '0001', 475110, 'Y', '2023-12-07 19:50:06'),
	(18, 'Charde Marshall', 'Database Administrator', '2009-01-12', '0001', 1258100, 'Y', '2023-12-07 19:49:01'),
	(19, 'Quinn Flynn', 'Mobile Developer', '2009-10-22', '0003', 212636, 'Y', '2023-12-07 19:49:39'),
	(20, 'Paolo Martinelli', 'Systems Administrator', '2008-11-28', '0005', 538920, 'Y', '2023-12-07 19:46:42'),
	(21, 'Jenette Caldwell', 'Mobile Developer', '2008-11-13', '0007', 217734, 'Y', '2023-12-07 19:49:35'),
	(22, 'Angelica Ramos', 'Chief Information Officer', '2009-06-25', '0002', 2851200, 'Y', '2023-12-07 19:43:25'),
	(23, 'Jennifer Acosta', 'Senior Manager', '2008-08-21', '0001', 1852300, 'Y', '2023-12-07 19:48:23'),
	(24, 'Hermione Butler', 'Secretary', '2008-10-16', '0005', 78995, 'Y', '2023-12-07 19:47:08'),
	(25, 'Donna Snider', 'Secretary', '2010-03-17', '0007', 72783, 'Y', '2023-12-07 19:47:17'),
	(26, 'Carla Stevens', 'Network Engineer', '2008-10-22', '0001', 423110, 'Y', '2023-12-07 19:49:22');
/*!40000 ALTER TABLE `t_pegawai` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
