<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/news.css">	
<body>
	<div class="page grid-container">
		<?php 
		  include APPPATH.'/views/templates/navbar.php';
		  include APPPATH.'/views/templates/widget.php';
		?>

		<!--News Bar-->
		<div class="news_list grid-container">
			<div>
				<div class="title">Read</div>
				<a class="readNow">
					<!-- <div class="date">21 Mar 2018</div>
					<div class="list_content">
						Adaptasi Anime "ISLAND" Ungkap Staf Produksinya
					</div> -->
				</a>
			</div>
			<div class="latestNews">
				<div class="title">Latest News</div>
			</div>
		</div>

		<!--News Content-->
		<div class="news_content_wrapper">
			<div class="news_content">
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="assets/js/news.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>