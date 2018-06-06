<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/faq.css">
<body>
	<div class="page grid-container">
		<?php 
		  include APPPATH.'/views/templates/navbar.php';
		?>

		<!--FAQ Content-->
		<div class="head_title">
			<div class="title">FAQ </div>
		</div>
		<div class="faq_container">
			<div class="faq">
				<span class="sign" onclick="open_faq(this)">+</span>
				<div class="question subtitle">What is Lumina ?</div>
				<div id="answer">
					Lumina is a web based subscription based streaming site that is specialized for Japanese Anime in Indonesia. We provide official releases with Indonesian subtitles in the country, which makes us the first to do that. 
				</div><hr>
			</div>
			<div class="faq">
				<span class="sign" onclick="open_faq(this)">+</span>
				<div class="question subtitle">How do I subscribe ?</div>
				<div id="answer">
					Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
				</div><hr>
			</div>
			<div class="faq">
				<span class="sign" onclick="open_faq(this)">+</span>
				<div class="question subtitle">How do I order ?</div>
				<div id="answer">
					Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
				</div><hr>
			</div>
			<div class="faq">
				<span class="sign" onclick="open_faq(this)">+</span>
				<div class="question subtitle">How do I register my credit card ?</div>
				<div id="answer">
					Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
				</div><hr>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="assets/js/faq.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>