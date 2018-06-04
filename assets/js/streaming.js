var currEps;
var currSeries;
var recommendFlag = 0;
$(document).ready(function(){
	showEpisodeStream();
	showPrevNextEps();
	showRecomendedAnime(recommendFlag,3);
});

function showEpisodeStream(){
	var param = {
		animeID : getParameterByName("anime"),
		episodeID : getParameterByName("episode")
	};

	$.ajax({
		url : 'anime/streaming/getEpisodeStream',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container = $('.video');
			$.each(data,function(key,val){
				$('head').append(val.HeadScriptVideo);
				$('.wistia_embed').addClass(val.StreamVideo);
				currEps = val.Episode;
				currSeries = val.SeriesID;
				var code = val.StreamVideo.split("_");
				var views = getViews(code[code.length-1]);
				updateTotalView(val.EpisodeID,views);
				container.append(`<span id="episode">Episode `+val.Episode+`</span>
									<span id="airDate">Aired `+val.EpsDateAir+`</span>
									<div id="title">`+val.EpsTitle+`</div>
									<div class="stats" name="curr">
										<span>`+val.AnimeTitle+`</span>
										<span id="views">`+views+` views</span>
									</div>`);
				
			});
		}, 
	  	async: false
	});
}

function showPrevNextEps(){
	var param = {
		animeID : getParameterByName("anime"),
		currEps : currEps
	};

	$.ajax({
		url : 'anime/streaming/getPrevNextEps',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container = $('.other');
			$.each(data.PrevEps,function(key,val){
				container.append(`<div class="section">Prev Episode</div>
									<div class="container one grid-container" id="prev_episode">
										<a href="anime/streaming?anime=`+val.AnimeID+`&episode=`+val.EpisodeID+`" class="video_container" style="background-image: url(`+val.EpsThumbnail+`)">
										</a>
										<div class="info">
											<a href="anime/streaming?anime=`+val.AnimeID+`&episode=`+val.EpisodeID+`" class="episode">Episode `+val.Episode+`</a>
											<div class="title">`+val.EpsTitle+`</div>
										</div>
									</div>`);
			});
			$.each(data.NextEps,function(key,val){
				container.append(`<div class="section">Next Episode</div>
									<div class="container one grid-container" id="next_episode">
										<a href="anime/streaming?anime=`+val.AnimeID+`&episode=`+val.EpisodeID+`" class="video_container" style="background-image: url(`+val.EpsThumbnail+`)">

										</a>
										<div class="info">
											<a href="anime/streaming?anime=`+val.AnimeID+`&episode=`+val.EpisodeID+`" class="episode">Episode `+val.Episode+`</a>
											<div class="title">`+val.EpsTitle+`</div>
										</div>
									</div>`);
			});
			container.append(`<div class="section" id="recommend">Recomended Anime</div>`);
		},
		async : false
	});
}

function showRecomendedAnime(inOffset,inLimit){
	var param = {
		animeID : getParameterByName("anime"),
		currSeries : currSeries,
		offset : inOffset,
		limit : inLimit
	};

	$.ajax({
		url : 'anime/streaming/getRecomendedAnime',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container = $('.other');
			if(data.length>0){
				recommendFlag+=3;
				$.each(data,function(key,val){
					container.append(`<div class="container two grid-container">
										<a href="#" class="video_container" style="background-image: url(`+val.ThumbnailLandscape+`)">
										</a>
										<div class="info">
											<a href="anime/animePage?anime=`+val.AnimeID+`" class="title">`+val.AnimeTitle+`</a>
											<div class="episode">`+val.EpisodeTotal+` Episodes</div>
											<div class="follower">`+val.Follower+` Follower</div>
											<span class="button">Follow</span>
										</div>
									</div>`);
				});
				container.append(`<div class="more" onclick="showMore(this)">
								<i class="fas fa-chevron-down"></i>
								<span id="text">Show More</span>
							</div>`);
			}
		}
	});
}

function getViews(Incode){
	var totalView = 0;
	var param = {
		code : Incode
	}
	$.ajax({
		url : 'anime/streaming/getViews',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			totalView = data.play_count;
		},
		async : false
	});

	return totalView;
}

function updateTotalView(InEpisodeID, InViews){
	var param = {
		episodeID : InEpisodeID,
		views : InViews
	}
	$.ajax({
		url : 'anime/streaming/updateTotalViews',
		dataType : 'json',
		type : 'POST',
		data : param,
		complete : function(data){
			console.log(data.responseText);
		},
	});
}

var showReplyObject = document.getElementsByClassName("showReply");
var showReplyObjectLength = showReplyObject.length;
var subCommentsLength = [];

var subscribeButton = document.getElementsByClassName("button");
var subscribeButtonLength = subscribeButton.length;

var relatedAnime = document.getElementsByClassName("two");
var relatedAnimeLength = relatedAnime.length;

for(var i = 0; i < showReplyObjectLength; ++i){
	subCommentsLength[i] = showReplyObject[i].parentElement.querySelectorAll(".replyContainer").length;
	if(subCommentsLength[i] == 0){ showReplyObject[i].style.display = "none"; }
	else{ showReplyObject[i].style.display = "block"; }
}

for(var i = 0; i < subscribeButtonLength; ++i){
	subscribeButton[i].setAttribute("onclick", "subscribe(this);");
}

for(var i = 5; i < relatedAnimeLength; ++i){
	relatedAnime[i].style.display = "none";
}

function activate(x){
	var active = true;
	var isCurr = false;
	var inactiveLine = "#bbcbdb";
	var inactiveColor = "#888";

	if(x.parentElement.getAttribute("name") == "curr"){ isCurr = true; } 
	else{ isCurr = false; }

	if(isCurr){
		if(x.style.borderBottom != "2px solid rgb(66, 190, 255)"){ active = false; }
		x.parentElement.querySelector("#dislikes").style.borderBottom = "2px solid " + inactiveLine;
		x.parentElement.querySelector("#likes").style.borderBottom = "2px solid " + inactiveLine;
		if(!active){ x.style.borderBottom = "2px solid #42beff"; }
	} else{
		if(x.style.color != "rgb(66, 190, 255)"){ active = false; }
		x.parentElement.querySelector("#dislikes").style.color = inactiveColor;
		x.parentElement.querySelector("#likes").style.color = inactiveColor;
		if(!active){ x.style.color = "#42beff"; }
	}
}

function showReply(x){
	var container = x.parentElement.querySelectorAll(".replyContainer");
	var length = container.length;

	if(x.innerHTML == "Show Replies +"){
		x.innerHTML = "Hide Replies -";
		for(var i = 0; i < length; ++i){ container[i].style.display = "block"; }
	} else{
		x.innerHTML = "Show Replies +";
		for(var i = 0; i < length; ++i){ container[i].style.display = "none"; }
	}
}

function subscribe(x){
	var active = "button subscribed";
	var inactive = "button";
	if(x.getAttribute("class") == inactive){
		x.setAttribute("class", active);
	} else{
		x.setAttribute("class", inactive);
	}
}

function showMore(x){
	showRecomendedAnime(recommendFlag,3);
	$(x).remove();
}

function replyComment(x){
	var form = x.parentElement.querySelector("#replyComment");

	if(form.style.display != "block"){
		form.style.display = "block";
	} else{
		form.style.display = "none"; 
	}
}

function checkHeight(x){
	x.style.cssText = 'height:auto; padding:0';
    x.style.cssText = 'height:' + x.scrollHeight + 'px';
}