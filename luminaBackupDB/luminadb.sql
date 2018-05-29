-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 30, 2018 at 01:19 AM
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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAnimeLatestUpdate` ()  BEGIN
    SELECT a.AnimeTitle, a.Thumbnail, MAX(e.Episode) AS LatestEpisode, MAX(e.EpsDateAir) AS AirDate
    FROM anime a
    JOIN episodes e ON a.AnimeID = e.AnimeID
    GROUP BY a.AnimeID
    ORDER BY AirDate DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAnimeList` (IN `inYear` VARCHAR(5), IN `inSeason` VARCHAR(10), IN `inStat` VARCHAR(10), IN `inDuration` VARCHAR(20), IN `inSort` VARCHAR(10))  BEGIN

SELECT a.AnimeID INTO @temp
FROM anime a
WHERE a.EpisodeTotal = (
	SELECT MAX(e.Episode)
    FROM episodes e
    WHERE a.AnimeID = e.AnimeID
    GROUP BY a.AnimeID
);


SELECT DISTINCT a.AnimeTitle, a.Thumbnail, s.Source, a.EpisodeTotal, d.Duration, COUNT(sub.AnimeID) AS Subscriber, b.Genres
    FROM anime a
    JOIN source s ON a.SourceID = s.SourceID
    JOIN durations d ON a.DurationID = d.DurationID
    JOIN subscription sub ON a.AnimeID = sub.AnimeID
    JOIN releaseseason rs ON a.ReleaseSeasonID = rs.ReleaseSeasonID,
    (SELECT a.AnimeID, substring_index(GROUP_CONCAT(DISTINCT g.Genre     
     SEPARATOR ', '),', ', 5) AS Genres 
     FROM anime a 
     JOIN animeandgenres ag ON a.AnimeID = ag.AnimeID
     JOIN genres g ON ag.GenreID = g.GenreID
     GROUP BY a.AnimeID) AS b
    WHERE a.AnimeID = b.AnimeID
    AND YEAR(a.AnimeReleaseDate) = inYear
    AND rs.ReleaseSeason = inSeason
    AND d.Duration LIKE inDuration
    AND CASE WHEN inStat = 'Completed' THEN a.AnimeID = @temp ELSE a.AnimeID <> @temp END
    GROUP BY a.AnimeTitle, a.Thumbnail, s.Source, a.EpisodeTotal,
    d.Duration
    ORDER BY CASE WHEN inSort = 'Title' THEN a.AnimeTitle END ASC, COUNT(a.AnimeID) DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAnimeSearch` (IN `inSearch` LONGTEXT, IN `inDuration` INT, IN `inGenre` LONGTEXT)  BEGIN
    SELECT a.AnimeTitle, a.Thumbnail, a.ThumbnailLandscape, d.Duration, MAX(e.Episode) as LatestEpisode, b.SubScriber, c.Genres
    FROM anime a
    JOIN episodes e ON a.AnimeID = e.AnimeID
    JOIN durations d ON a.DurationID = d.DurationID,
    (SELECT a.AnimeID, COUNT(s.UserID) AS SubScriber
    FROM anime a 
    JOIN subscription s ON a.AnimeID = s.AnimeID
    GROUP BY a.AnimeID) b,
    (SELECT a.AnimeID, substring_index(GROUP_CONCAT(DISTINCT g.Genre     
     SEPARATOR ', '),', ', 5) AS Genres 
     FROM anime a 
     JOIN animeandgenres ag ON a.AnimeID = ag.AnimeID
     JOIN genres g ON ag.GenreID = g.GenreID
     WHERE g.Genre REGEXP inGenre
     GROUP BY a.AnimeID) AS c
    WHERE a.AnimeID = b.AnimeID
    AND a.AnimeID = c.AnimeID
    AND a.AnimeTitle LIKE CONCAT('%',inSearch,'%')
    GROUP BY a.AnimeID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetDuration` ()  BEGIN
	SELECT * FROM durations;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetEpisodeSearch` (IN `inSearch` LONGTEXT, IN `inDuration` INT, IN `inGenre` LONGTEXT)  BEGIN
    SELECT a.AnimeTitle, a.Thumbnail, e.EpsThumbnail, d.Duration, e.Episode, e.EpsTitle, DATE_FORMAT(e.EpsDateAir, "%d %M %Y") AS EpsDateAir, e.EpisodeTotalViews, b.Genres
    FROM anime a
    JOIN episodes e ON a.AnimeID = e.AnimeID
    JOIN durations d ON a.DurationID = d.DurationID,
    (SELECT a.AnimeID, substring_index(GROUP_CONCAT(DISTINCT g.Genre     
     SEPARATOR ', '),', ', 5) AS Genres 
     FROM anime a 
     JOIN animeandgenres ag ON a.AnimeID = ag.AnimeID
     JOIN genres g ON ag.GenreID = g.GenreID
     WHERE g.Genre REGEXP inGenre
     GROUP BY a.AnimeID) AS b
    WHERE a.AnimeID = b.AnimeID
    AND a.AnimeTitle LIKE CONCAT('%',inSearch,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetGenre` ()  BEGIN
	SELECT * FROM genres;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetNewsLatestUpdate` ()  BEGIN
    SELECT n.NewsTitle, n.PublishDate, n.NewsThumbnail, n.Headline 
    FROM news n
    ORDER BY n.PublishDate DESC
    LIMIT 2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetTags` ()  BEGIN
	SELECT * FROM tags;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetTopAiringAnime` ()  BEGIN
    SELECT a.AnimeTitle, a.Thumbnail, a.AnimeReleaseDate, COUNT(s.AnimeID) AS Subscriber FROM anime a
    JOIN releaseseason rs 
    ON a.ReleaseSeasonID = rs.ReleaseSeasonID
    JOIN subscription s
    ON a.AnimeID = s.AnimeID
    WHERE YEAR(a.AnimeReleaseDate) = YEAR(NOW())
    AND rs.SeasonFlag = CAST(MONTH(NOW())/4 AS INT)
    GROUP BY a.animeTitle, a.Thumbnail, a.AnimeReleaseDate
    ORDER BY Subscriber DESC;
END$$

DELIMITER ;

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
  `DurationID` int(11) DEFAULT NULL,
  `AnimeTitle` longtext,
  `Synopsis` longtext,
  `SeasonID` varchar(35) DEFAULT NULL,
  `EpisodeTotal` int(11) DEFAULT NULL,
  `Thumbnail` longtext,
  `ThumbnailLandscape` longtext NOT NULL,
  `AnimeReleaseDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `anime`
