-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2018 at 10:03 AM
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CheckPass` (IN `InUsername` VARCHAR(25))  BEGIN
	SELECT u.Password
    FROM user u
    WHERE u.Username = InUsername;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CheckSubStatus` (IN `InUsername` VARCHAR(25))  BEGIN
    SELECT u.SubStatus,CASE WHEN u.SubExpDate IS NOT NULL THEN
    CASE WHEN CAST(NOW() AS DATE) <= u.SubExpDate THEN 'Active' 
    ELSE 'Expire' END END AS Status
    FROM user u 
    WHERE u.Username = InUsername;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CheckUsername` (IN `InUsername` VARCHAR(25))  BEGIN
	SELECT EXISTS(SELECT u.Username FROM user u
          WHERE u.Username = InUsername) AS Status;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteWatchHistory` (IN `InUsername` VARCHAR(25), IN `InHistoryID` INT)  BEGIN
    DELETE h FROM watchhistories h
        JOIN user u ON h.UserID = u.UserID
    WHERE u.Username = InUsername AND
       h.WatchHistoryID = InHistoryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DoPayment` (IN `InBankID` INT, IN `InPaymentStatus` VARCHAR(20), IN `InPaymentPlan` VARCHAR(20), IN `InUsername` VARCHAR(25), IN `InAccountNumber` VARCHAR(20), IN `InAccountName` VARCHAR(30), IN `CardExpDate` DATE)  BEGIN
     SET @UserID = (SELECT u.UserID FROM user u WHERE u.Username = InUsername);
     
     INSERT INTO `paymenthistory` (`PaymentHistoryID`, `UserID`, `BankID`, `PaymentStatus`, `AccountName`, `AccountNumber`, `PaymentPlan`, `CardExpDate`, `PaymentTime`) VALUES (NULL, @UserID, InBankID, InPaymentStatus, InAccountName, InAccountNumber, InPaymentPlan, CardExpDate, NOW());
     
     UPDATE user u SET u.SubStatus = InPaymentStatus, 
     u.SubExpDate = (CASE WHEN InPaymentPlan = 'Monthly' 
     THEN CAST(DATE_SUB(NOW(), INTERVAL -1 MONTH) AS DATE) 
     ELSE CAST(DATE_SUB(NOW(), INTERVAL -1 YEAR) AS DATE) END)
     WHERE u.Username = InUsername;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAnimeDetail` (IN `InAnimeID` INT)  BEGIN

DROP TABLE IF EXISTS temp;

CREATE TABLE temp SELECT a.AnimeID
FROM anime a
WHERE a.EpisodeTotal = (
	SELECT MAX(e.Episode)
    FROM episodes e
    WHERE a.AnimeID = e.AnimeID
    GROUP BY a.AnimeID);

SELECT DISTINCT a.AnimeTitle, a.ThumbnailLandscape, a.PromotionalVideo, a.PVHeadScript, s.Source, a.EpisodeTotal, a.Synopsis, st.Studio, d.Duration, pg.RatingDetails, b.Genres, COUNT(fow.AnimeID) AS Follower, (CASE WHEN a.AnimeID IN (SELECT * FROM temp) THEN 'Completed' ELSE 'On Going' END) AS Status
    FROM anime a
    JOIN pgratingdetails pg oN a.RatingID = pg.RatingID
    JOIN source s ON a.SourceID = s.SourceID
    JOIN durations d ON a.DurationID = d.DurationID
    JOIN followanime fow ON a.AnimeID = fow.AnimeID
    JOIN releaseseason rs ON a.ReleaseSeasonID = rs.ReleaseSeasonID
    JOIN studio st ON a.StudioID = st.StudioID,
    (SELECT a.AnimeID, substring_index(GROUP_CONCAT(DISTINCT g.Genre     
     SEPARATOR ', '),', ', 5) AS Genres 
     FROM anime a 
     JOIN animeandgenres ag ON a.AnimeID = ag.AnimeID
     JOIN genres g ON ag.GenreID = g.GenreID
     GROUP BY a.AnimeID) b
    WHERE a.AnimeID = b.AnimeID
    AND a.AnimeID = InAnimeID
    GROUP BY a.AnimeTitle, a.Thumbnail, s.Source, a.EpisodeTotal,
    d.Duration;
    


DROP TABLE temp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAnimeLatestUpdate` ()  BEGIN
    SELECT a.AnimeID, MAX(e.EpisodeID) AS EpisodeID, a.AnimeTitle, a.Thumbnail, MAX(e.Episode) AS LatestEpisode, MAX(e.EpsDateAir) AS AirDate
    FROM anime a
    JOIN episodes e ON a.AnimeID = e.AnimeID
    GROUP BY a.AnimeID
    ORDER BY AirDate DESC
    LIMIT 100;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAnimeList` (IN `inYear` VARCHAR(5), IN `inSeason` VARCHAR(10), IN `inStat` VARCHAR(10), IN `inDuration` VARCHAR(20), IN `inSort` VARCHAR(10))  BEGIN

DROP TABLE IF EXISTS temp;

CREATE TABLE temp SELECT a.AnimeID
FROM anime a
WHERE a.EpisodeTotal = (
	SELECT MAX(e.Episode)
    FROM episodes e
    WHERE a.AnimeID = e.AnimeID
    GROUP BY a.AnimeID);


