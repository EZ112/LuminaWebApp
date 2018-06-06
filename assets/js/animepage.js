$(document).ready(function(){
	showAnimeDetail();
	showAnimeRank();
	showRelatedAnime();
	showAnimePageEpisodes();
});


function showAnimeDetail(){
	var param = {
		animeID : getParameterByName("anime")
	};

	$.ajax({
		url : 'anime/animePage/getAnimeDetail',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container;

			$.each(data,function(key,val){
				$('head').append(val.PVHeadScript);
				$('.wistia_embed').addClass(val.PromotionalVideo);
				container = $('#curr_anime_image');
				container.css('background-image','url('+val.ThumbnailLandscape+')');
				container = $('#curr_anime_title');
				container.text(val.AnimeTitle);
				container = $('#c');
				container.append(`<div class="detailContainer">
										<span>Title</span><span>`+val.AnimeTitle+`</span>
									</div>
									<div class="detailContainer">
										<span>Episode</span><span>`+val.EpisodeTotal+`</span>
									</div>
									<div class="detailContainer">
										<span>Status</span><span>`+val.Status+`</span>
									</div>
									<div class="detailContainer">
										<span>Duration</span><span>`+val.Duration+`</span>
									</div>
									<div class="detailContainer">
										<span>Studio</span><span>`+val.Studio+`</span>
									</div>
									<div class="detailContainer">
										<span>Source</span><span>`+val.Source+`</span>
									</div>
									<div class="detailContainer">
										<span>Rating</span><span>`+val.RatingDetails+`</span>
									</div>
									<div class="detailContainer">
										<span>Genres</span><span>`+val.Genres+`</span>
									</div>`);
				container = $('.synopsis');
				container.html(val.Synopsis);
				container = $('#e');
				container.append(`<span class="button">Follower `+val.Follower+`</span>`);
			});
			 	
		}
	});
}

function showAnimeRank(){
	var param = {
		animeID : getParameterByName("anime")
	};

	$.ajax({
		url : 'anime/animePage/getAnimeRank',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container = $('#rank');
			$.each(data,function(key,val){
				container.append(`Ranked #`+val.Rank);
			});
		}
	});
}

function showRelatedAnime(){
	var param = {
		animeID : getParameterByName("anime")
	};

	$.ajax({
		url : 'anime/animePage/getRelatedAnime',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container = $('#d');
			$.each(data,function(key,val){
				if(key%3==0)container.append(`<div class="relatedContainer"></div>`);
				$('.relatedContainer:last-child').append(`<div><a href="anime/animePage?anime=`+val.AnimeID+`">`+val.AnimeTitle+`</a></div>`);
			});
		}
	});
}

function showAnimePageEpisodes(){
	var param = {
		animeID : getParameterByName("anime"),
		sort : $('.sort_filter .active').text()
	};

	$.ajax({
		url : 'anime/animePage/getAnimePageEpisodes',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container = $('.episode.content');
			container.empty();
			$.each(data,function(key,val){
				container.append(`<div onclick="location.href='anime/streaming?anime=`+val.AnimeID+`&episode=`+val.EpisodeID+`'" class="episode_container">
									<div class="left">
										<div class="thumbnail_container" style="background-image: url(`+val.EpsThumbnail+`)">
										</div>
									</div><div class="right">
										<a href="anime/streaming?anime=`+val.AnimeID+`&episode=`+val.EpisodeID+`" class="episode_num">Episode `+val.Episode+`</a> 
										<span class="date">Aired `+val.EpsDateAir+`</span>
										<div class="title">`+val.EpsTitle+`</div>
										<div class="views">`+val.EpisodeTotalViews+` views</div>
									</div>
								</div>`);
			});
		}
	});
}

$('.sort_filter span').click(function(){
	$(this).siblings().addClass("inactive").removeClass("active");
	$(this).addClass('active').removeClass('inactive');
	showAnimePageEpisodes();
});

// var tab = document.getElementsByClassName("tab");
// var content = document.getElementsByClassName("content");

// tab[0].setAttribute("class", "tab tab_active");
// tab[1].setAttribute("class", "tab tab_inactive");
// content[0].style.display = "block";
// content[1].style.display = "none";

// function change_tab(x){
// 	tab[x].setAttribute("class", "tab tab_active");
// 	tab[(x+1)%2].setAttribute("class", "tab tab_inactive");

// 	content[x].style.display = "block";
// 	content[(x+1)%2].style.display = "none";

// 	if(x == 0){
// 		document.getElementsByClassName("sort")[0].style.display = "block";
// 	} else{
// 		document.getElementsByClassName("sort")[0].style.display = "none";
// 	}
// }


// var rated = document.getElementsByClassName("rated");
// var fill = document.getElementsByClassName("fill");
// var score = [];
// var sum = 0;

// for(var i = 0; i < 5; ++i){
// 	var temp = rated[i].innerHTML;
// 	var len = temp.length;
// 	var curr = temp.slice(1, -1);
// 	score.push(parseInt(curr));
// 	sum += score[i];
// }

// for(var i = 0; i < 5; ++i){
// 	fill[i].style.width = score[i]/sum*100 + "%";
// }

