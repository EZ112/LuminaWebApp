<?php include APPPATH.'/views/templates/header.php';?>
<link rel="stylesheet" type="text/css" href="assets/css/index.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.1/jquery.twbsPagination.js"></script>
<body>
	<div class="page grid-container">
		<?php 
		  include APPPATH.'/views/templates/navbar.php';
		  include APPPATH.'/views/templates/widget.php';
		?>
		<div class="content-area"> 
			<div class="content grid-container">
				<div class="latest_update grid-container">
					<div style="text-align: right;">
						<ul class="pagination">
            			</ul>
					</div>
					<div class="section_title">
						Latest Update
					</div>
					<div class="latest_update_wrapper grid-container">
						<!-- LatestUpdate -->
					</div>
				</div>
				<div class="top_airing">
					<div class="section_title">
						Top 5 Airing Anime
					</div>
					<div class="top_airing_wrapper grid-container">
						<div class="animeThumb" onclick="location.href='animepage.html'" title="Yuru Camp" style="background-image: url(assets/image/yurucamp.jpg)">
							<span class="numbering">1</span>
						</div>
						<div class="animeThumb" onclick="" title="Koi wa Ameagari no You ni" style="background-image: url(assets/image/koiwa.jpg)">
							<span class="numbering">2</span>
						</div>
						<div class="animeThumb" onclick="" title="Violet Evergarden" style="background-image: url(assets/image/violet.jpg)">
							<span class="numbering">3</span>
						</div>
						<div class="animeThumb" onclick="" title="Overlord" style="background-image: url(assets/image/overlord.png)">
							<span class="numbering">4</span>
						</div>
						<div class="animeThumb" onclick="" title="Karakai Jouzu no Takagi-san" style="background-image: url(assets/image/karakai.jpg)">
							<span class="numbering">5</span>
						</div>
						<button onclick="">Subscribe</button>
						<button onclick="">Subscribe</button>
						<button onclick="">Subscribe</button>
						<button onclick="">Subscribe</button>
						<button onclick="">Subscribe</button>
					</div>
				</div>
				<div class="latest_news">
					<div class="section_title">
						Latest News
					</div>
					<div class="latest_news_wrapper grid-container">
						<span onclick="location.href = 'news.html'" style="background-image: url(assets/image/island.jpg)"></span>
						<div>
							<div onclick="location.href = 'news.html'" class="news_title">Adaptasi Anime ‘ISLAND’ Ungkap Staf Produksinya</div>
							<div class="news_content">
								VN in awalnya rilis pada April 2016 untuk PC dan rilis pada PlayStation Vita di 23 Februari 2017. 
								Terdapat juga adaptasi manga karya Naoya Yao yang rilis pada April 2016. <br>
								<br>
								Island menceritakan tentang pulau bernama Urashima. Sebuah insiden yang menimpa tiga keluarga besar pulau tersebut dari lima tahun yang lalu menyebabkan pulau tersebut terisolasi. Pulau tersebut terisolasi akibat penyakit lokal bernama Baimonbyou, tiga gadis dari pulau tersebut merupakan kunci untuk menyelamatkan pulau itu, namun tradisi membuat mereka tidak dapat bertindak.
							</div>
							<a href="#">Read More &gt;&gt;</a>
						</div>
					</div>
					<div class="latest_news_wrapper grid-container">
						<span onclick="" style="background-image: url(assets/image/grand.jpg)"></span>
						<div>
							<div onclick="" class="news_title">‘Grand Blue’ Tampilkan Teaser Anime dan Ungkap Staf Produksi</div>
							<div class="news_content">
								Seri ini menceritakan tentang Kitahara Iori yang pindah ke Izu untuk kuliah, di sana dia menetap di toko alat selam bernama “Grand Blue” yang dimiliki oleh kerabatnya. Setelah berbagai insiden yang melibatkan kakak kelas dan sepupunya yang bergabung dengan circle menyelam tingkat universitas, dia memutuskan untuk ikut mencoba menyelam juga.
							</div>
							<a href="#">Read More &gt;&gt;</a>
						</div>
					</div>
				</div>
				<div class="promotion">
					<div class="promotion_wrapper grid-container">
						<div>
							<div class="promotion_text">We Have Cool Item in <br>OFFICIAL SHOP</div>
							<button onclick="">Check Out</button>
						</div>
						<div class="promotion_image" style="background-image: url(assets/image/promotion.png);">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="assets/js/index.js"></script>
<?php include APPPATH.'/views/templates/footer.php'?>