--

INSERT INTO `anime` (`AnimeID`, `SeriesID`, `StudioID`, `SourceID`, `ReleaseSeasonID`, `DurationID`, `AnimeTitle`, `Synopsis`, `SeasonID`, `EpisodeTotal`, `Thumbnail`, `ThumbnailLandscape`, `AnimeReleaseDate`) VALUES
(1, 1, 3, 3, 2, 2, 'Yuru Camp△', 'While the perfect getaway for most girls her age might be a fancy vacation with their loved ones, Rin Shima\'s ideal way of spending her days off is camping alone at the base of Mount Fuji. From pitching her tent to gathering firewood, she has always done everything by herself, and has no plans of leaving her little solitary world.\r\n\r\nHowever, what starts off as one of Rin\'s usual camping sessions somehow ends up as a surprise get-together for two when the lost Nadeshiko Kagamihara is forced to take refuge at her campsite. Originally intending to see the picturesque view of Mount Fuji for herself, Nadeshiko\'s plans are disrupted when she ends up falling asleep partway to her destination. Alone and with no other choice, she seeks help from the only other person nearby. Despite their hasty introductions, the two girls nevertheless enjoy the chilly night together, eating ramen and conversing while the campfire keeps them warm. And even after Nadeshiko\'s sister finally picks her up later that night, both girls silently ponder the possibility of another camping trip together.', 'YuruCampS001', 12, 'assets/image/yurucamp.jpg', 'assets/image/yuruwall.png', '2018-05-01'),
(2, 2, 1, 2, 2, 2, 'Violet Evergarden', 'The Great War finally came to an end after four long years of conflict; fractured in two, the continent of Telesis slowly began to flourish once again. Caught up in the bloodshed was Violet Evergarden, a young girl raised for the sole purpose of decimating enemy lines. Hospitalized and maimed in a bloody skirmish during the War\'s final leg, she was left with only words from the person she held dearest, but with no understanding of their meaning.\r\n\r\nRecovering from her wounds, Violet starts a new life working at CH Postal Services after a falling out with her new intended guardian family. There, she witnesses by pure chance the work of an \"Auto Memory Doll,\" amanuenses that transcribe people\'s thoughts and feelings into words on paper. Moved by the notion, Violet begins work as an Auto Memory Doll, a trade that will take her on an adventure, one that will reshape the lives of her clients and hopefully lead to self-discovery.', 'VioletEvergardenS001', 13, 'assets/image/violet.jpg', '', '2018-05-11'),
(3, 3, 2, 3, 2, 2, 'Karakai Jouzu no Takagi-san', '\"If you blush, you lose.\"\r\n\r\nLiving by this principle, the middle schooler Nishikata gets constantly made fun of by his seat neighbor Takagi-san. With his pride shattered to pieces, he vows to turn the tables and get back at her some day. And so, he attempts to tease her day after day, only to find himself victim to Takagi-san\'s ridicule again sooner than later. Will he be able to make Takagi-san blush from embarrassment even once in the end?', 'KarakaiJouzuS001', 12, 'assets/image/karakai.jpg', '', '2018-05-08'),
(4, 4, 4, 2, 2, 2, 'Overlord', 'The final hour of the popular virtual reality game Yggdrasil has come. However, Momonga, a powerful wizard and master of the dark guild Ainz Ooal Gown, decides to spend his last few moments in the game as the servers begin to shut down. To his surprise, despite the clock having struck midnight, Momonga is still fully conscious as his character and, moreover, the non-player characters appear to have developed personalities of their own!\r\n\r\nConfronted with this abnormal situation, Momonga commands his loyal servants to help him investigate and take control of this new world, with the hopes of figuring out what has caused this development and if there may be others in the same predicament.', 'OverlordS001', 13, 'assets/image/overlord.png', '', '2018-05-08'),
(5, 5, 5, 3, 2, 2, 'Koi wa Ameagari no You ni', 'Akira Tachibana, a reserved high school student and former track runner, has not been able to race the same as she used to since she experienced a severe foot injury. And although she is regarded as attractive by her classmates, she is not interested in the boys around school.\r\n\r\nWhile working part-time at the Garden Cafe, Akira begins to develop feelings for the manager—a 45-year-old man named Masami Kondou—despite the large age gap. Kondou shows genuine concern and kindness toward the customers of his restaurant, which, while viewed by others as soft or weak, draws Akira to him. Spending time together at the restaurant, they grow closer, which only strengthens her feelings. Weighed down by these uncertain emotions, Akira finally resolves to confess, but what will be the result?', 'KoiwaS001', 12, 'assets/image/koiwa.jpg', '', '2018-05-29');

