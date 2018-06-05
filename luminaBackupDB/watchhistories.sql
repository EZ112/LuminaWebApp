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
-- Table structure for table `watchhistories`
--

CREATE TABLE `watchhistories` (
  `WatchHistoryID` int(11) NOT NULL,
  `EpisodeID` int(11) DEFAULT NULL,
  `UserID` int(11) NOT NULL,
  `WatchTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `watchhistories`
--

INSERT INTO `watchhistories` (`WatchHistoryID`, `EpisodeID`, `UserID`, `WatchTime`) VALUES
(1, 1, 18, '2018-06-04 02:37:44'),
(2, 2, 18, '2018-06-04 04:17:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `watchhistories`
--
ALTER TABLE `watchhistories`
  ADD PRIMARY KEY (`WatchHistoryID`),
  ADD KEY `EpisodeID` (`EpisodeID`),
  ADD KEY `UserID` (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `watchhistories`
--
ALTER TABLE `watchhistories`
  MODIFY `WatchHistoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `watchhistories`
--
ALTER TABLE `watchhistories`
  ADD CONSTRAINT `watchhistories_ibfk_1` FOREIGN KEY (`EpisodeID`) REFERENCES `episodes` (`EpisodeID`),
  ADD CONSTRAINT `watchhistories_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
