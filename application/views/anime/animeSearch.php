<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/animesearch.css">
<link rel="stylesheet" type="text/css" href="assets/css/loader.css">
<body>
	<div class="page grid-container">
		<?php 
		  include APPPATH.'/views/templates/navbar.php';
		  include APPPATH.'/views/templates/widget.php';
		?>

		<div class="content grid-area">
			<div class="google_ads">
				<div class="section_title">
					Google Ads	
				</div>
			</div>
			<div class="result"></div>
			<div class="pointAnime">
				<!-- Point Anime Content -->
			</div>
			<div class="pointEpisode">
				<div class="subheader"></div>
				<!-- Point Episode Content -->
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="assets/js/animesearch.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>