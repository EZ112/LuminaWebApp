-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2018 at 04:08 AM
-- Server version: 10.1.31-MariaDB
-- PHP Version: 7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `luminadb`
--

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `NewsID` int(11) NOT NULL,
  `TagsID` int(11) NOT NULL,
  `NewsTitle` varchar(100) DEFAULT NULL,
  `PublishDate` date DEFAULT NULL,
  `Writer` varchar(50) DEFAULT NULL,
  `Headline` longtext NOT NULL,
  `NewsContent` longtext,
  `NewsLink` longtext,
  `NewsThumbnail` longtext NOT NULL,
  `NewsImage` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`NewsID`, `TagsID`, `NewsTitle`, `PublishDate`, `Writer`, `Headline`, `NewsContent`, `NewsLink`, `NewsThumbnail`, `NewsImage`) VALUES
(3, 1, 'Adaptasi Anime ‘ISLAND’ Ungkap Staf Produksinya', '2018-05-29', 'Kate Springer', 'VN in awalnya rilis pada April 2016 untuk PC dan rilis pada PlayStation Vita di 23 Februari\r\n					2017. Terdapat juga adaptasi manga karya Naoya Yao yang rilis pada April 2016.\r\n					<br><br>\r\n					Island menceritakan tentang pulau bernama Urashima. Sebuah insiden yang menimpa tiga keluarga besar pulau tersebut dari lima tahun yang lalu menyebabkan pulau tersebut terisolasi. Pulau tersebut terisolasi akibat penyakit lokal bernama Baimonbyou, tiga gadis dari pulau tersebut merupakan kunci untuk menyelamatkan pulau itu, namun tradisi membuat mereka tidak dapat bertindak. Suatu hari sebuah pria terdampar di pulau tersebut dan mengubah segalanya.', 'Situs resmi dari adaptasi anime “ISLAND” telah mengungkap staf produksinya. Adaptasi VN ini direncanakan tayang pada tahun 2018 ini.\r\n					<br><br>\r\n					Staf produksinya adalah:\r\n					<br><br>\r\n					<li>Sutradara: Keiichiro Kawaguchi</li>\r\n					<li>Komposisi Seri: Naruhisa Arakawa</li>\r\n					<li>Desainer Karakter: Kousuke Kawamura</li>\r\n					<li>Musik: Akiyuki Tateyama</li>\r\n					<li>Lagu Pembuka: Yukari Tamura</li>\r\n					<li>Lagu Penutup: Asaka</li>\r\n					<li>Studio Produksi: feel.</li>\r\n					<br>\r\n					Seiyuu yang akan hadir beserta peran mereka adalah:\r\n					<br><br>\r\n					<li>Yukari Tamura sebagai <b>Rinne Ohara</b></li>\r\n					<li>Kana Asumi sebagai <b>Karen Kurutsu</b></li>\r\n					<li>Hibiku Yamamura <b>sebagai Sora Garandou</b></li>\r\n					<br>\r\n					VN in awalnya rilis pada April 2016 untuk PC dan rilis pada PlayStation Vita di 23 Februari\r\n					2017. Terdapat juga adaptasi manga karya Naoya Yao yang rilis pada April 2016.\r\n					<br><br>\r\n					Island menceritakan tentang pulau bernama Urashima. Sebuah insiden yang menimpa tiga keluarga besar pulau tersebut dari lima tahun yang lalu menyebabkan pulau tersebut terisolasi. Pulau tersebut terisolasi akibat penyakit lokal bernama Baimonbyou, tiga gadis dari pulau tersebut merupakan kunci untuk menyelamatkan pulau itu, namun tradisi membuat mereka tidak dapat bertindak. Suatu hari sebuah pria terdampar di pulau tersebut dan mengubah segalanya.\r\n					<br><br>\r\n					Gamenya diproduksi oleh Ryuichiro Yamakawa, Yousai Kuuchuu adalah ilustrator seri ini, sementara G.O. mengerjakan skenarionya.', NULL, 'assets/image/island.jpg', 'background: url(assets/image/news-img.jpg) 50% 20%;'),
(4, 1, '‘Grand Blue’ Tampilkan Teaser Anime dan Ungkap Staf Produksi', '2018-03-01', 'Kaptain', 'Seri ini menceritakan tentang Kitahara Iori yang pindah ke Izu untuk kuliah, di sana dia menetap di toko alat selam bernama “Grand Blue” yang dimiliki oleh kerabatnya. Setelah berbagai insiden yang melibatkan kakak kelas dan sepupunya yang bergabung dengan circle menyelam tingkat universitas, dia memutuskan untuk ikut mencoba menyelam juga.', '<p>Situs resmi dari adaptasi&nbsp;<em>anime&nbsp;</em><strong>“Grand Blue”&nbsp;</strong>telah menampilkan sebuah&nbsp;<em>teaser&nbsp;</em>serta visual&nbsp;<em>anime-</em>nya. Bersamaan dengan ini staf produksinya juga telah diungkap.</p>\r\n<p>Staf produksi&nbsp;<em>anime-</em>nya adalah:</p>\r\n<ul>\r\n<li>Sutradara, Skrip: Shinji Takamatsu (<em>Gintama, Danshi Koukousei no Nichijou, School Rumble</em>)</li>\r\n<li>Desainer Karakter: Hideoki Kusama</li>\r\n<li>Studio Produksi: <strong>Zero-G</strong> (<em>Battery, Tsugumomo, Dive!!</em>)</li>\r\n</ul>\r\n<p>Pilihan sutradara yang sempurna untuk seri ini, namun studionya sayang masih belum terlalu berpengalaman.</p>\r\n<p>Seri ini menceritakan tentang Kitahara Iori yang pindah ke Izu untuk kuliah, di sana dia menetap di toko alat selam bernama “Grand Blue” yang dimiliki oleh kerabatnya. Setelah berbagai insiden yang melibatkan kakak kelas dan sepupunya yang bergabung dengan&nbsp;<em>circle&nbsp;</em>menyelam tingkat universitas, dia memutuskan untuk ikut mencoba menyelam juga.</p>\r\n', NULL, 'assets/image/grand.jpg', 'background: url(assets/image/news4.jpg);\r\nbackground-size: cover;');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`NewsID`),
  ADD KEY `TagsID` (`TagsID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `NewsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`TagsID`) REFERENCES `tags` (`TagsID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
