<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="assets/css/backendLogin.css">
<link rel="stylesheet" type="text/css" href="assets/css/fonts.css">
<body>
	<div class="formContainer">
		<span class="heading">Backend Login</span>
		<form action="" method="post" onsubmit="return checkLogin(this);">
			<input type="text" placeholder="Username" name="username" required>
			<input type="password" placeholder="Password" name="password" required>
			<input type="submit" value="Login">
		</form>
	</div>
</body>
<script type="text/javascript" src="assets/js/backendLogin.js"></script>