-- --------------------------------------------------------

--
-- Table structure for table `animeandgenres`
--

CREATE TABLE `animeandgenres` (
  `AnimeID` int(11) NOT NULL,
  `GenreID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `animeandgenres`
--

INSERT INTO `animeandgenres` (`AnimeID`, `GenreID`) VALUES
(1, 3),
(1, 26),
(2, 4),
(2, 6),
(2, 26),
(3, 3),
(3, 19),
(3, 21),
(3, 25),
(3, 26),
(4, 6),
(4, 7),
(5, 4),
(5, 19);

-- --------------------------------------------------------

--
-- Table structure for table `bankdetail`
--

CREATE TABLE `bankdetail` (
  `BankID` int(11) NOT NULL,
  `BankName` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bankdetail`
--

INSERT INTO `bankdetail` (`BankID`, `BankName`) VALUES
(1, 'BCA'),
(2, 'Mandiri'),
(3, 'BNI'),
(4, 'BRI'),
(5, 'HSBC'),
(6, 'Danamon');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `CommentsID` int(11) NOT NULL,
  `EpisodeID` int(11) DEFAULT NULL,
  `UserID` int(11) NOT NULL,
  `CommentContent` longtext,
  `PostingDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `durations`
--

CREATE TABLE `durations` (
  `DurationID` int(11) NOT NULL,
  `Duration` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `EpsDateAir` datetime DEFAULT NULL,
  `Episode` int(11) DEFAULT NULL,
  `EpisodeTotalViews` int(11) DEFAULT NULL,
  `EpsThumbnail` longtext NOT NULL,
  `VideoLink` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `episodes`
--

INSERT INTO `episodes` (`EpisodeID`, `AnimeID`, `EpsTitle`, `EpsDateAir`, `Episode`, `EpisodeTotalViews`, `EpsThumbnail`, `VideoLink`) VALUES
(1, 1, 'Mount Fuji and Curry Noodles', '2018-01-04 00:00:00', 1, NULL, 'assets/image/YuruCampEps1.jpg', NULL),
(2, 1, 'Welcome to the Outdoor Activities Club', '2018-01-11 00:00:00', 2, NULL, 'assets/image/YuruCampEps2.jpg', NULL),
(3, 1, 'Mount Fuji and Relaxed Hot Pot Camp', '2018-01-18 00:00:00', 3, NULL, '', NULL),
(4, 2, '\"I Love You\" and Auto Memory Dolls', '2018-01-11 00:00:00', 1, NULL, '', NULL),
(5, 2, 'Never Coming Back', '2018-01-18 00:00:00', 2, NULL, '', NULL),
(6, 2, 'May You Be an Exemplary Auto Memory Doll', '2018-01-25 00:00:00', 3, NULL, '', NULL),
(7, 3, 'Eraser / Day Duty / Funny Face / One Hundred Yen', '2018-01-08 00:00:00', 1, NULL, '', NULL),
(8, 3, 'Calligraphy / Seasonal Change of Clothing / Pool', '2018-01-15 00:00:00', 2, NULL, '', NULL),
(9, 4, 'End and Beginning', '2018-05-29 00:00:00', 1, NULL, '', NULL),
(10, 5, 'The Sound of Rain', '2018-05-30 00:00:00', 1, NULL, '', NULL),
(11, 1, 'The Outdoor Activities Club and the Solo Camping Girl', '2018-05-31 00:00:00', 4, NULL, '', NULL),
(12, 3, 'Coffee / Empty Can / Soda / Muscle Training / Dubbing / Umbrella', '2018-05-31 01:00:00', 3, NULL, '', NULL),
(13, 1, 'Two Camps, Two Campers\' Views', '2018-06-02 00:00:00', 5, NULL, '', NULL),
(14, 1, 'Meat and Fall Colors and the Mystery Lake', '2018-06-07 00:00:00', 6, NULL, '', NULL),
(15, 1, 'A Night on the Lake Shore and Campers', '2018-06-14 00:00:00', 7, NULL, '', NULL),
(16, 1, 'Exams, Caribou, Steamed Buns, Yum!', '2018-06-15 00:00:00', 8, NULL, '', NULL),
(17, 1, 'A Night of Navigator Nadeshiko and Hot Spring Steam', '2018-06-16 00:00:00', 9, NULL, '', 'A Night of Navigator Nadeshiko and Hot Spring Steam'),
(18, 1, 'Clumsy Travelers and Camp Meetings', '2018-06-17 00:00:00', 10, NULL, '', NULL),
(19, 1, 'Christmas Camp!', '2018-06-18 00:00:00', 11, NULL, '', NULL),
(20, 1, 'Mount Fuji and the Laid-Back Camp Girls', '2018-07-23 00:00:00', 12, NULL, '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `GenreID` int(11) NOT NULL,
  `Genre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `TagsID` int(11) NOT NULL,
  `NewsTitle` varchar(100) DEFAULT NULL,
  `PublishDate` date DEFAULT NULL,
  `Writer` varchar(50) DEFAULT NULL,
  `Headline` longtext NOT NULL,
  `NewsContent` longtext,
  `NewsLink` longtext,
  `NewsThumbnail` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`NewsID`, `TagsID`, `NewsTitle`, `PublishDate`, `Writer`, `Headline`, `NewsContent`, `NewsLink`, `NewsThumbnail`) VALUES
