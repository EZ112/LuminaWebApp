<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/index.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.1/jquery.twbsPagination.js"></script>
<body>
	<div class="page grid-container">
		<?php 
		  include APPPATH.'/views/templates/navbar.php';
		  include APPPATH.'/views/templates/widget.php';
		?>
		<div class="content-area"> 
			<div class="content grid-container">
				<div class="google_adds">
					<div class="section_title">
						Google Ads	
					</div>
				</div>
				<div class="latest_update grid-container">
					<div style="text-align: right;">
						<ul class="pagination">
            			</ul>
					</div>
					<div class="section_title">
						Latest Update
					</div>
					<div class="latest_update_wrapper grid-container">
						<!-- Latest Update Content -->
					</div>
				</div>
				<div class="top_airing">
					<div class="section_title">
						Top 5 Airing Anime
					</div>
						<div class="top_airing_wrapper grid-container">
							<!-- Top 5 Airing Anime Content -->
						</div>
				</div>
				<div class="latest_news">
					<div class="section_title">
						Latest News
					</div>
					<div class="latest_news_wrapper grid-container">
						<!-- Latest News Content -->
					</div>
				</div>
				<div class="promotion">
					<div class="promotion_wrapper grid-container">
						<div>
							<div class="promotion_text">We Have Cool Item in <br>OFFICIAL SHOP</div>
							<button onclick="">Check Out</button>
						</div>
						<div class="promotion_image" style="background-image: url(assets/image/promotion.png);">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="assets/js/index.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>