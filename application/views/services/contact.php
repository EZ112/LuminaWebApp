<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/contact.css">
<body>
	<div class="page grid-container">
		<?php 
		  include APPPATH.'/views/templates/navbar.php';
		?>

		<div class="head_title">
			<div class="title">Contact Us</div>
		</div>

		<div class="content">
			<div class="heading">Phone Support Hotlines</div>
			<div>(Monday to Friday, 9am to 6pm UTC+7)</div>
			<div>007 803 011 0451</div>
			<hr class="line">

			<div class="heading">Message Us</div>
			<div class="comment"><pink>*</pink> Required</div>

			<form class="grid-container form" method="post">
				<div>
					<pink>*</pink>Title<br>
					<input type="text" name="title" required>
				</div>
				<div>
					<pink>*</pink>Message<br>
					<textarea name="msg" required></textarea>
				</div>
				<div>
					<input type="submit" class="button" value="Submit">
				</div>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript" src="assets/js/script.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>