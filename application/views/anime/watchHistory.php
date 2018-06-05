<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/watchHistory.css">	
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
		</div>	
	</div>
</body>
<script type="text/javascript" src="assets/js/watchHistory.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>