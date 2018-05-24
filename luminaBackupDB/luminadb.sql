-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 24, 2018 at 04:00 PM
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
-- Table structure for table `anime`
--

CREATE TABLE `anime` (
  `AnimeID` int(11) NOT NULL,
  `SeriesID` int(11) DEFAULT NULL,
  `StudioID` int(11) DEFAULT NULL,
  `SourceID` int(11) DEFAULT NULL,
  `ReleaseSeasonID` int(11) DEFAULT NULL,
  `GenreID` int(11) DEFAULT NULL,
  `DurationID` int(11) DEFAULT NULL,
  `AnimeTitle` longtext,
  `SeasonID` varchar(35) DEFAULT NULL,
  `EpisodeTotal` int(11) DEFAULT NULL,
  `Thumbnail` longtext,
  `AnimeReleaseDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bankdetail`
--

CREATE TABLE `bankdetail` (
  `BankID` int(11) NOT NULL,
  `BankName` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `CommentsID` int(11) NOT NULL,
  `EpisodeID` int(11) DEFAULT NULL,
  `Username` varchar(25) DEFAULT NULL,
  `CommentContent` longtext,
  `PostingDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `durations`
--

CREATE TABLE `durations` (
  `DurationID` int(11) NOT NULL,
  `Duration` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `durations`
--

INSERT INTO `durations` (`DurationID`, `Duration`) VALUES
(1, 'Short'),
(2, '24 min Series'),
(3, 'Movie');

-- --------------------------------------------------------

--
-- Table structure for table `episodes`
--

CREATE TABLE `episodes` (
  `EpisodeID` int(11) NOT NULL,
  `AnimeID` int(11) DEFAULT NULL,
  `EpsTitle` longtext,
  `EpsDateAir` date DEFAULT NULL,
  `Episode` int(11) DEFAULT NULL,
  `EpisodeTotalViews` int(11) DEFAULT NULL,
  `VideoLink` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `GenreID` int(11) NOT NULL,
  `Genre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`GenreID`, `Genre`) VALUES
(1, 'Action'),
(2, 'Adventure'),
(3, 'Comedy'),
(4, 'Drama'),
(5, 'Ecchi'),
(6, 'Fantasy'),
(7, 'Game'),
(8, 'Harem'),
(9, 'Historical'),
(10, 'Horror'),
(11, 'Magic'),
(12, 'Martial Arts'),
(13, 'Mecha'),
(14, 'Military'),
(15, 'Music'),
(16, 'Mystery'),
(17, 'Parody'),
(18, 'Psychological'),
(19, 'Romance'),
(20, 'Samurai'),
(21, 'School'),
(22, 'Sci-Fi'),
(23, 'Seinen'),
(24, 'Shoujo'),
(25, 'Shounen'),
(26, 'Slice of Life'),
(27, 'Sports'),
(28, 'Super Power'),
(29, 'Supernatural'),
(30, 'Thriller');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `NewsID` int(11) NOT NULL,
  `NewsTitle` varchar(50) DEFAULT NULL,
  `PublishDate` date DEFAULT NULL,
  `Writer` varchar(50) DEFAULT NULL,
  `NewsContent` longtext,
  `NewsLink` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `paymenthistory`
--

CREATE TABLE `paymenthistory` (
  `PaymentHistoryID` int(11) NOT NULL,
  `Username` varchar(25) DEFAULT NULL,
  `BankID` int(11) DEFAULT NULL,
  `PaymentStatus` bit(1) DEFAULT NULL,
  `AccountNumber` varchar(20) DEFAULT NULL,
  `PaymentPlan` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `releaseseason`
--

CREATE TABLE `releaseseason` (
  `ReleaseSeasonID` int(11) NOT NULL,
  `ReleaseSeason` varchar(10) NOT NULL,
  `SeasonFlag` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `releaseseason`
--

INSERT INTO `releaseseason` (`ReleaseSeasonID`, `ReleaseSeason`, `SeasonFlag`) VALUES
(1, 'Winter', 0),
(2, 'Spring', 1),
(3, 'Summer', 2),
(4, 'Fall', 3);

-- --------------------------------------------------------

--
-- Table structure for table `series`
--

CREATE TABLE `series` (
  `SeriesID` int(11) NOT NULL,
  `Series` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `series`
--

INSERT INTO `series` (`SeriesID`, `Series`) VALUES
(1, 'Yuru Camp'),
(2, 'Violet Evergarden'),
(3, 'Karakai Jouzu');

-- --------------------------------------------------------

--
-- Table structure for table `source`
--

CREATE TABLE `source` (
  `SourceID` int(11) NOT NULL,
  `Source` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `source`
--

INSERT INTO `source` (`SourceID`, `Source`) VALUES
(1, 'Original'),
(2, 'Light Novel'),
(3, 'Manga');

-- --------------------------------------------------------

--
-- Table structure for table `studio`
--

CREATE TABLE `studio` (
  `StudioID` int(11) NOT NULL,
  `Studio` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `studio`
--

INSERT INTO `studio` (`StudioID`, `Studio`) VALUES
(1, 'Kyoto Animation'),
(2, 'Shin-Ei Animation'),
(3, 'C-Station');

-- --------------------------------------------------------

--
-- Table structure for table `subscription`
--

CREATE TABLE `subscription` (
  `AnimeID` int(11) NOT NULL,
  `Username` varchar(25) NOT NULL,
  `SubscriptionStatus` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `username`
--

CREATE TABLE `username` (
  `Username` varchar(25) NOT NULL,
  `Email` varchar(25) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `SubStatus` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `watchhistories`
--

CREATE TABLE `watchhistories` (
  `WatchHistoryID` int(11) NOT NULL,
  `EpisodeID` int(11) DEFAULT NULL,
  `Username` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `watchlater`
--

CREATE TABLE `watchlater` (
  `WatchLaterID` int(11) NOT NULL,
  `EpisodeID` int(11) DEFAULT NULL,
  `Username` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `anime`
--
ALTER TABLE `anime`
  ADD PRIMARY KEY (`AnimeID`),
  ADD KEY `SeriesID` (`SeriesID`),
  ADD KEY `StudioID` (`StudioID`),
  ADD KEY `ReleaseSeasonID` (`ReleaseSeasonID`),
  ADD KEY `GenreID` (`GenreID`),
  ADD KEY `DurationID` (`DurationID`),
  ADD KEY `SourceID` (`SourceID`);

--
-- Indexes for table `bankdetail`
--
ALTER TABLE `bankdetail`
  ADD PRIMARY KEY (`BankID`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`CommentsID`),
  ADD KEY `EpisodeID` (`EpisodeID`),
  ADD KEY `Username` (`Username`);

--
-- Indexes for table `durations`
--
ALTER TABLE `durations`
  ADD PRIMARY KEY (`DurationID`);

--
-- Indexes for table `episodes`
--
ALTER TABLE `episodes`
  ADD PRIMARY KEY (`EpisodeID`),
  ADD KEY `AnimeID` (`AnimeID`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`GenreID`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`NewsID`);

--
-- Indexes for table `paymenthistory`
--
ALTER TABLE `paymenthistory`
  ADD PRIMARY KEY (`PaymentHistoryID`),
  ADD KEY `BankID` (`BankID`),
  ADD KEY `Username` (`Username`);

--
-- Indexes for table `releaseseason`
--
ALTER TABLE `releaseseason`
  ADD PRIMARY KEY (`ReleaseSeasonID`);

--
-- Indexes for table `series`
--
ALTER TABLE `series`
  ADD PRIMARY KEY (`SeriesID`);

--
-- Indexes for table `source`
--
ALTER TABLE `source`
  ADD PRIMARY KEY (`SourceID`);

--
-- Indexes for table `studio`
--
ALTER TABLE `studio`
  ADD PRIMARY KEY (`StudioID`);

--
-- Indexes for table `subscription`
--
ALTER TABLE `subscription`
  ADD PRIMARY KEY (`AnimeID`,`Username`),
  ADD KEY `Username` (`Username`);

--
-- Indexes for table `username`
--
ALTER TABLE `username`
  ADD PRIMARY KEY (`Username`);

--
-- Indexes for table `watchhistories`
--
ALTER TABLE `watchhistories`
  ADD PRIMARY KEY (`WatchHistoryID`),
  ADD KEY `EpisodeID` (`EpisodeID`),
  ADD KEY `Username` (`Username`);

--
-- Indexes for table `watchlater`
--
ALTER TABLE `watchlater`
  ADD PRIMARY KEY (`WatchLaterID`),
  ADD KEY `EpisodeID` (`EpisodeID`),
  ADD KEY `Username` (`Username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `anime`
--
ALTER TABLE `anime`
  MODIFY `AnimeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bankdetail`
--
ALTER TABLE `bankdetail`
  MODIFY `BankID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `CommentsID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `durations`
--
ALTER TABLE `durations`
  MODIFY `DurationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `episodes`
--
ALTER TABLE `episodes`
  MODIFY `EpisodeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `GenreID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `NewsID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `paymenthistory`
--
ALTER TABLE `paymenthistory`
  MODIFY `PaymentHistoryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `releaseseason`
--
ALTER TABLE `releaseseason`
  MODIFY `ReleaseSeasonID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `series`
--
ALTER TABLE `series`
  MODIFY `SeriesID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `source`
--
ALTER TABLE `source`
  MODIFY `SourceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `studio`
--
ALTER TABLE `studio`
  MODIFY `StudioID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `watchhistories`
--
ALTER TABLE `watchhistories`
  MODIFY `WatchHistoryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `watchlater`
--
ALTER TABLE `watchlater`
  MODIFY `WatchLaterID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `anime`
--
ALTER TABLE `anime`
  ADD CONSTRAINT `anime_ibfk_1` FOREIGN KEY (`SeriesID`) REFERENCES `series` (`SeriesID`),
  ADD CONSTRAINT `anime_ibfk_2` FOREIGN KEY (`StudioID`) REFERENCES `studio` (`StudioID`),
  ADD CONSTRAINT `anime_ibfk_3` FOREIGN KEY (`ReleaseSeasonID`) REFERENCES `releaseseason` (`ReleaseSeasonID`),
  ADD CONSTRAINT `anime_ibfk_4` FOREIGN KEY (`GenreID`) REFERENCES `genres` (`GenreID`),
  ADD CONSTRAINT `anime_ibfk_5` FOREIGN KEY (`DurationID`) REFERENCES `durations` (`DurationID`),
  ADD CONSTRAINT `anime_ibfk_6` FOREIGN KEY (`SourceID`) REFERENCES `source` (`SourceID`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`EpisodeID`) REFERENCES `episodes` (`EpisodeID`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`Username`) REFERENCES `username` (`Username`);

--
-- Constraints for table `episodes`
--
ALTER TABLE `episodes`
  ADD CONSTRAINT `episodes_ibfk_1` FOREIGN KEY (`AnimeID`) REFERENCES `anime` (`AnimeID`);

--
-- Constraints for table `paymenthistory`
--
ALTER TABLE `paymenthistory`
  ADD CONSTRAINT `paymenthistory_ibfk_1` FOREIGN KEY (`BankID`) REFERENCES `bankdetail` (`BankID`),
  ADD CONSTRAINT `paymenthistory_ibfk_2` FOREIGN KEY (`Username`) REFERENCES `username` (`Username`);

--
-- Constraints for table `subscription`
--
ALTER TABLE `subscription`
  ADD CONSTRAINT `subscription_ibfk_1` FOREIGN KEY (`AnimeID`) REFERENCES `anime` (`AnimeID`),
  ADD CONSTRAINT `subscription_ibfk_2` FOREIGN KEY (`Username`) REFERENCES `username` (`Username`);

--
-- Constraints for table `watchhistories`
--
ALTER TABLE `watchhistories`
  ADD CONSTRAINT `watchhistories_ibfk_1` FOREIGN KEY (`EpisodeID`) REFERENCES `episodes` (`EpisodeID`),
  ADD CONSTRAINT `watchhistories_ibfk_2` FOREIGN KEY (`Username`) REFERENCES `username` (`Username`);

--
-- Constraints for table `watchlater`
--
ALTER TABLE `watchlater`
  ADD CONSTRAINT `watchlater_ibfk_1` FOREIGN KEY (`EpisodeID`) REFERENCES `episodes` (`EpisodeID`),
  ADD CONSTRAINT `watchlater_ibfk_2` FOREIGN KEY (`Username`) REFERENCES `username` (`Username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
