<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/animeList.css">
<body>
		<div class="page grid-container">
			<?php 
			  include APPPATH.'/views/templates/navbar.php';
			  include APPPATH.'/views/templates/widget.php';
			?>

			<div class="content-area">
				<div class="content grid-container">
					<div class="google_ads">
						<div class="section_title">
							Google Ads	
						</div>
					</div>
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
							<!-- <i class="far fa-snowflake" id="seasonFA"></i> -->
							<span>Season</span>
							<span class="value" onclick="showMenu(this);">
								<div class="current">Spring</div>
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
								<div class="current">24 min Series</div>
								<div class="dropdown">
									<div class="options" onclick="changeTo(this);">Short</div>
									<div class="options" onclick="changeTo(this);">24 min Series</div>
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
						<!-- Anime List Content -->
					</div>
				</div>
			</div>
		</div>
</body>
<script type="text/javascript" src="assets/js/animeList.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>