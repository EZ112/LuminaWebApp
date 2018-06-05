<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/backend.css">
<body>
	<div class="page grid-container">
		<div class="navbar grid-container">
			<!--Navbar-->
			<div class="logo"><a href="index.html"></a></div>

			<div class="nav_backend">
				<div onclick="switchNav(this)">Master</div>
				<div onclick="switchNav(this)">Insert</div>
			</div>
		</div>

		<div class="head_title">
			<div class="title">Master</div>
		</div>
		<div class="content">
			<!--Master-->
			<div id="master">
				<select id="selectMaster" onchange="switchForm(this);">
					<option value="series">Series</option>
					<option value="studio">Studio</option>
					<option value="source">Source</option>
				</select>

				<!--Ganti action dari js-->
				<form action="#" id="formMaster" onsubmit="return submitForm(this);">
					<span id="label">Series</span>
					<input type="text" name="input" placeholder="Insert Text Here" autocomplete="off">
					<span id="submitForm" onclick="submitForm(this.parentElement);">Submit</span>
				</form>

				<!--Notification-->
				<div id="warning" class="notif"><span>Series</span> already exists</div>
				<div id="success" class="notif"><span>Series</span> successfully added</div>

				<!--Table-->
				<div id="table">
					<div id="tableHeading">Series</div>
					<div id="tableContent">
						<div id="empty">Table is empty</div>
						<div class="tableObject">
							<span class="title">Dummy</span>
							<i class="fas fa-times" onclick="deleteTableObject(this.parentElement);"></i>
						</div>
						<div class="tableObject">
							<span class="title">Dummy2</span>
							<i class="fas fa-times" onclick="deleteTableObject(this.parentElement);"></i>
						</div>
					</div>
				</div>
			</div>

			<!--Insert-->
			<div id="insert">
				<select id="selectInsert" onchange="switchForm(this);">
					<option value="anime">Anime</option>
					<option value="episode">Episode</option>
					<option value="news">News</option>
				</select>

				<!--Anime-->
				<form action="" class="formInsert anime">
					<div class="table">
						<!--Series-->
						<div class="row">
							<div class="cell label">Series</div>
							<div class="cell"><input type="text" name="series"></div>
						</div>
						<!--Anime Title-->
						<div class="row">
							<div class="cell label">Anime Title</div>
							<div class="cell"><input type="text" name="title"></div>
						</div>
						<!--Series ID-->
						<div class="row">
							<div class="cell label">Series ID</div>
							<div class="cell"><input type="text" name="seriesid" disabled value="YuruCamp001"></div>
						</div>
						<!--Total Episode-->
						<div class="row">
							<div class="cell label">Total Episode</div>
							<div class="cell"><input type="text" name="totalEpisode"></div>
						</div>
						<!--Duration-->
						<div class="row">
							<div class="cell label">Duration</div>
							<div class="cell">
								<select name="duration">
									<option value="short">Short</option>
									<option value="24min">24min</option>
									<option value="movie">Movie</option>
								</select>
							</div>
						</div>
						<!--Series-->
						<div class="row">
							<div class="cell label">Studio</div>
							<div class="cell">
								<select name="studio">
									<option value="d1">Dummy1</option>
									<option value="d2">Dummy2</option>
									<option value="d3">Dummy3</option>
								</select>
							</div>
						</div>
						<!--Source-->
						<div class="row">
							<div class="cell label">Source</div>
							<div class="cell">
								<select name="source">
									<option value="d1">Dummy1</option>
									<option value="d2">Dummy2</option>
									<option value="d3">Dummy3</option>
								</select>
							</div>
						</div>
						<!--Thumbnail-->
						<div class="row">
							<div class="cell label">Thumbnail</div>
							<div class="cell"><input type="file" name="thumbnail" accept="image/*"></div>
						</div>
						<div class="row">
							<div class="cell label"></div>
							<div class="cell warning">*Image size (600 x 300)px</div>
						</div>
						<!--Airing Date-->
						<div class="row">
							<div class="cell label">Airing Date</div>
							<div class="cell"><input type="date" name="airing"></div>
						</div>
					</div>
					<!--Genres-->
					<div class="label">Genre</div>
					<div id="genreContainer"></div>
					<input type="submit" value="Submit">
				</form>

				<!--Episode-->
				<form action="" class="formInsert episode">
					<div class="table">
						<div class="row">
							<div class="cell label">Anime Title</div>
							<div class="cell"><input type="text" name="animeTitle"></div>
						</div>
						<div class="row">
							<div class="cell label">Series ID</div>
							<div class="cell"><input type="text" name="seriesID" disabled value="YuruCamp001"></div>
						</div>
						<div class="row">
							<div class="cell label">Episode Title</div>
							<div class="cell"><input type="text" name="episodeTitle"></div>
						</div>
						<div class="row">
							<div class="cell label">Episode</div>
							<div class="cell"><span id="currEpisode">12</span>/<span id="totalEpisode">12</span></div>
						</div>
						<div class="row">
							<div class="cell label">Status</div>
							<div class="cell"><input id="status" type="text" name="status" disabled></div>
						</div>
						<div class="row">
							<div class="cell label">Video</div>
							<div class="cell"><input type="file" name="video" accept="video/*"></div>
						</div>
					</div>
					<input type="submit" value="Submit">
				</form>

				<form action="" class="formInsert news">
					a
				</form>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="assets/js/backend.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>