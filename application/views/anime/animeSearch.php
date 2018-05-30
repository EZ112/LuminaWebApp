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
			<div class="result"></div>
			<div class="pointAnime">
				<!-- Point Anime Content -->
			</div>
			<div class="pointEpisode">
				Most Viewed Episode
				<!-- Point Episode Content -->
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="assets/js/animesearch.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>