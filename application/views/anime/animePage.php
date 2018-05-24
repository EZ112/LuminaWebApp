<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/anime.css">
<link rel="stylesheet" type="text/css" href="assets/css/video.css">
<link rel='stylesheet prefetch' href='https://vjs.zencdn.net/5-unsafe/video-js.css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/videojs-resolution-switcher/0.4.2/videojs-resolution-switcher.css" />
<body>
	<div class="page grid-container">
		<?php 
		  include APPPATH.'/views/templates/navbar.php';
		  include APPPATH.'/views/templates/widget.php';
		?>

		<div class="anime-content grid-container">
			<div id="curr_anime_image">
				<span id="curr_anime_title">
					Yuru Camp
				</span>
			</div>

			<div id="curr_anime_general" class="grid-container">
				<div id="a">
					<span id="rank">
						Ranked #415
					</span>
					<span id="user_rate">
						<span class="fa fa-star"></span>
						<span class="fa fa-star"></span>
						<span class="fa fa-star"></span>
						<span class="fa fa-star"></span>
						<span class="fa fa-star"></span>
					</span>
					<span id="review_number">185 reviews</span>
				</div>
				<div id="b">
					  <video id="pv" class="video-js vjs-default-skin"
					      preload="none" poster='https://i.imgur.com/oeODDMP.png'
					      data-setup='' controls>
					  </video>
				</div>
				<div id="c">
					<div class="detailContainer">
						<span>Title</span><span>Yuru Camp</span>
					</div>
					<div class="detailContainer">
						<span>Episode</span><span>12</span>
					</div>
					<div class="detailContainer">
						<span>Status</span><span>Ongoing</span>
					</div>
					<div class="detailContainer">
						<span>Duration</span><span>23min / episode</span>
					</div>
					<div class="detailContainer">
						<span>Studio</span><span>C-Station</span>
					</div>
					<div class="detailContainer">
						<span>Source</span><span>Manga</span>
					</div>
					<div class="detailContainer">
						<span>Rating</span><span>Teens 13 or older</span>
					</div>
					<div class="detailContainer">
						<span>Genres</span><span>Comedy, Slice of life</span>
					</div>
				</div>
				<div id="d">
					Related Anime<br>
					<div class="relatedContainer"><span>Sequel</span><a href="#">Yuru Camp Season 2</a></div>
					<div class="relatedContainer"><span>Prequel</span><a href="#">Yuru Camp 0</a></div>
					<div class="relatedContainer"><span>Other</span><a href="#">Yuru Camp OVA</a><a href="#">Yuru Camp Side Story</a></div>
				</div>
				<div id="e"><span class="button">Subscribe <span id="price">300K</span></span></div>
			</div>

			<div id="curr_anime_synopsis">
				<span class="title">Synopsis</span>
				<div class="synopsis">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<br><br>
				Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
			</div>

			<div id="curr_episode_review">
				<div>
					<div class="tab tab_active" onclick="change_tab(0);">
						Episodes
					</div><div class="tab tab_inactive" onclick="change_tab(1);">
						Reviews
					</div><div class="tab tab_inactive" id="dummy">
						 a
					</div>
				</div>
				<div class="sort episode">
					<div>
						<span class="fa fa-caret-up"></span>
						<span class="fa fa-caret-down"></span>
						<span class="">Sort By</span>
					</div>
					<div class="sort_filter">
						<span class="active">Newest</span>
						<span class="inactive">Oldest</span>
					</div>
				</div>
				<div class="episode content">
					<div onclick="location.href='streaming.html'" class="episode_container">
						<div class="left">
							<div class="thumbnail_container" style="background-image: url(assets/image/thumb2.jpg)">
								 
							</div>
						</div><div class="right">
							<a href="streaming.html" class="episode_num">Episode 2</a> 
							<span class="date">Aired 25 Jan 2018</span>
							<div class="title">Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum</div>
							<div class="views">9,000,000 views</div>
						</div>
					</div>
					<div class="episode_container">
						<div class="left">
							<div class="thumbnail_container" style="background-image: url(assets/image/thumb1.png)">
								 
							</div>
						</div><div class="right">
							<a href="streaming.html" class="episode_num">Episode 1</a> 
							<span class="date">Aired 25 Jan 2018</span>
							<div class="title">Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum</div>
							<div class="views">9,000,000 views</div>
						</div>
					</div>
				</div>

				<div class="review content">
					<div class="rating_section">
						<span class="title">Average Rating</span>
						<div class="average_rating">
							<div class="left">
								<div class="bar_container">
									<div class="rating_num">5</div>
									<div class="bar">
										<div class="fill"></div>
									</div>
									<span class="rated">(1)</span>
								</div>
								<div class="bar_container">
									<div class="rating_num">4</div>
									<div class="bar">
										<div class="fill"></div>
									</div>
									<span class="rated">(2)</span>
								</div>
								<div class="bar_container">
									<div class="rating_num">3</div>
									<div class="bar">
										<div class="fill"></div>
									</div>
									<span class="rated">(3)</span>
								</div>
								<div class="bar_container">
									<div class="rating_num">2</div>
									<div class="bar">
										<div class="fill"></div>
									</div>
									<span class="rated">(4)</span>
								</div>
								<div class="bar_container">
									<div class="rating_num">1</div>
									<div class="bar">
										<div class="fill"></div>
									</div>
									<span class="rated">(5)</span>
								</div>
							</div>
							<div class="right">
								<span class="button">Write Review</span>
							</div>
						</div>
					</div>
					<div class="comment_section">
						<span class="title">User Rating</span>

						<div class="comment_container">
							<div class="comment_description">
								<div>16/16 people found this review helpful:</div>
								<div class="mid">
									<span class="fa fa-star rating_check"></span>
									<span class="fa fa-star rating_check"></span>
									<span class="fa fa-star rating_check"></span>
									<span class="fa fa-star rating_check"></span>
									<span class="fa fa-star rating_check"></span>
									<span class="comment_title">Lorem Ipsum</span>
								</div>
								<div>By <a href="#">hyhy</a> on 10 Apr 2018</div>
							</div>
							<div class="comment">
								Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
							</div>
							<div class="comment_rate">
								<div onclick="" class="read_more">Read More</div>
								<div>
									<span>Was this review helpful: </span>
									<span onclick="" class="cr">Yes</span>
									<span> / </span>
									<span onclick="" class="cr">No report as spam</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="assets/js/animepage.js"></script>
<script src='https://vjs.zencdn.net/5-unsafe/video.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/videojs-resolution-switcher/0.4.2/videojs-resolution-switcher.js"></script>
<script type="text/javascript" src="assets/js/video.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>