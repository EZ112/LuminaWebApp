$(document).ready(function(){
	var sessionData = getSessionData();
	loadWatchHistory(sessionData.loginUser);
});

Element.prototype.remove = function() { this.parentElement.removeChild(this); }
var videoContainer = document.getElementsByClassName("videoContainer");
var videoContainerLength;

function removeElement(x) {
	videoContainerLength = videoContainer.length;
	x.remove();
	videoContainerLength--;
	if(videoContainerLength == 0){
		document.getElementById("removeAll").style.display = "none";
	}
}

function removeAll(x){
	videoContainerLength = videoContainer.length;
	for (var i = 0; i < videoContainerLength; i++) { videoContainer[0].remove(); }
	x.remove();
}

function loadWatchHistory(InUsername) {
	var param = {
		username : InUsername
	};

	$.ajax({
		url : 'anime/watchHistory/getWatchHistory',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container = $('.content');

			$.each(data,function(key,val){
				container.append(`<div class="videoContainer grid-container" value="`+val.WatchHistoryID+`">
									<a href="#" class="videoThumbnail" style="background-image(`+val.EpsThumbnail+`)"></a>
									<div class="dummyCenter">
										<div class="videoDetail">
											<a href="#" class="videoEpisode">Episode `+val.EpisodeID+`</a>
											<span class="videoAirDate">Aired `+val.DateAir+`</span>
											<div class="videoTitle">`+val.EpsTitle+`</div>
											<div class="videoAnime">`+val.AnimeTitle+`</div>
											<div class="videoViews">`+val.EpisodeTotalViews+` views</div>
										</div>
									</div>
									<div class="redify" onclick="removeWatchHistory(this); removeElement(this.parentElement);">
										<i class="fas fa-times"></i>
									</div>
								</div>`);
			});
		}
	});
}

function removeWatchHistory(x){
	var InUsername = getSessionData().loginUser;
	var InHistoryID = x.parentElement.getAttribute("value");

	var param = {
		historyID : InHistoryID,
		username : InUsername
	};

	$.ajax({
		url : 'anime/watchHistory/deleteWatchHistory',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			console.log(data);
		}
	});
}