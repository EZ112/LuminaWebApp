<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/streaming.css">
<!-- <script src="https://fast.wistia.com/embed/medias/zqo0g6k2c5.jsonp" async></script> -->
<script src="https://fast.wistia.com/assets/external/E-v1.js" async></script>
<body>
	<div class="page grid-container">
		<?php 
		  include APPPATH.'/views/templates/navbar.php';
		  include APPPATH.'/views/templates/widget.php';
		?>

		<div class="content grid-container">
			<div class="video">
				<div class="video_container">
					<div class="wistia_responsive_padding" style="padding:56.25% 0 0 0;position:relative;">
						<div class="wistia_responsive_wrapper" style="height:100%;left:0;position:absolute;top:0;width:100%;">
							<div class="wistia_embed videoFoam=true" style="height:100%;position:relative;width:100%">
								<div class="wistia_swatch" style="height:100%;left:0;opacity:0;overflow:hidden;position:absolute;top:0;transition:opacity 200ms;width:100%;">
									<img src="" style="filter:blur(5px);height:100%;object-fit:contain;width:100%;" alt="" onload="this.parentNode.style.opacity=1;" />
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>

			<div class="comment">

				<div id="disqus_thread"></div>
				<script>

				/**
				*  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
				*  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/
				
				var disqus_config = function () {
				this.page.url = window.location.href;  // Replace PAGE_URL with your page's canonical URL variable
				this.page.identifier = "ani"+getParameterByName("anime")+"eps"+getParameterByName("episode"); // Replace PAGE_IDENTIFIER with your page's unique identifier variable
				};
				
				(function() { // DON'T EDIT BELOW THIS LINE
				var d = document, s = d.createElement('script');
				s.src = 'https://luminadotco.disqus.com/embed.js';
				s.setAttribute('data-timestamp', +new Date());
				(d.head || d.body).appendChild(s);
				})();
				</script>
				<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
			</div>

			<div class="other">
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="assets/js/streaming.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>