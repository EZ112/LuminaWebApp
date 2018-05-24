<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/animeList.css">
<body>
		<div class="page grid-container">
			<?php 
			  include APPPATH.'/views/templates/navbar.php';
			  include APPPATH.'/views/templates/widget.php';
			?>
			
			<div class="mainContent">
				<div class="navigation grid-container">
					<div id="year">
						<i class="far fa-calendar-alt"></i>
						<span>Year</span>
						<span class="value" onclick="showMenu(this);">
							<div class="current">2018</div>
							<div class="dropdown">
								<div class="options" onclick="changeTo(this);">2018</div>
								<div class="options" onclick="changeTo(this);">2017</div>
								<div class="options" onclick="changeTo(this);">2016</div>
								<div class="options" onclick="changeTo(this);">2015</div>
								<div class="options" onclick="changeTo(this);">2014</div>
							</div>
						</span>
					</div>
					<div id="season">
						<i class="far fa-snowflake" id="seasonFA"></i>
						<span>Season</span>
						<span class="value" onclick="showMenu(this);">
							<div class="current">Winter</div>
							<div class="dropdown">
								<div class="options" onclick="changeTo(this);">Spring</div>
								<div class="options" onclick="changeTo(this);">Summer</div>
								<div class="options" onclick="changeTo(this);">Fall</div>
								<div class="options" onclick="changeTo(this);">Winter</div>
							</div>
						</span>
					</div>
					<div id="status">
						<i class="far fa-play-circle"></i>
						<span>Status</span>
						<span class="value" onclick="showMenu(this);">
							<div class="current">On Going</div>
							<div class="dropdown">
								<div class="options" onclick="changeTo(this);">On Going</div>
								<div class="options" onclick="changeTo(this);">Completed</div>
							</div>
						</span>
					</div>
					<div id="duration">
						<i class="far fa-clock"></i>
						<span>Duration</span>
						<span class="value" onclick="showMenu(this);">
							<div class="current">Short</div>
							<div class="dropdown">
								<div class="options" onclick="changeTo(this);">Short</div>
								<div class="options" onclick="changeTo(this);">24min Series</div>
								<div class="options" onclick="changeTo(this);">Movie</div>
							</div>
						</span>
					</div>
					<div id="sort">
						<i class="fas fa-sort"></i>
						<span>Sort</span>
						<span class="value" onclick="showMenu(this);">
							<div class="current">Title</div>
							<div class="dropdown">
								<div class="options" onclick="changeTo(this);">Subscriber</div>
								<div class="options" onclick="changeTo(this);">Title</div>
							</div>
						</span>
					</div>
				</div>
				<div class="animeList grid-container">
					<div>
						<div onclick="location.href='animepage.html'" class="animeImage" title="Yuru Camp" style="background-image: url(assets/image/yurucamp.jpg)"></div>
						<div class="animeDetail">
							<div class="detail"><div>Source</div><div>Manga</div></div>
							<div class="detail"><div>Total Episodes</div><div>12</div></div>
							<div class="detail"><div>Duration</div><div>24min / Episode</div></div>
							<div class="detail"><div>Subscriber</div><div>300K</div></div>
							<div class="detail"><div>Genres</div><div>Comedy, Slice of life</div></div>
						</div>
					</div>
					<div>
						<div onclick="" class="animeImage" title="Koi wa Ameagari no You ni" style="background-image: url(assets/image/koiwa.jpg)"></div>
						<div class="animeDetail">
							<div class="detail"><div>Source</div><div>Manga</div></div>
							<div class="detail"><div>Total Episodes</div><div>12</div></div>
							<div class="detail"><div>Duration</div><div>24min / Episode</div></div>
							<div class="detail"><div>Subscriber</div><div>300K</div></div>
							<div class="detail"><div>Genres</div><div>Comedy, Slice of life</div></div>
						</div>
					</div>
					<div>
						<div onclick="" class="animeImage" title="Violet Evergarden" style="background-image: url(assets/image/violet.jpg)"></div>
						<div class="animeDetail">
							<div class="detail"><div>Source</div><div>Manga</div></div>
							<div class="detail"><div>Total Episodes</div><div>12</div></div>
							<div class="detail"><div>Duration</div><div>24min / Episode</div></div>
							<div class="detail"><div>Subscriber</div><div>300K</div></div>
							<div class="detail"><div>Genres</div><div>Comedy</div></div>
						</div>
					</div>
					<div>
						<div onclick="" class="animeImage" title="Karakai Jouzu no Takagi-san" style="background-image: url(assets/image/karakai.jpg)"></div>
						<div class="animeDetail">
							<div class="detail"><div>Source</div><div>Manga</div></div>
							<div class="detail"><div>Total Episodes</div><div>12</div></div>
							<div class="detail"><div>Duration</div><div>24min / Episode</div></div>
							<div class="detail"><div>Subscriber</div><div>300K</div></div>
							<div class="detail"><div>Genres</div><div>Comedy</div></div>
						</div>
					</div>
				</div>
			</div>
		</div>
</body>
<script type="text/javascript" src="assets/js/animeList.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>