(3, 1, 'Adaptasi Anime ‘ISLAND’ Ungkap Staf Produksinya', '2018-05-29', 'Kate Springer', 'VN in awalnya rilis pada April 2016 untuk PC dan rilis pada PlayStation Vita di 23 Februari\r\n					2017. Terdapat juga adaptasi manga karya Naoya Yao yang rilis pada April 2016.\r\n					<br><br>\r\n					Island menceritakan tentang pulau bernama Urashima. Sebuah insiden yang menimpa tiga keluarga besar pulau tersebut dari lima tahun yang lalu menyebabkan pulau tersebut terisolasi. Pulau tersebut terisolasi akibat penyakit lokal bernama Baimonbyou, tiga gadis dari pulau tersebut merupakan kunci untuk menyelamatkan pulau itu, namun tradisi membuat mereka tidak dapat bertindak. Suatu hari sebuah pria terdampar di pulau tersebut dan mengubah segalanya.', 'Situs resmi dari adaptasi anime “ISLAND” telah mengungkap staf produksinya. Adaptasi VN ini direncanakan tayang pada tahun 2018 ini.\r\n					<br><br>\r\n					Staf produksinya adalah:\r\n					<br><br>\r\n					<li>Sutradara: Keiichiro Kawaguchi</li>\r\n					<li>Komposisi Seri: Naruhisa Arakawa</li>\r\n					<li>Desainer Karakter: Kousuke Kawamura</li>\r\n					<li>Musik: Akiyuki Tateyama</li>\r\n					<li>Lagu Pembuka: Yukari Tamura</li>\r\n					<li>Lagu Penutup: Asaka</li>\r\n					<li>Studio Produksi: feel.</li>\r\n					<br>\r\n					Seiyuu yang akan hadir beserta peran mereka adalah:\r\n					<br><br>\r\n					<li>Yukari Tamura sebagai <b>Rinne Ohara</b></li>\r\n					<li>Kana Asumi sebagai <b>Karen Kurutsu</b></li>\r\n					<li>Hibiku Yamamura <b>sebagai Sora Garandou</b></li>\r\n					<br>\r\n					VN in awalnya rilis pada April 2016 untuk PC dan rilis pada PlayStation Vita di 23 Februari\r\n					2017. Terdapat juga adaptasi manga karya Naoya Yao yang rilis pada April 2016.\r\n					<br><br>\r\n					Island menceritakan tentang pulau bernama Urashima. Sebuah insiden yang menimpa tiga keluarga besar pulau tersebut dari lima tahun yang lalu menyebabkan pulau tersebut terisolasi. Pulau tersebut terisolasi akibat penyakit lokal bernama Baimonbyou, tiga gadis dari pulau tersebut merupakan kunci untuk menyelamatkan pulau itu, namun tradisi membuat mereka tidak dapat bertindak. Suatu hari sebuah pria terdampar di pulau tersebut dan mengubah segalanya.\r\n					<br><br>\r\n					Gamenya diproduksi oleh Ryuichiro Yamakawa, Yousai Kuuchuu adalah ilustrator seri ini, sementara G.O. mengerjakan skenarionya.', NULL, 'assets/image/island.jpg'),
(4, 1, '‘Grand Blue’ Tampilkan Teaser Anime dan Ungkap Staf Produksi', '2018-05-28', 'Kate Springer', 'Seri ini menceritakan tentang Kitahara Iori yang pindah ke Izu untuk kuliah, di sana dia menetap di toko alat selam bernama “Grand Blue” yang dimiliki oleh kerabatnya. Setelah berbagai insiden yang melibatkan kakak kelas dan sepupunya yang bergabung dengan circle menyelam tingkat universitas, dia memutuskan untuk ikut mencoba menyelam juga.', NULL, NULL, 'assets/image/grand.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `paymenthistory`
--

CREATE TABLE `paymenthistory` (
  `PaymentHistoryID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `BankID` int(11) DEFAULT NULL,
  `PaymentStatus` bit(1) DEFAULT NULL,
  `AccountNumber` varchar(20) DEFAULT NULL,
  `PaymentPlan` varchar(10) DEFAULT NULL,
  `PaymentTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `releaseseason`
--

CREATE TABLE `releaseseason` (
  `ReleaseSeasonID` int(11) NOT NULL,
  `ReleaseSeason` varchar(10) NOT NULL,
  `SeasonFlag` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `series`
--

INSERT INTO `series` (`SeriesID`, `Series`) VALUES
(1, 'Yuru Camp'),
(2, 'Violet Evergarden'),
(3, 'Karakai Jouzu'),
(4, 'Overlord'),
(5, 'Koi wa Ameagari no You ni');

-- --------------------------------------------------------

--
-- Table structure for table `source`
--

CREATE TABLE `source` (
  `SourceID` int(11) NOT NULL,
  `Source` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `studio`
--

INSERT INTO `studio` (`StudioID`, `Studio`) VALUES
(1, 'Kyoto Animation'),
(2, 'Shin-Ei Animation'),
(3, 'C-Station'),
(4, 'Madhouse'),
(5, 'Wit Studio');

-- --------------------------------------------------------

--
-- Table structure for table `subscription`
--

CREATE TABLE `subscription` (
  `AnimeID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `SubscriptionStatus` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `subscription`
--

INSERT INTO `subscription` (`AnimeID`, `UserID`, `SubscriptionStatus`) VALUES
(1, 1, b'1'),
(2, 1, b'1'),
(2, 3, b'1'),
(3, 2, b'1'),
(4, 1, b'1'),
(4, 3, b'1'),
(4, 4, b'1'),
(5, 1, b'1');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `TagsID` int(11) NOT NULL,
  `Tag` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`TagsID`, `Tag`) VALUES
(1, 'Anime'),
(2, 'Culinary'),
(3, 'Events'),
(4, 'Hobby'),
(5, 'Japanese Culture'),
(6, 'Light Novel'),
(7, 'Manga'),
(8, 'Movie'),
(9, 'Music'),
(10, 'Place & Travel'),
(11, 'Vocaloid');

-- --------------------------------------------------------

--
-- Table structure for table `username`
--

CREATE TABLE `username` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(25) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `Email` varchar(25) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `SubStatus` varchar(10) NOT NULL DEFAULT 'FREE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `username`
--

INSERT INTO `username` (`UserID`, `Username`, `Password`, `Email`, `Gender`, `SubStatus`) VALUES
(1, 'EZ', '123123', 'ez@gmail.com', 'Male', 'FREE'),
(2, 'HY', '123123', 'hy@gmail.com', 'Male', 'FREE'),
(3, 'Will', '123123', 'will@gmail.com', 'Male', 'FREE'),
(4, 'Andree', '123123', 'andree@gmail.com', 'Male', 'FREE');

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

-- --------------------------------------------------------

--
-- Table structure for table `watchlater`
--

CREATE TABLE `watchlater` (
  `WatchLaterID` int(11) NOT NULL,
  `EpisodeID` int(11) DEFAULT NULL,
  `UserID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  ADD KEY `DurationID` (`DurationID`),
  ADD KEY `SourceID` (`SourceID`);

--
-- Indexes for table `animeandgenres`
--
ALTER TABLE `animeandgenres`
  ADD PRIMARY KEY (`AnimeID`,`GenreID`),
  ADD KEY `GenreID` (`GenreID`);

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
  ADD KEY `UserID` (`UserID`);

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
  ADD PRIMARY KEY (`NewsID`),
  ADD KEY `TagsID` (`TagsID`);

--
-- Indexes for table `paymenthistory`
--
ALTER TABLE `paymenthistory`
  ADD PRIMARY KEY (`PaymentHistoryID`),
  ADD KEY `BankID` (`BankID`),
  ADD KEY `UserID` (`UserID`);

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
  ADD PRIMARY KEY (`AnimeID`,`UserID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`TagsID`);

--
-- Indexes for table `username`
--
ALTER TABLE `username`
  ADD PRIMARY KEY (`UserID`);

--
-- Indexes for table `watchhistories`
--
ALTER TABLE `watchhistories`
  ADD PRIMARY KEY (`WatchHistoryID`),
  ADD KEY `EpisodeID` (`EpisodeID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `watchlater`
--
ALTER TABLE `watchlater`
  ADD PRIMARY KEY (`WatchLaterID`),
  ADD KEY `EpisodeID` (`EpisodeID`),
  ADD KEY `UserID` (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `anime`
--
ALTER TABLE `anime`
  MODIFY `AnimeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bankdetail`
--
ALTER TABLE `bankdetail`
  MODIFY `BankID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `EpisodeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `GenreID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `NewsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `SeriesID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `source`
--
ALTER TABLE `source`
  MODIFY `SourceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `studio`
--
ALTER TABLE `studio`
  MODIFY `StudioID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `TagsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `username`
--
ALTER TABLE `username`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  ADD CONSTRAINT `anime_ibfk_4` FOREIGN KEY (`DurationID`) REFERENCES `durations` (`DurationID`),
  ADD CONSTRAINT `anime_ibfk_5` FOREIGN KEY (`SourceID`) REFERENCES `source` (`SourceID`);

--
-- Constraints for table `animeandgenres`
--
ALTER TABLE `animeandgenres`
  ADD CONSTRAINT `animeandgenres_ibfk_1` FOREIGN KEY (`AnimeID`) REFERENCES `anime` (`AnimeID`),
  ADD CONSTRAINT `animeandgenres_ibfk_2` FOREIGN KEY (`GenreID`) REFERENCES `genres` (`GenreID`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`EpisodeID`) REFERENCES `episodes` (`EpisodeID`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `username` (`UserID`);

--
-- Constraints for table `episodes`
--
ALTER TABLE `episodes`
  ADD CONSTRAINT `episodes_ibfk_1` FOREIGN KEY (`AnimeID`) REFERENCES `anime` (`AnimeID`);

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`TagsID`) REFERENCES `tags` (`TagsID`);

--
-- Constraints for table `paymenthistory`
--
ALTER TABLE `paymenthistory`
  ADD CONSTRAINT `paymenthistory_ibfk_1` FOREIGN KEY (`BankID`) REFERENCES `bankdetail` (`BankID`),
  ADD CONSTRAINT `paymenthistory_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `username` (`UserID`);

--
-- Constraints for table `subscription`
--
ALTER TABLE `subscription`
  ADD CONSTRAINT `subscription_ibfk_1` FOREIGN KEY (`AnimeID`) REFERENCES `anime` (`AnimeID`),
  ADD CONSTRAINT `subscription_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `username` (`UserID`);

--
-- Constraints for table `watchhistories`
--
ALTER TABLE `watchhistories`
  ADD CONSTRAINT `watchhistories_ibfk_1` FOREIGN KEY (`EpisodeID`) REFERENCES `episodes` (`EpisodeID`),
  ADD CONSTRAINT `watchhistories_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `username` (`UserID`);

--
-- Constraints for table `watchlater`
--
ALTER TABLE `watchlater`
  ADD CONSTRAINT `watchlater_ibfk_1` FOREIGN KEY (`EpisodeID`) REFERENCES `episodes` (`EpisodeID`),
  ADD CONSTRAINT `watchlater_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `username` (`UserID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
