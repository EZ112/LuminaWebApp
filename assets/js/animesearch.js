var flagAnime = 0;
var flagEpisode = 0;
var animeIsDone = false;
var animeloaded = false;
var episodeloaded = false;
var animeRow;
var episodeRow;
var lsdur;
var lsgen;
$(document).ready(function(){
	var sessionData = getSessionData();

	if(sessionData.loginUser!=null &&
		sessionData.loginSubStatus!=null){
		if(sessionData.loginSubStatus!='Premium')
			$('.google_ads').css('display','flex');
	}
	else{
		$('.google_ads').css('display','flex');
	}

	lsdur = JSON.parse(localStorage.getItem("duration"));
	lsgen = JSON.parse(localStorage.getItem("genre"));
	console.log(lsdur,lsgen);
	var totalResult;

	searchAnime(lsdur,lsgen,flagAnime,5);
	searchEpisode(lsdur,lsgen,flagEpisode,(3-((animeRow%5)-1)));
});

function searchAnime(inDuration, inGenre, inOffset, inLimit){
	var param = {
		search  : getParameterByName("search"),
		duration : inDuration,
		genre : inGenre,
		offset : inOffset,
		limit : inLimit
	};

	var container = $('.pointAnime');

	$.ajax({
		url :'anime/animeSearch/getAnimeSearch',
		dataType : 'json',
		type : 'POST',
		data : param,
		beforeSend : function(){
			animeloaded = false;
			container.append(`<div class="page-load-status">
							  <div class="loader-ellips infinite-scroll-request">
							    <span class="loader-ellips__dot"></span>
							    <span class="loader-ellips__dot"></span>
							    <span class="loader-ellips__dot"></span>
							    <span class="loader-ellips__dot"></span>
							  </div>
							</div>`);
		},
		success : function(data){
			animeRow = parseInt(data.TotalRow[0]['TotalRow']);
			if(data.AnimeTbl.length>0){
				setTimeout(function(){ 
					flagAnime+=inLimit;
					$.each(data.AnimeTbl,function(key,val){
						container.append(`<div class="animeContainer grid-container">
											<div class="thumbnail_container" style="background-image: url(`+val.ThumbnailLandscape+`)" onclick="location.href='anime/animepage'"></div>
											<div class="info_container">
												<a href="anime/animepage?anime=`+val.AnimeID+`" id="title">`+val.AnimeTitle+`</a>
												<div id="latest">Latest Episode `+val.LatestEpisode+`</div>
												<div id="subscriber">Subscriber `+val.SubScriber+`</div>
											</div>
											<div class="button_container"><span class="button">Subscribe</span></div>
										</div>`);
					});
					container.css('border-bottom','1.25px solid #bbcbdb');
					$('.page-load-status').remove();
					animeloaded = true;
				}, 500);
			}
			else{
				animeIsDone = true;
				$('.page-load-status').remove();
			}
		}, 
	  	async: false
	});
}

function searchEpisode(inDuration, inGenre, inOffset, inLimit){
	var param = {
		search  : getParameterByName("search"),
		duration : inDuration,
		genre : inGenre,
		offset : inOffset,
		limit : inLimit
	};

	var container = $('.pointEpisode');

	$.ajax({
		url :'anime/animeSearch/getEpisodeSearch',
		dataType : 'json',
		type : 'POST',
		data : param,
		beforeSend : function(){
			episodeloaded = false;
			container.append(`<div class="page-load-status">
							  <div class="loader-ellips infinite-scroll-request">
							    <span class="loader-ellips__dot"></span>
							    <span class="loader-ellips__dot"></span>
							    <span class="loader-ellips__dot"></span>
							    <span class="loader-ellips__dot"></span>
							  </div>
							</div>`);
		},
		success : function(data){
			episodeRow = parseInt(data.TotalRow[0]['TotalRow']);
			totalResult = animeRow + episodeRow;
			$('.result').text("About "+totalResult+" Results");
			if(data.EpisodesTbl.length>0){
				$('.subheader').text("Most Viewed Episode");
				setTimeout(function(){ 
				flagEpisode+=inLimit;
				$.each(data.EpisodesTbl,function(key,val){
					container.append(`<div class="episodeContainer grid-container" onclick="location.href='anime/streaming?anime=`+val.AnimeID+`&episode=`+val.EpisodeID+`'">
										<div class="thumbnail_container" style="background-image: url(`+val.EpsThumbnail+`)"></div>
										<div class="info_container">
											<a href="anime/streaming?anime=`+val.AnimeID+`&episode=`+val.EpisodeID+`" id="episode">Episode `+val.Episode+`</a>
											<span id="airDate">Aired `+val.EpsDateAir+`</span>
											<div id="title">`+val.EpsTitle+`</div>
											<div id="anime">`+val.AnimeTitle+`</div>
											<div id="views">`+val.EpisodeTotalViews+` views</div>
										</div>
									</div>`);
				});
				$('.page-load-status').remove();
				episodeloaded = true;
				}, 500);
			}
			else {
				if (animeIsDone)
					$('.page-load-status').remove();
				if (totalResult == 0)
					container.remove();
			}
		}, 
	  	async: false
	});
}

$(window).scroll(function(){
	console.log(animeloaded, episodeloaded);
	if (Math.ceil($(window).scrollTop()) >= $(document).height() - $(window).height()) {
		if(!animeIsDone && animeloaded){
			searchAnime(lsdur,lsgen,flagAnime,3);
		}
		else if(animeIsDone && episodeloaded){
			searchEpisode(lsdur,lsgen,flagEpisode,3);
		}
	}
});