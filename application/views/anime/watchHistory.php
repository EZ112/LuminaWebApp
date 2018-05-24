<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/watchLater.css">	
<body>
	<div class="page grid-container">
		<?php 
		  include APPPATH.'/views/templates/navbar.php';
		  include APPPATH.'/views/templates/widget.php';
		?>
		
		<div class="content">
			<div class="section_title">History</div>
			<div class="redify" id="removeAll" onclick="removeAll(this);">
				<i class="fas fa-times"></i>
				<span class="clearAll">Clear All History</span>
			</div>

			<div class="videoContainer grid-container">
				<a href="#" class="videoThumbnail"></a>
				<div class="dummyCenter">
					<div class="videoDetail">
						<a href="#" class="videoEpisode">Episode 1</a>
						<span class="videoAirDate">Aired 15 May 2018</span>
						<div class="videoTitle">Mount Fuji and Curry Noodles</div>
						<div class="videoAnime">Yuru Camp</div>
						<div class="videoViews">123,456,789 views</div>
					</div>
				</div>
				<div class="redify" onclick="removeElement(this.parentElement);">
					<i class="fas fa-times"></i>
				</div>
			</div>

			<div class="videoContainer grid-container">
				<a href="#" class="videoThumbnail"></a>
				<div class="dummyCenter">
					<div class="videoDetail">
						<a href="#" class="videoEpisode">Episode 2</a>
						<span class="videoAirDate">Aired 15 May 2018</span>
						<div class="videoTitle">Mount Fuji and Curry Noodles</div>
						<div class="videoAnime">Yuru Camp</div>
						<div class="videoViews">123,456,789 views</div>
					</div>
				</div>
				<div class="redify" onclick="removeElement(this.parentElement);">
					<i class="fas fa-times"></i>
				</div>
			</div>

			<div class="videoContainer grid-container">
				<a href="#" class="videoThumbnail"></a>
				<div class="dummyCenter">
					<div class="videoDetail">
						<a href="#" class="videoEpisode">Episode 3</a>
						<span class="videoAirDate">Aired 15 May 2018</span>
						<div class="videoTitle">Mount Fuji and Curry Noodles</div>
						<div class="videoAnime">Yuru Camp</div>
						<div class="videoViews">123,456,789 views</div>
					</div>
				</div>
				<div class="redify" onclick="removeElement(this.parentElement);">
					<i class="fas fa-times"></i>
				</div>
			</div>

			<div class="videoContainer grid-container">
				<a href="#" class="videoThumbnail"></a>
				<div class="dummyCenter">
					<div class="videoDetail">
						<a href="#" class="videoEpisode">Episode 4</a>
						<span class="videoAirDate">Aired 15 May 2018</span>
						<div class="videoTitle">Mount Fuji and Curry Noodles</div>
						<div class="videoAnime">Yuru Camp</div>
						<div class="videoViews">123,456,789 views</div>
					</div>
				</div>
				<div class="redify" onclick="removeElement(this.parentElement);">
					<i class="fas fa-times"></i>
				</div>
			</div>
		</div>	
	</div>
</body>
<script type="text/javascript" src="assets/js/watchLater.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>