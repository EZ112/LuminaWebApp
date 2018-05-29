$(document).ready(function(){
	var lsdur = JSON.parse(localStorage.getItem("duration"));
	var lsgen = JSON.parse(localStorage.getItem("genre"));

	searchAnime(lsdur,lsgen);
	searchEpisode(lsdur,lsgen);
});


function searchAnime(inDuration, inGenre){
	var param = {
		search  : getParameterByName("search"),
		duration : inDuration,
		genre : inGenre
	};

	$.ajax({
		url :'anime/animeSearch/getAnimeSearch',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container = $('.pointAnime');
			if(data.length>0){
				$.each(data,function(key,val){
					container.append(`<div class="animeContainer grid-container">
										<div class="thumbnail_container" style="background-image: url(`+val.ThumbnailLandscape+`)"></div>
										<div class="info_container">
											<a href="animepage.html" id="title">`+val.AnimeTitle+`</a>
											<div id="latest">Latest Episode `+val.LatestEpisode+`</div>
											<div id="subscriber">Subscriber `+val.SubScriber+`</div>
										</div>
										<div class="button_container"><span class="button">Subscribe</span></div>
									</div>`);
				});
			}
			else{
				container.append(`<div></div><h2>Sorry, Anime<br>Not Found</h2><div></div>`);
			}
		}, 
	  	async: false
	});
}

function searchEpisode(inDuration, inGenre){
	var param = {
		search  : getParameterByName("search"),
		duration : inDuration,
		genre : inGenre
	};

	$.ajax({
		url :'anime/animeSearch/getEpisodeSearch',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container = $('.pointEpisode');
			if(data.length>0){
				$('.result').text("About "+data.length+" Result");
				$.each(data,function(key,val){
					container.append(`<div class="episodeContainer grid-container">
										<div class="thumbnail_container"><a href="#"><img src="`+val.EpsThumbnail+`"></a></div>
										<div class="info_container">
											<a href="streaming.html" id="episode">Episode `+val.Episode+`</a>
											<span id="airDate">Aired `+val.EpsDateAir+`</span>
											<div id="title">`+val.EpsTitle+`</div>
											<div id="anime">`+val.AnimeTitle+`</div>
											<div id="views">`+val.EpisodeTotalViews+` views</div>
										</div>
									</div>`);
				});
			}
			else{
				$('.pointEpisode').empty();
				container.append(`<div></div><h2>Sorry, Anime<br>Not Found</h2><div></div>`);
			}
		}, 
	  	async: false
	});
}