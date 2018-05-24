<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/streaming.css">
<link rel="stylesheet" type="text/css" href="assets/css/video.css">
<link rel='stylesheet prefetch' href='https://vjs.zencdn.net/5-unsafe/video-js.css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/videojs-resolution-switcher/0.4.2/videojs-resolution-switcher.css" />
<body>
	<div class="page grid-container">
		<?php 
		  include APPPATH.'/views/templates/navbar.php';
		  include APPPATH.'/views/templates/widget.php';
		?>

		<div class="content grid-container">
			<div class="video">
				<div class="video_container">
					<video id="pv" class="video-js vjs-default-skin"
					    preload="none" poster='https://i.imgur.com/oeODDMP.png'
					    data-setup='' controls>
					 </video>
				</div>
				<span id="episode">Episode 2</span>
				<span id="airDate">Aired 04 Jan 2018</span>
				<div id="title">Welcome to the Outdoor Activities Club</div>
				<div class="stats" name="curr">
					<span id="views">7,124,183 views</span><span id="likes" onclick="activate(this);">
						<i class="fas fa-thumbs-up"></i>
						174K
					</span><span id="dislikes" onclick="activate(this);">
						<i class="fas fa-thumbs-down"></i>
						4K
					</span><span id="share">
						<i class="fas fa-share-alt"></i>
						Share
					</span>
				</div>
			</div>

			<div class="comment">
				<span class="section_title">Comment</span>
				<div class="section_content">
					<div class="container">
						<form id="write">
							<i class="fas fa-user-circle"></i>
							<input type="text" name="comment" placeholder="Write a comment" autocomplete="off">
						</form>
					</div>
					<div class="container">
						<div class="read">
							<i class="fas fa-user-circle"></i>
							<div class="existingComment">
								<span id="username">Username</span>
								<span id="date">1 month ago</span>
								<div id="commentContent">
									Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
								</div>
								<span id="reply" onclick="replyComment(this);">Reply</span>
								<span id="likes" onclick="activate(this);">
									<i class="fas fa-thumbs-up"></i>
									174
								</span><span id="dislikes" onclick="activate(this);">
									<i class="fas fa-thumbs-down"></i>
									4
								</span><br>
								<form id="replyComment">
									<textarea rows="1" name="comment" placeholder="Write a comment" onkeydown="checkHeight(this);"></textarea>
								</form>
								<span class="showReply" onclick="showReply(this);">Hide Replies -</span>
								<div class="replyContainer">
									<i class="fas fa-user-circle"></i>
									<div id="replyContent">
										<span id="rUsername">Username</span>
										<span id="rDate">1 month ago</span>
										<div id="rContent">
											Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
										</div>
									</div>
								</div>
								<div class="replyContainer">
									<i class="fas fa-user-circle"></i>
									<div id="replyContent">
										<span id="rUsername">Username</span>
										<span id="rDate">1 month ago</span>
										<div id="rContent">
											Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="read">
							<i class="fas fa-user-circle"></i>
							<div class="existingComment">
								<span id="username">Username</span>
								<span id="date">1 month ago</span>
								<div id="commentContent">
									Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
								</div>
								<span id="reply" onclick="replyComment(this);">Reply</span>
								<span id="likes" onclick="activate(this);">
									<i class="fas fa-thumbs-up"></i>
									174
								</span><span id="dislikes" onclick="activate(this);">
									<i class="fas fa-thumbs-down"></i>
									4
								</span><br>
								<form id="replyComment">
									<textarea rows="1" name="comment" placeholder="Write a comment" onkeydown="checkHeight(this);"></textarea>
								</form>
								<span class="showReply">Hide Replies -</span>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="other">
				<div class="section">Next Episode</div>
				
				<div class="container one grid-container" id="next_episode">
					<a href="#" class="video_container" style="background-image: url(assets/image/thumb2.jpg)">

					</a>
					<div class="info">
						<a href="#" class="episode">Episode 3</a>
						<div class="title">Mount Fuji and Relaxed Hot Pot Camp</div>
					</div>
				</div>
				<div class="section">Prev Episode</div>
				
				<div class="container one grid-container" id="prev_episode">
					<a href="#" class="video_container" style="background-image: url(assets/image/thumb1.png)">
						
					</a>
					<div class="info">
						<a href="#" class="episode">Episode 1</a>
						<div class="title">Mount Fuji and Curry Noodles</div>
					</div>
				</div>

				<div class="section" id="recommend">Recomended Anime</div>

				<div class="container two grid-container">
					<a href="#" class="video_container" style="background-image: url(assets/image/vidcon4.jpg)">
						
					</a>
					<div class="info">
						<a href="#" class="title">Yuru Camp Season 2</a>
						<div class="episode">12 Episodes</div>
						<div class="views">1 Views</div>
						<span class="button">Subscribe</span>
					</div>
				</div>

				<div class="container two grid-container">
					<a href="#" class="video_container" style="background-image: url(assets/image/vidcon3.jpg)">
						
					</a>
					<div class="info">
						<a href="#" class="title">Gabriel Dropout</a>
						<div class="episode">10 Episodes</div>
						<div class="views">15M Views</div>
						<span class="button">Subscribe</span>
					</div>
				</div>

				<div class="container two grid-container">
					<a href="#" class="video_container" style="background-image: url(assets/image/vidcon2.jpg)">
						
					</a>
					<div class="info">
						<a href="#" class="title">Karakai Jouzu no Takagi-san</a>
						<div class="episode">10 Episodes</div>
						<div class="views">7,123,183 Views</div>
						<span class="button">Subscribe</span>
					</div>
				</div>

				<div class="container two grid-container">
					<a href="#" class="video_container" style="background-image: url(assets/image/vidcon1.png)">
						
					</a>
					<div class="info">
						<a href="#" class="title">Yuru Camp Season 2</a>
						<div class="episode">12 Episodes</div>
						<div class="views">7,123,183 Views</div>
						<span class="button">Subscribe</span>
					</div>
				</div>

				<div class="container two grid-container">
					<a href="#" class="video_container" style="background-image: url(assets/image/vidcon1.png)">
						
					</a>
					<div class="info">
						<a href="#" class="title">Yuru Camp Season 2</a>
						<div class="episode">12 Episodes</div>
						<div class="views">7,123,183 Views</div>
						<span class="button">Subscribe</span>
					</div>
				</div>

				<div class="container two grid-container">
					<a href="#" class="video_container">
						
					</a>
					<div class="info">
						<a href="#" class="title">Yuru Camp Season 2</a>
						<div class="episode">12 Episodes</div>
						<div class="views">7,123,183 Views</div>
						<span class="button">Subscribe</span>
					</div>
				</div>

				<div class="more" onclick="showMore(this);">
					<i class="fas fa-chevron-down"></i>
					<span id="text">Show More</span>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="assets/js/streaming.js"></script>
<script src='https://vjs.zencdn.net/5-unsafe/video.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/videojs-resolution-switcher/0.4.2/videojs-resolution-switcher.js"></script>
<script type="text/javascript" src="assets/js/video.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>