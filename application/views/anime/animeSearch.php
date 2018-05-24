<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/animesearch.css">
<body>
	<div class="page grid-container">
		<?php 
		  include APPPATH.'/views/templates/navbar.php';
		  include APPPATH.'/views/templates/widget.php';
		?>

		<div class="content grid-area">
			<div>About 1000 Results</div>
			<div class="pointAnime">
				<div class="animeContainer grid-container">
					<div class="thumbnail_container"><a href="#"><img src="assets/image/news-img.jpg"></a></div>
					<div class="info_container">
						<a href="animepage.html" id="title">Yuru Camp</a>
						<div id="latest">Latest Episode 10</div>
						<div id="subscriber">Subscriber 300K</div>
					</div>
					<div class="button_container"><span class="button">Subscribe</span></div>
				</div>

				<div class="animeContainer grid-container">
					<div class="thumbnail_container"><a href="#"><img src="assets/image/news-img.jpg"></a></div>
					<div class="info_container">
						<a href="animepage.html" id="title">Yuru Camp 2</a>
						<div id="latest">Latest Episode 10</div>
						<div id="subscriber">Subscriber 300K</div>
					</div>
					<div class="button_container"><span class="button">Subscribe</span></div>
				</div>

			</div>
			<div class="pointEpisode">
				Most Viewed Episode

				<div class="episodeContainer grid-container">
					<div class="thumbnail_container"><a href="#"><img src="assets/image/news-img.jpg"></a></div>
					<div class="info_container">
						<a href="streaming.html" id="episode">Episode 1</a>
						<span id="airDate">Aired 04 Jan 2018</span>
						<div id="title">Mount Fuji and Curry Noodles</div>
						<div id="anime">Yuru Camp</div>
						<div id="views">2,854,176 views</div>
					</div>
				</div>

				<div class="episodeContainer grid-container">
					<div class="thumbnail_container"><a href="#"><img src="assets/image/news-img.jpg"></a></div>
					<div class="info_container">
						<a href="streaming.html" id="episode">Episode 2</a>
						<span id="airDate">Aired 04 Jan 2018</span>
						<div id="title">Welcome to the Outdoor Activities Club</div>
						<div id="anime">Yuru Camp</div>
						<div id="views">2,854,176 views</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<?php include APPPATH.'/views/templates/footer.php'?>