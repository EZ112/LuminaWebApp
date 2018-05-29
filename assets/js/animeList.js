$(document).ready(function(){
	var inyear = $('#year .current').text();
	var inseason = $('#season .current').text();
	var instatus = $('#status .current').text();
	var induration = $('#duration .current').text();
	var insort = $('#sort .current').text();
	loadAnimeList(inyear,inseason,instatus,induration,insort);
});


function showMenu(x){
	var curr = x.getElementsByClassName("dropdown")[0];

	var dropdown = document.getElementsByClassName("dropdown");
	for(var i = 0; i < dropdown.length; ++i){ if(dropdown[i] != curr) dropdown[i].style.display = "none"; }

	if(curr.style.display == "block"){
		curr.style.display = "none";
	} else{
		curr.style.display = "block";
	}
}

function changeTo(x){
	var str = x.innerHTML;
	x.parentElement.parentElement.getElementsByClassName("current")[0].innerHTML = str;
}

$('.dropdown .options').click(function(){
	var inyear = $('#year .current').text();
	var inseason = $('#season .current').text();
	var instatus = $('#status .current').text();
	var induration = $('#duration .current').text();
	var insort = $('#sort .current').text();
	loadAnimeList(inyear,inseason,instatus,induration,insort);
});


function loadAnimeList(inyear,inseason,instatus,induration,insort){
	var param = {
		year : inyear,
		season : inseason,
		status : instatus,
		duration : induration,
		sort : insort
	};
	$.ajax({
		url :'anime/animeList/getAnimeList',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container = $('.animeList');
			$('.animeList').empty();
			if(data.length>0){
				$.each(data,function(key,val){
					container.append(`<div>
										<div onclick="" class="animeImage" title="`+val.AnimeTitle+`" style="background-image: url(`+val.Thumbnail+`)"></div>
										<div class="animeDetail">
											<div class="detail"><div>Source</div><div>`+val.Source+`</div></div>
											<div class="detail"><div>Total Episodes</div><div>`+val.EpisodeTotal+`</div></div>
											<div class="detail"><div>Duration</div><div>`+val.Duration+`</div></div>
											<div class="detail"><div>Subscriber</div><div>`+val.Subscriber+`</div></div>
											<div class="detail"><div>Genres</div><div>`+val.Genres+`</div></div>
										</div>
									</div>`);
				});
			}
			else{
				$('.result').text("About "+data.length+" Result");
				container.append(`<div></div><h2>Sorry, Anime<br>Not Found</h2><div></div>`);
			}
		}, 
	  	async: false
	});
}