SELECT DISTINCT a.AnimeID, a.AnimeTitle, a.Thumbnail, s.Source, a.EpisodeTotal, d.Duration, COUNT(fow.AnimeID) AS Follower, b.Genres
    FROM anime a
    JOIN source s ON a.SourceID = s.SourceID
    JOIN durations d ON a.DurationID = d.DurationID
    LEFT JOIN followanime fow ON a.AnimeID = fow.AnimeID
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
    AND CASE WHEN inStat = 'Completed' THEN a.AnimeID IN (SELECT * FROM temp) ELSE a.AnimeID NOT IN (SELECT * FROM temp) END
    GROUP BY a.AnimeTitle, a.Thumbnail, s.Source, a.EpisodeTotal,
    d.Duration
    ORDER BY CASE WHEN inSort = 'Title' THEN a.AnimeTitle END ASC, COUNT(a.AnimeID) DESC;
    
    DROP TABLE temp;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAnimePageEpisodes` (IN `InAnimeID` INT, IN `InSort` VARCHAR(10))  BEGIN
SELECT e.AnimeID, e.EpisodeID, e.EpsThumbnail, e.Episode, e.EpsTitle, e.EpisodeTotalViews, DATE_FORMAT(e.EpsDateAir, "%d %b %Y") AS EpsDateAir FROM episodes e
WHERE e.AnimeID = InAnimeID
ORDER BY CASE WHEN InSort = 'Oldest' THEN e.EpsDateAir END ASC,
         CASE WHEN InSort = 'Newest' THEN e.EpsDateAir END DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAnimeRank` (IN `InAnimeID` INT)  BEGIN
    SELECT ani.AnimeTitle, que.Follower, que.Rank FROM anime ani,
    (SELECT 
     @rownum := @rownum +1 AS Rank,
     prequery.AnimeID,
     prequery.Follower
    FROM
    (SELECT @rownum := 0) sqlvars,
    (SELECT a.AnimeID, COUNT(f.UserID) AS Follower
    FROM anime a
    JOIN followanime f ON a.AnimeID = f.AnimeID
    GROUP BY a.AnimeID
    ORDER BY Follower DESC, a.AnimeTitle ASC) prequery) que
    WHERE ani.AnimeID = que.AnimeID
    AND ani.AnimeID = InAnimeID
    ORDER BY que.Rank;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAnimeSearch` (IN `inSearch` LONGTEXT, IN `inDuration` INT, IN `inGenre` LONGTEXT, IN `inLimit` INT, IN `inOffset` INT, OUT `outTotalRow` INT)  BEGIN
SELECT SQL_CALC_FOUND_ROWS a.AnimeID, a.AnimeTitle, a.Thumbnail, a.ThumbnailLandscape, d.Duration, MAX(e.Episode) as LatestEpisode, b.Follower, c.Genres   
FROM anime a    
JOIN episodes e ON a.AnimeID = e.AnimeID  
JOIN durations d ON a.DurationID = d.DurationID,    
(SELECT a.AnimeID, COUNT(f.UserID) AS Follower   
 FROM anime a 
 JOIN followanime f ON a.AnimeID = f.AnimeID   
 GROUP BY a.AnimeID) b,    
 (SELECT a.AnimeID, substring_index(GROUP_CONCAT(DISTINCT g.Genre         SEPARATOR ', '),', ', 5) AS Genres    
  FROM anime a    
  JOIN animeandgenres ag ON a.AnimeID = ag.AnimeID    
  JOIN genres g ON ag.GenreID = g.GenreID     
  WHERE g.Genre REGEXP inGenre
  GROUP BY a.AnimeID) AS c  
  WHERE a.AnimeID = b.AnimeID    
  AND a.AnimeID = c.AnimeID   
  AND a.AnimeTitle LIKE CONCAT('%',inSearch, '%')    
  AND CASE WHEN inDuration <> 0 THEN a.DurationID = inDuration END
  GROUP BY a.AnimeID   LIMIT inLimit OFFSET inOffset;
    
    SET outTotalRow = FOUND_ROWS();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetBankDetail` ()  BEGIN
	SELECT * FROM bankdetail;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetDuration` ()  BEGIN
	SELECT * FROM durations;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetEpisodeSearch` (IN `inSearch` LONGTEXT, IN `inDuration` INT, IN `inGenre` LONGTEXT, IN `inLimit` INT, IN `inOffset` INT, OUT `outTotalRow` INT)  BEGIN
    SELECT SQL_CALC_FOUND_ROWS a.AnimeID, e.EpisodeID, a.AnimeTitle, a.Thumbnail, e.EpsThumbnail, d.Duration, e.Episode, e.EpsTitle, DATE_FORMAT(e.EpsDateAir, "%d %b %Y") AS EpsDateAir, e.EpisodeTotalViews, b.Genres
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
 	AND CASE WHEN inDuration <> 0 THEN a.DurationID = inDuration END
    AND a.AnimeTitle LIKE CONCAT('%', inSearch, '%')
    ORDER BY e.EpisodeTotalViews DESC
    LIMIT inLimit OFFSET inOffset;
    SET outTotalRow = FOUND_ROWS();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getEpisodeStream` (IN `InAnimeID` INT, IN `InEpisodeID` INT)  BEGIN
    SELECT a.AnimeTitle, a.SeriesID, e.EpisodeID, e.EpsTitle, e.Episode, DATE_FORMAT(e.EpsDateAir, "%d %b %Y") AS EpsDateAir, e.EpisodeTotalViews, e.HeadScriptVideo, e.StreamVideo
    FROM episodes e
    JOIN anime a ON e.AnimeID = a.AnimeID
    WHERE e.AnimeID = InAnimeID
    AND e.EpisodeID = InEpisodeID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetFollowing` (IN `InUsername` VARCHAR(25))  BEGIN
    SELECT u.Username, a.AnimeID, CASE WHEN LENGTH(a.AnimeTitle) > 12 THEN CONCAT(SUBSTRING(a.AnimeTitle,1,10), '...') ELSE a.AnimeTitle END AS AnimeTitle FROM user u
    JOIN followanime f ON f.UserID = u.UserID
    JOIN anime a ON a.AnimeID = f.AnimeID
    WHERE u.Username = InUsername;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetGenre` ()  BEGIN
	SELECT * FROM genres;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getLatestNews` (IN `InNewsID` INT)  BEGIN
    SELECT DATE_FORMAT(n.PublishDate, "%d %b %Y") as PublishDate, n.NewsTitle, n.NewsID
    FROM news n
    WHERE n.NewsID <> InNewsID
    ORDER BY n.PublishDate DESC
    LIMIT 30;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetMostPopular` ()  BEGIN
	SELECT CASE WHEN LENGTH(ani.AnimeTitle) > 12 THEN CONCAT(SUBSTRING(ani.AnimeTitle,1,10), '...') ELSE ani.AnimeTitle END AS AnimeTitle, ani.AnimeID, que.Follower, que.Rank FROM anime ani,
    (SELECT 
     @rownum := @rownum +1 AS Rank,
     prequery.AnimeID,
     prequery.Follower
     FROM
     (SELECT @rownum := 0) sqlvars,
     (SELECT a.AnimeID, COUNT(f.UserID) AS Follower
      FROM anime a
      LEFT JOIN followanime f ON a.AnimeID = f.AnimeID
      GROUP BY a.AnimeID
      ORDER BY Follower DESC, a.AnimeTitle ASC) prequery) que
    WHERE ani.AnimeID = que.AnimeID
    ORDER BY que.Rank
    LIMIT 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getNewsDetail` (IN `InNewsID` INT)  BEGIN
    SELECT t.Tag, n.NewsTitle, n.writer, DATE_FORMAT(n.PublishDate, "%d %b %Y") as PublishDate, 
    n.NewsContent, n.NewsImage
    FROM news n 
    JOIN tags t ON t.TagsID = n.TagsID
    WHERE n.NewsID = InNewsID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetNewsLatestUpdate` ()  BEGIN
    SELECT n.NewsID, n.NewsTitle, n.PublishDate, n.NewsThumbnail, n.Headline 
    FROM news n
    ORDER BY n.PublishDate DESC
    LIMIT 2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetNextEps` (IN `InAnimeID` INT, IN `IncurrEps` INT)  BEGIN
    SELECT e.AnimeID, e.EpisodeID, e.EpsTitle, e.Episode, e.EpsThumbnail FROM episodes e
    WHERE e.AnimeID = InAnimeID
    AND e.Episode = (IncurrEps+1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetPaymentHistory` ()  BEGIN
    SELECT u.Username, b.BankName, p.PaymentStatus, p.PaymentPlan ,
    p.PaymentTime
    FROM paymenthistory p
    JOIN user u ON u.UserID = p.UserID
    JOIN bankdetail b ON b.BankID = p.BankID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetPrevEps` (IN `InAnimeID` INT, IN `IncurrEps` INT)  BEGIN
    SELECT e.AnimeID, e.EpisodeID, e.EpsTitle, e.Episode, e.EpsThumbnail FROM episodes e
    WHERE e.AnimeID = InAnimeID
    AND e.Episode = (IncurrEps-1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getRecomendedAnime` (IN `InAnimeID` INT, IN `InSeriesID` INT, IN `InOffset` INT, IN `InLimit` INT)  BEGIN
    SELECT * FROM (
	SELECT a.AnimeID, a.SeriesID, a.AnimeTitle, a.EpisodeTotal, a.ThumbnailLandscape, a.AnimeReleaseDate, COUNT(f.AnimeID) AS Follower, 0 AS OrderQue
    FROM anime a
    JOIN releaseseason rs 
    ON a.ReleaseSeasonID = rs.ReleaseSeasonID
    LEFT JOIN followanime f
    ON a.AnimeID = f.AnimeID
    WHERE a.SeriesID = InSeriesID
    AND a.AnimeID <> InAnimeID
    AND YEAR(a.AnimeReleaseDate) = YEAR(NOW())
    AND rs.SeasonFlag = FLOOR((MONTH(NOW())-1)/3)
    GROUP BY a.animeTitle, a.Thumbnail, a.AnimeReleaseDate
    ORDER BY FIELD(a.SeriesID, InSeriesID) DESC, a.AnimeTitle ASC
) AS que1
UNION ALL
	SELECT * FROM (
    SELECT a.AnimeID, a.SeriesID, a.AnimeTitle, a.EpisodeTotal, a.ThumbnailLandscape, a.AnimeReleaseDate, COUNT(f.AnimeID) AS Follower, 1 AS OrderQue
    FROM anime a
    JOIN releaseseason rs 
    ON a.ReleaseSeasonID = rs.ReleaseSeasonID
    LEFT JOIN followanime f
    ON a.AnimeID = f.AnimeID
    WHERE a.SeriesID <> InSeriesID
    AND YEAR(a.AnimeReleaseDate) = YEAR(NOW())
    AND rs.SeasonFlag = FLOOR((MONTH(NOW())-1)/3)
    GROUP BY a.animeTitle, a.Thumbnail, a.AnimeReleaseDate
    ORDER BY Follower DESC, a.AnimeTitle ASC
) AS que2
ORDER BY OrderQue ASC
LIMIT InLimit OFFSET InOffset;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetRelatedAnime` (IN `InAnimeID` INT)  BEGIN
    SELECT a.AnimeID, a.AnimeTitle FROM anime a
    WHERE a.SeriesID = (SELECT s.SeriesID FROM series s
                        JOIN anime ani ON ani.SeriesID = s.SeriesID
                        WHERE AnimeID = InAnimeID)
	AND a.AnimeID <> InAnimeID
    LIMIT 9;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetSeries` ()  BEGIN
	SELECT * FROM series;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetSource` ()  BEGIN
	SELECT * FROM source;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetStudio` ()  BEGIN
	SELECT * FROM studio;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetTags` ()  BEGIN
	SELECT * FROM tags;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetTopAiringAnime` (IN `InUsername` VARCHAR(25))  BEGIN
    SELECT que1.AnimeID, que1.AnimeTitle, que1.Thumbnail, que1.AnimeReleaseDate, que1.Follower, que2.FollowStatus FROM (SELECT a.AnimeID, a.AnimeTitle, a.Thumbnail, a.AnimeReleaseDate, COUNT(f.AnimeID) AS Follower FROM anime a
    JOIN releaseseason rs 
    ON a.ReleaseSeasonID = rs.ReleaseSeasonID
    LEFT JOIN followanime f
    ON a.AnimeID = f.AnimeID
    LEFT JOIN user u ON u.UserID = f.UserID
    WHERE YEAR(a.AnimeReleaseDate) = YEAR(NOW())
    AND rs.SeasonFlag = FLOOR((MONTH(NOW())-1)/3)
    GROUP BY a.animeTitle, a.Thumbnail, a.AnimeReleaseDate
    ORDER BY Follower DESC, a.AnimeTitle ASC) que1
    LEFT JOIN (SELECT a.AnimeID, a.AnimeTitle, u.Username, f.FollowStatus FROM anime a 
    LEFT JOIN followanime f ON f.AnimeID = a.AnimeID
    LEFT JOIN user u ON u.UserID = f.UserID
    WHERE u.Username LIKE InUsername) que2 ON que1.AnimeID = que2.AnimeID
    LIMIT 5;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getWatchHistory` (IN `InUsername` VARCHAR(25))  BEGIN
    SELECT h.WatchHistoryID, e.EpsThumbnail, e.EpisodeID, DATE_FORMAT(e.EpsDateAir, "%d %b %Y") as DateAir, e.EpsTitle, a.AnimeTitle, e.EpisodeTotalViews, h.UserID, h.WatchTime 
    FROM watchhistories h
    JOIN episodes e ON e.EpisodeID = h.EpisodeID
    JOIN anime a ON a.AnimeID = e.AnimeID
    JOIN user u ON u.UserID = h.UserID
    WHERE InUsername = u.Username
    ORDER BY DateAir DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertUser` (IN `InUsername` VARCHAR(25), IN `InPass` VARCHAR(30), IN `InEmail` VARCHAR(25), IN `InGender` VARCHAR(10))  BEGIN
    INSERT INTO `user` (`UserID`, `Username`, `Password`, `Email`, `Gender`, `SubStatus`) 
    VALUES (NULL, InUsername, InPass, InEmail, InGender, 'FREE');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_loginCheck` (IN `InUsername` VARCHAR(25), IN `InPassword` VARCHAR(30))  BEGIN
    SELECT EXISTS(SELECT u.Username FROM user u 
    WHERE u.Username = InUsername
    AND u.Password = InPassword) AS Status;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateTotalViews` (IN `InEpisodeID` INT, IN `InViews` INT)  BEGIN
    UPDATE episodes e SET e.EpisodeTotalViews = InViews WHERE e.EpisodeID = InEpisodeID;
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
  `RatingID` int(11) DEFAULT NULL,
  `AnimeTitle` longtext,
  `Synopsis` longtext,
  `SeasonID` varchar(35) DEFAULT NULL,
  `EpisodeTotal` int(11) DEFAULT NULL,
  `Thumbnail` longtext,
  `ThumbnailLandscape` longtext NOT NULL,
  `PromotionalVideo` longtext NOT NULL,
  `PVHeadScript` longtext NOT NULL,
  `AnimeReleaseDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `anime`
--

INSERT INTO `anime` (`AnimeID`, `SeriesID`, `StudioID`, `SourceID`, `ReleaseSeasonID`, `DurationID`, `RatingID`, `AnimeTitle`, `Synopsis`, `SeasonID`, `EpisodeTotal`, `Thumbnail`, `ThumbnailLandscape`, `PromotionalVideo`, `PVHeadScript`, `AnimeReleaseDate`) VALUES
(1, 1, 3, 3, 2, 2, 2, 'Yuru Camp△', 'While the perfect getaway for most girls her age might be a fancy vacation with their loved ones, Rin \r\n					 Shima\'s ideal way of spending her days off is camping alone at the base of Mount Fuji. From pitching her tent\r\n					 to gathering firewood, she has always done everything by herself, and has no plans of leaving her little\r\n					 solitary world.\r\n					<br><br>\r\n						However, what starts off as one of Rin\'s usual camping sessions somehow ends up as a surprise \r\n					get-together for two when the lost Nadeshiko Kagamihara is forced to take refuge at her campsite. \r\n					Originally intending to see the picturesque view of Mount Fuji for herself, Nadeshiko\'s plans are disrupted when she ends up falling asleep partway to her destination. Alone and with no other choice, she seeks help from the only other person nearby. Despite their hasty introductions, the two girls nevertheless enjoy the chilly night together, eating ramen and conversing while the campfire keeps them warm. And even after Nadeshiko\'s sister finally picks her up later that night, both girls silently ponder the possibility of another camping trip together.', 'YuruCampS001', 12, 'assets/image/yurucamp.jpg', 'assets/image/yuruwall.png', 'wistia_async_iz35go3560', '<script src=\"https://fast.wistia.com/embed/medias/iz35go3560.jsonp\" async></script>', '2018-05-01'),
(2, 2, 1, 2, 2, 2, 2, 'Violet Evergarden', 'The Great War finally came to an end after four long years of conflict; fractured in two, the continent of Telesis slowly began to flourish once again. Caught up in the bloodshed was Violet Evergarden, a young girl raised for the sole purpose of decimating enemy lines. Hospitalized and maimed in a bloody skirmish during the War\'s final leg, she was left with only words from the person she held dearest, but with no understanding of their meaning.\r\n\r\nRecovering from her wounds, Violet starts a new life working at CH Postal Services after a falling out with her new intended guardian family. There, she witnesses by pure chance the work of an \"Auto Memory Doll,\" amanuenses that transcribe people\'s thoughts and feelings into words on paper. Moved by the notion, Violet begins work as an Auto Memory Doll, a trade that will take her on an adventure, one that will reshape the lives of her clients and hopefully lead to self-discovery.', 'VioletEvergardenS001', 13, 'assets/image/violet.jpg', '', '', '', '2018-05-11'),
(3, 3, 2, 3, 2, 2, 2, 'Karakai Jouzu no Takagi-san', '\"If you blush, you lose.\"\r\n\r\nLiving by this principle, the middle schooler Nishikata gets constantly made fun of by his seat neighbor Takagi-san. With his pride shattered to pieces, he vows to turn the tables and get back at her some day. And so, he attempts to tease her day after day, only to find himself victim to Takagi-san\'s ridicule again sooner than later. Will he be able to make Takagi-san blush from embarrassment even once in the end?', 'KarakaiJouzuS001', 12, 'assets/image/karakai.jpg', '', '', '', '2018-05-08'),
(4, 4, 4, 2, 2, 2, 2, 'Overlord II', 'The final hour of the popular virtual reality game Yggdrasil has come. However, Momonga, a powerful wizard and master of the dark guild Ainz Ooal Gown, decides to spend his last few moments in the game as the servers begin to shut down. To his surprise, despite the clock having struck midnight, Momonga is still fully conscious as his character and, moreover, the non-player characters appear to have developed personalities of their own!\r\n\r\nConfronted with this abnormal situation, Momonga commands his loyal servants to help him investigate and take control of this new world, with the hopes of figuring out what has caused this development and if there may be others in the same predicament.', 'OverlordS001', 13, 'assets/image/overlord.png', '', '', '', '2018-05-08'),
(5, 5, 5, 3, 2, 2, 2, 'Koi wa Ameagari no You ni', 'Akira Tachibana, a reserved high school student and former track runner, has not been able to race the same as she used to since she experienced a severe foot injury. And although she is regarded as attractive by her classmates, she is not interested in the boys around school.\r\n\r\nWhile working part-time at the Garden Cafe, Akira begins to develop feelings for the manager—a 45-year-old man named Masami Kondou—despite the large age gap. Kondou shows genuine concern and kindness toward the customers of his restaurant, which, while viewed by others as soft or weak, draws Akira to him. Spending time together at the restaurant, they grow closer, which only strengthens her feelings. Weighed down by these uncertain emotions, Akira finally resolves to confess, but what will be the result?', 'KoiwaS001', 12, 'assets/image/koiwa.jpg', '', '', '', '2018-05-29'),
(6, 1, 3, 3, 2, 2, 2, 'Yuru Camp△ Season 2', NULL, 'YuruCampS002', 13, NULL, '', '', '', '2018-06-01');

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
(5, 19),
(6, 3),
(6, 26);

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
  `EpisodeTotalViews` int(11) NOT NULL DEFAULT '0',
  `EpsThumbnail` longtext NOT NULL,
  `StreamVideo` longtext,
  `HeadScriptVideo` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `episodes`
--

INSERT INTO `episodes` (`EpisodeID`, `AnimeID`, `EpsTitle`, `EpsDateAir`, `Episode`, `EpisodeTotalViews`, `EpsThumbnail`, `StreamVideo`, `HeadScriptVideo`) VALUES
(1, 1, 'Mount Fuji and Curry Noodles', '2018-01-04 00:00:00', 1, 19, 'assets/image/YuruCampEps1.jpg', 'wistia_async_zqo0g6k2c5', '<script src=\"https://fast.wistia.com/embed/medias/zqo0g6k2c5.jsonp\" async></script>'),
(2, 1, 'Welcome to the Outdoor Activities Club', '2018-01-11 00:00:00', 2, 2, 'assets/image/YuruCampEps2.jpg', 'wistia_async_nszp6qskon', '<script src=\"https://fast.wistia.com/embed/medias/nszp6qskon.jsonp\" async>'),
(3, 1, 'Mount Fuji and Relaxed Hot Pot Camp', '2018-01-18 00:00:00', 3, 0, '', NULL, '0'),
(4, 2, '\"I Love You\" and Auto Memory Dolls', '2018-01-11 00:00:00', 1, 0, '', NULL, '0'),
(5, 2, 'Never Coming Back', '2018-01-18 00:00:00', 2, 0, '', NULL, '0'),
(6, 2, 'May You Be an Exemplary Auto Memory Doll', '2018-01-25 00:00:00', 3, 0, '', NULL, '0'),
(7, 3, 'Eraser / Day Duty / Funny Face / One Hundred Yen', '2018-01-08 00:00:00', 1, 0, '', NULL, '0'),
(8, 3, 'Calligraphy / Seasonal Change of Clothing / Pool', '2018-01-15 00:00:00', 2, 0, '', NULL, '0'),
(9, 4, 'End and Beginning', '2018-05-29 00:00:00', 1, 0, '', NULL, '0'),
(10, 5, 'The Sound of Rain', '2018-05-30 00:00:00', 1, 0, '', NULL, '0'),
(11, 1, 'The Outdoor Activities Club and the Solo Camping Girl', '2018-05-31 00:00:00', 4, 0, '', NULL, '0'),
(12, 3, 'Coffee / Empty Can / Soda / Muscle Training / Dubbing / Umbrella', '2018-05-31 01:00:00', 3, 0, '', NULL, '0'),
(13, 1, 'Two Camps, Two Campers\' Views', '2018-06-02 00:00:00', 5, 0, '', NULL, '0'),
(14, 1, 'Meat and Fall Colors and the Mystery Lake', '2018-06-07 00:00:00', 6, 0, '', NULL, '0'),
(15, 1, 'A Night on the Lake Shore and Campers', '2018-06-14 00:00:00', 7, 0, '', NULL, '0'),
(16, 1, 'Exams, Caribou, Steamed Buns, Yum!', '2018-06-15 00:00:00', 8, 0, '', NULL, '0'),
(17, 1, 'A Night of Navigator Nadeshiko and Hot Spring Steam', '2018-06-16 00:00:00', 9, 0, '', 'A Night of Navigator Nadeshiko and Hot Spring Steam', '0'),
(18, 1, 'Clumsy Travelers and Camp Meetings', '2018-06-17 00:00:00', 10, 0, '', NULL, '0'),
(19, 1, 'Christmas Camp!', '2018-06-18 00:00:00', 11, 0, '', NULL, '0'),
(20, 1, 'Mount Fuji and the Laid-Back Camp Girls', '2018-07-23 00:00:00', 12, 0, '', NULL, '0'),
(21, 2, 'You Won\'t be a Tool, but a Person Worthy of that Name', '2018-02-01 00:00:00', 4, 0, '', NULL, '0'),
(22, 2, 'You Write Letters That Bring People Together?', '2018-02-08 00:00:00', 5, 0, '', NULL, '0'),
(23, 2, 'Somewhere, Under a Starry Sky', '2018-02-15 00:00:00', 6, 0, '', NULL, '0'),
(24, 2, '「　　　　　」', '2018-02-22 00:00:00', 7, 0, '', NULL, '0'),
(25, 2, '「　　　　　」', '2018-03-01 00:00:00', 8, 0, '', NULL, '0'),
(26, 2, 'Violet Evergarden', '2018-03-08 00:00:00', 9, 0, '', NULL, '0'),
(27, 2, 'A Loved One Will Always Watch Over You', '2018-03-15 00:00:00', 10, 0, '', NULL, '0'),
(28, 2, 'I Don\'t Want Anybody Else to Die', '2018-03-22 00:00:00', 11, 0, '', NULL, '0'),
(29, 2, '「　　　　　」', '2018-03-29 00:00:00', 12, 0, '', NULL, '0'),
(30, 2, 'Auto Memory Doll and \"I Love You\"', '2018-04-05 00:00:00', 13, 0, '', NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `followanime`
--

CREATE TABLE `followanime` (
  `AnimeID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `FollowStatus` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `followanime`
--

INSERT INTO `followanime` (`AnimeID`, `UserID`, `FollowStatus`) VALUES
(1, 1, b'1'),
(2, 1, b'1'),
(2, 3, b'1'),
(3, 2, b'1'),
(4, 1, b'1'),
(4, 3, b'1'),
(4, 4, b'1');

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
  `NewsThumbnail` longtext NOT NULL,
  `NewsImage` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`NewsID`, `TagsID`, `NewsTitle`, `PublishDate`, `Writer`, `Headline`, `NewsContent`, `NewsLink`, `NewsThumbnail`, `NewsImage`) VALUES
(3, 1, 'Adaptasi Anime ‘ISLAND’ Ungkap Staf Produksinya', '2018-05-29', 'Kate Springer', 'VN in awalnya rilis pada April 2016 untuk PC dan rilis pada PlayStation Vita di 23 Februari\r\n					2017. Terdapat juga adaptasi manga karya Naoya Yao yang rilis pada April 2016.\r\n					<br><br>\r\n					Island menceritakan tentang pulau bernama Urashima. Sebuah insiden yang menimpa tiga keluarga besar pulau tersebut dari lima tahun yang lalu menyebabkan pulau tersebut terisolasi. Pulau tersebut terisolasi akibat penyakit lokal bernama Baimonbyou, tiga gadis dari pulau tersebut merupakan kunci untuk menyelamatkan pulau itu, namun tradisi membuat mereka tidak dapat bertindak. Suatu hari sebuah pria terdampar di pulau tersebut dan mengubah segalanya.', 'Situs resmi dari adaptasi anime “ISLAND” telah mengungkap staf produksinya. Adaptasi VN ini direncanakan tayang pada tahun 2018 ini.\r\n					<br><br>\r\n					Staf produksinya adalah:\r\n					<br><br>\r\n					<li>Sutradara: Keiichiro Kawaguchi</li>\r\n					<li>Komposisi Seri: Naruhisa Arakawa</li>\r\n					<li>Desainer Karakter: Kousuke Kawamura</li>\r\n					<li>Musik: Akiyuki Tateyama</li>\r\n					<li>Lagu Pembuka: Yukari Tamura</li>\r\n					<li>Lagu Penutup: Asaka</li>\r\n					<li>Studio Produksi: feel.</li>\r\n					<br>\r\n					Seiyuu yang akan hadir beserta peran mereka adalah:\r\n					<br><br>\r\n					<li>Yukari Tamura sebagai <b>Rinne Ohara</b></li>\r\n					<li>Kana Asumi sebagai <b>Karen Kurutsu</b></li>\r\n					<li>Hibiku Yamamura <b>sebagai Sora Garandou</b></li>\r\n					<br>\r\n					VN in awalnya rilis pada April 2016 untuk PC dan rilis pada PlayStation Vita di 23 Februari\r\n					2017. Terdapat juga adaptasi manga karya Naoya Yao yang rilis pada April 2016.\r\n					<br><br>\r\n					Island menceritakan tentang pulau bernama Urashima. Sebuah insiden yang menimpa tiga keluarga besar pulau tersebut dari lima tahun yang lalu menyebabkan pulau tersebut terisolasi. Pulau tersebut terisolasi akibat penyakit lokal bernama Baimonbyou, tiga gadis dari pulau tersebut merupakan kunci untuk menyelamatkan pulau itu, namun tradisi membuat mereka tidak dapat bertindak. Suatu hari sebuah pria terdampar di pulau tersebut dan mengubah segalanya.\r\n					<br><br>\r\n					Gamenya diproduksi oleh Ryuichiro Yamakawa, Yousai Kuuchuu adalah ilustrator seri ini, sementara G.O. mengerjakan skenarionya.', NULL, 'assets/image/island.jpg', 'background: url(assets/image/news-img.jpg) 50% 20%;'),
(4, 1, '‘Grand Blue’ Tampilkan Teaser Anime dan Ungkap Staf Produksi', '2018-03-01', 'Kaptain', 'Seri ini menceritakan tentang Kitahara Iori yang pindah ke Izu untuk kuliah, di sana dia menetap di toko alat selam bernama “Grand Blue” yang dimiliki oleh kerabatnya. Setelah berbagai insiden yang melibatkan kakak kelas dan sepupunya yang bergabung dengan circle menyelam tingkat universitas, dia memutuskan untuk ikut mencoba menyelam juga.', '<p>Situs resmi dari adaptasi&nbsp;<em>anime&nbsp;</em><strong>“Grand Blue”&nbsp;</strong>telah menampilkan sebuah&nbsp;<em>teaser&nbsp;</em>serta visual&nbsp;<em>anime-</em>nya. Bersamaan dengan ini staf produksinya juga telah diungkap.</p>\r\n<p>Staf produksi&nbsp;<em>anime-</em>nya adalah:</p>\r\n<ul>\r\n<li>Sutradara, Skrip: Shinji Takamatsu (<em>Gintama, Danshi Koukousei no Nichijou, School Rumble</em>)</li>\r\n<li>Desainer Karakter: Hideoki Kusama</li>\r\n<li>Studio Produksi: <strong>Zero-G</strong> (<em>Battery, Tsugumomo, Dive!!</em>)</li>\r\n</ul>\r\n<p>Pilihan sutradara yang sempurna untuk seri ini, namun studionya sayang masih belum terlalu berpengalaman.</p>\r\n<p>Seri ini menceritakan tentang Kitahara Iori yang pindah ke Izu untuk kuliah, di sana dia menetap di toko alat selam bernama “Grand Blue” yang dimiliki oleh kerabatnya. Setelah berbagai insiden yang melibatkan kakak kelas dan sepupunya yang bergabung dengan&nbsp;<em>circle&nbsp;</em>menyelam tingkat universitas, dia memutuskan untuk ikut mencoba menyelam juga.</p>\r\n', NULL, 'assets/image/grand.jpg', 'background: url(assets/image/news4.jpg);\r\nbackground-size: cover;');

-- --------------------------------------------------------

--
-- Table structure for table `paymenthistory`
--

CREATE TABLE `paymenthistory` (
  `PaymentHistoryID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `BankID` int(11) DEFAULT NULL,
  `PaymentStatus` varchar(20) DEFAULT NULL COMMENT 'Basic / Premium',
  `AccountName` varchar(30) DEFAULT NULL,
  `AccountNumber` varchar(20) DEFAULT NULL,
  `PaymentPlan` varchar(20) DEFAULT NULL COMMENT 'Monthly / Annually',
  `CardExpDate` date DEFAULT NULL,
  `PaymentTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `paymenthistory`
--

INSERT INTO `paymenthistory` (`PaymentHistoryID`, `UserID`, `BankID`, `PaymentStatus`, `AccountName`, `AccountNumber`, `PaymentPlan`, `CardExpDate`, `PaymentTime`) VALUES
(8, 1, 1, 'Premium', 'Izzi Dzikri', '123123', 'Annually', NULL, '2018-06-05 06:19:37'),
(9, 1, 1, 'Premium', 'Izzi', '2342342', 'Monthly', NULL, '2018-06-05 11:13:46'),
(34, 1, 1, 'Basic', 'hyhy', '324123123123', 'Monthly', NULL, '2018-06-05 12:12:06'),
(35, 2, 1, 'Basic', 'CandyPanda', '3241324321', 'Monthly', NULL, '2018-06-05 12:15:50'),
(36, 1, 1, 'Premium', 'Hy', '124234', 'Monthly', NULL, '2018-06-05 14:56:18'),
(37, 18, NULL, 'Premium', 'Andree Chdnara', '4700523412345678', 'Annually', '2021-02-02', '2018-06-05 16:46:29');

-- --------------------------------------------------------

--
-- Table structure for table `pgratingdetails`
--

CREATE TABLE `pgratingdetails` (
  `RatingID` int(11) NOT NULL,
  `RatingDetails` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pgratingdetails`
--

INSERT INTO `pgratingdetails` (`RatingID`, `RatingDetails`) VALUES
(1, 'General'),
(2, 'Teens 13 or older'),
(3, 'Mature');

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
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(25) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `Email` varchar(25) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `SubStatus` varchar(10) NOT NULL DEFAULT 'FREE',
  `SubExpDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`UserID`, `Username`, `Password`, `Email`, `Gender`, `SubStatus`, `SubExpDate`) VALUES
(1, 'EZ', 'MTIzMTIz', 'ez@gmail.com', 'Male', 'Premium', '2018-07-05'),
(2, 'HY', 'MTIzMTIz', 'hy@gmail.com', 'Male', 'Basic', '2018-07-05'),
(3, 'Will', 'MTIzMTIz', 'will@gmail.com', 'Male', 'FREE', NULL),
(4, 'Andree', 'MTIzMTIz', 'andree@gmail.com', 'Male', 'FREE', NULL),
(13, 'qweqwe', 'cXdl', 'qweqwe@qwe.com', 'Male', 'FREE', NULL),
(14, 'hyhy', 'cXdlcXdl', 'hyhy@gmail.com', 'Male', 'FREE', NULL),
(15, 'hyhy2', 'MTIzMTIz', 'hyhy@gmail.com', 'Male', 'FREE', NULL),
(16, 'hyhy3', 'MTIzMTIz', 'hyhy@gmail.com', 'Male', 'FREE', NULL),
(17, 'qweqwe2', 'cXdlcXdl', 'qweqwe@qwe.com', 'Male', 'FREE', NULL),
(18, 'andreesc15', 'MTIzMTIz', 'andrees.chandra@gmail.com', 'Male', 'Premium', '2019-06-05');

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
(1, 4, 1, '2018-06-05 00:00:00');

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
  ADD KEY `SourceID` (`SourceID`),
  ADD KEY `RatingID` (`RatingID`);

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
-- Indexes for table `followanime`
--
ALTER TABLE `followanime`
  ADD PRIMARY KEY (`AnimeID`,`UserID`),
  ADD KEY `UserID` (`UserID`);

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
-- Indexes for table `pgratingdetails`
--
ALTER TABLE `pgratingdetails`
  ADD PRIMARY KEY (`RatingID`);

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
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`TagsID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserID`);

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
-- AUTO_INCREMENT for table `anime`
--
ALTER TABLE `anime`
  MODIFY `AnimeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `bankdetail`
--
ALTER TABLE `bankdetail`
  MODIFY `BankID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `durations`
--
ALTER TABLE `durations`
  MODIFY `DurationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `episodes`
--
ALTER TABLE `episodes`
  MODIFY `EpisodeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

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
  MODIFY `PaymentHistoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `pgratingdetails`
--
ALTER TABLE `pgratingdetails`
  MODIFY `RatingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `watchhistories`
--
ALTER TABLE `watchhistories`
  MODIFY `WatchHistoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  ADD CONSTRAINT `anime_ibfk_5` FOREIGN KEY (`SourceID`) REFERENCES `source` (`SourceID`),
  ADD CONSTRAINT `anime_ibfk_6` FOREIGN KEY (`RatingID`) REFERENCES `pgratingdetails` (`RatingID`);

--
-- Constraints for table `animeandgenres`
--
ALTER TABLE `animeandgenres`
  ADD CONSTRAINT `animeandgenres_ibfk_1` FOREIGN KEY (`AnimeID`) REFERENCES `anime` (`AnimeID`),
  ADD CONSTRAINT `animeandgenres_ibfk_2` FOREIGN KEY (`GenreID`) REFERENCES `genres` (`GenreID`);

--
-- Constraints for table `episodes`
--
ALTER TABLE `episodes`
  ADD CONSTRAINT `episodes_ibfk_1` FOREIGN KEY (`AnimeID`) REFERENCES `anime` (`AnimeID`);

--
-- Constraints for table `followanime`
--
ALTER TABLE `followanime`
  ADD CONSTRAINT `followanime_ibfk_1` FOREIGN KEY (`AnimeID`) REFERENCES `anime` (`AnimeID`),
  ADD CONSTRAINT `followanime_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`);

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
  ADD CONSTRAINT `paymenthistory_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`);

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
