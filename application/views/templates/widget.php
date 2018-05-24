<div class="widget-area">
	<!--Widget-->
	<div class="widget grid-container">
		<form id="widget_search" action="anime/animeSearch" method="post">
			<span onclick="search_anime(this);" class="fa fa-search"></span>
			<input name="search" placeholder="Search">
			<input type="submit">
		</form>
		<div>
			<span onclick="open_navigation('filter');" id="widget_filter">
				<i class="fas fa-sliders-h"></i>
				Filter
			</span>
		</div>
		<div id="widget_notification">
			<i onclick="open_navigation('notification_wrapper');" class="fas fa-bell"></i>
			<i id="isNotif" class="fas fa-circle"></i>

			<div id="notification_wrapper">
				<a href="#" class="notification">
					Notif 1
				</a>
				<a href="#" class="notification">
					Notif 2
				</a>
				<a href="#" class="notification">
					Notif 3
				</a>
			</div>
		</div>
		<div id="widget_login">
			<span id="notLogged" onclick="open_navigation('manageAccount');">Login</span>
			<span id="Logged">
				<!--Isi dengan image-->
			</span>
		</div>
	</div>
</div>

<div id="filter" onclick="submit_filter()">
	<form id="filter_content_wrapper" onclick="cancel_propagation()">
		<span class="close_button" onclick="submit_filter()"> &times; </span>
		<div id="filter_title">Filter</div>
		<div class="filter_content grid-container">
			<div>
				<div id="filter_subtitle">
					Type
				</div>
				<div id="filter_type">
					<div id="active" onclick="change_filter(0);">Anime</div><div onclick="change_filter(1);">News</div>
				</div>
				<div class="filter_anime" id="filter_duration">
					<div id="filter_subtitle">
						Duration
					</div>
					<div id="label_container">
						<!--Duration disini semua liat js-->
					</div>
				</div>
			</div>
			<div class="filter_news">
				<!--Empty Grid-->
			</div>
			<div class="filter_anime" id="filter_genre">
				<div id="filter_subtitle">
					Genre
				</div>
				<div class="grid-container" style="grid-template-columns: 1fr 1fr 1fr;">
					<div class="label_container">
						<!--Baca JS-->
					</div>
					<div class="label_container">
						<!--Baca JS-->
					</div>
					<div class="label_container">
						<!--Baca JS-->
					</div>
				</div>
			</div>
			<div class="filter_news" style="grid-column: 1/3;" id="filter_tag">
				<div id="filter_subtitle">
					Tags
				</div>
				<div class="grid-container" style="grid-template-columns: 1fr 1fr 1fr;">
					<div class="label_container">
						<!--Baca JS-->
					</div>
					<div class="label_container">
						<!--Baca JS-->
					</div>
					<div class="label_container">
						<!--Baca JS-->
					</div>
				</div>
			</div>
			<div class="filter_anime" style="grid-column: 1/3;" id="filter_subgenre">
				<div id="filter_subtitle">
					Sub Genre
				</div>
				<div class="grid-container" style="grid-template-columns: 1fr 1fr 1fr 1fr 1fr;">
					<div class="label_container">
						<!--Baca JS-->
					</div>
					<div class="label_container">
						<!--Baca JS-->
					</div>
					<div class="label_container">
						<!--Baca JS-->
					</div>
					<div class="label_container">
						<!--Baca JS-->
					</div>
					<div class="label_container">
						<!--Baca JS-->
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<div id="manageAccount" onclick="open_navigation('manageAccount')">
	<div id="container" class="grid-container" onclick="cancel_propagation();">
		<div>
			<span class="close_button" onclick="close_popup(this)"> × </span>	
		</div>
		<div class="title">Manage Account</div>
		<div class="register">
			<div class="subtitle">Register</div>
			<div class="small_comment">Join Lumina to stream your favourite anime</div>
			<form class="form grid-container" method="post">
				<div>
					Username<br>
					<input type="text" name="rname">
				</div>
				<div>
					Password<br>
					<input type="text" name="rpass">
				</div>
				<div>
					Email<br>
					<input type="text" name="remail">
				</div>
				<div>
					Comfirm Password<br>
					<input type="text" name="rcompass">
				</div>
				<div>
					Gender<br>
					<label class="custom_input_container">
						Male
						<input type="radio" name="gender" value="m">
						<span class="custom_radio"></span>
					</label>
					<label class="custom_input_container">
						Female
						<input type="radio" name="gender" value="f">
						<span class="custom_radio"></span>
					</label>
				</div>
				<div>
					<div class="terms">By clicking "Register", you agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>.</div>
					<div>
						<input type="submit" class="button" value="Register">
					</div>
				</div>
			</form>
		</div>
		<div class="login">
			<div class="subtitle">Login</div>
			<div class="small_comment">Already have an account? Log in below</div>
			<form class="form grid-container" method="post">
				<div>
					Email<br>
					<input type="text" name="lemail">
				</div>
				<div>
					Password<br>
					<input type="text" name="lpass">
				</div>
				<div>
					<input type="submit" class="button" value="Login">
				</div>
			</form>
		</div>
	</div>
</div>