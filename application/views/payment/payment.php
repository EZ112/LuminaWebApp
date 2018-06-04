<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/payment.css">
<body>
	<div class="page grid-container">
		<?php 
		  include APPPATH.'/views/templates/navbar.php';
		  include APPPATH.'/views/templates/widget.php';
		?>

		<div class="content">
			<form id="formClass">
				<div class="row grid-container">
					<div class="question">Which one do you <br> like to choose?</div>
					<label class="custom_input_container basic"><div class="label">Basic</div><input type="radio" name="paymentType" value="Basic" checked="true" onclick="changePaymentPlan('basic');"> <span class="custom_radio"></span></label>
					<label class="custom_input_container premium"><div class="label">Premium</div><input type="radio" name="paymentType" value="Premium" onclick="changePaymentPlan('premium');"> <span class="custom_radio"></span></label>
				</div>
				<div class="row grid-container">
					<div class="text">SD and HD Quality (480p and 720p)</div>
					<div>
						<i class="fas fa-check"></i>
					</div>
					<div><i class="fas fa-check"></i></div>
				</div>
				<div class="row grid-container">
					<div class="text">Full HD Quality (1080p)</div>
					<div></div>
					<div><i class="fas fa-check"></i></div>
				</div>
				<div class="row grid-container">
					<div class="text">Ad-Free</div>
					<div></div>
					<div><i class="fas fa-check"></i></div>
				</div>
				<div class="row grid-container">
					<div class="question">How would you <br> like to pay?</div>
					<label class="custom_input_container basic"><div class="label">Rp 50k Monthly</div><input type="radio" name="paymentDuration" value="b1" checked="true"> <span class="custom_radio"></span></label>
					<label class="custom_input_container premium"><div class="label">Rp 550k Annually</div><input type="radio" name="paymentDuration" value="b2"> <span class="custom_radio"></span></label>
				</div>
				<div class="row grid-container">
					<div class="warning">*tax included</div>
					<div></div>
					<div></div>
				</div>
				<div class="row grid-container">
					<div class="question">Choose your <br> payment method</div>
					<label class="custom_input_container basic"><div class="label">Transfer Bank</div><input type="radio" name="paymentMethod" value="TransferBank" checked="true" onclick="changePaymentPlan('premium');"> <span class="custom_radio"></span></label>
					<label class="custom_input_container premium"><div class="label">Credit <br> Card</div><input type="radio" name="paymentMethod" value="CreditCard" onclick="changePaymentPlan('premium');"> <span class="custom_radio"></span></label>
					<div class="transferBank">
						<div>D</div>
						<div>jkjhkhjv</div>
					</div>
					<div class="creditCard">
						<div>qwewq</div>
						<div>asdas</div>
					</div>
				</div>
				<div class="row grid-container">
					<div></div>
					<div></div>
					<!-- <div><span class="button" onclick="document.getElementById('formClass').submit()">Proceed</span></div> -->
					<div><span class="button" onclick="proceed(this);">Proceed</span></div>
				</div>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript" src="assets/js/payment.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>