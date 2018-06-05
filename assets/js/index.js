$(document).ready(function(){
	loadAnimeLatestUpdate();
	loadNewsLatestUpdate();

	pageSize = 4;
	pagesCount = $(".latest_update_wrapper div").length;
	var totalPages = Math.ceil(pagesCount / pageSize);

	$('.pagination').twbsPagination({
	    totalPages: totalPages,
	    visiblePages: 5,
	    onPageClick: function (event, page) {
	        var startIndex = (pageSize*(page-1));
	        var endIndex = startIndex + pageSize;
	        $('.latest_update_wrapper div').hide().filter(function(){
	            var idx = $(this).index();
	            return idx>=startIndex && idx<endIndex;
	        }).show()
	        $('.episode').hide().filter(function(){
	            var idx = $(this).index()-pagesCount;
	            return idx>=startIndex && idx<endIndex;
	        }).show();
	        $('.pagination').find('li:contains("First")').html('<i class="fas fa-angle-double-left"></i>');
			$('.pagination').find('li:contains("Previous")').html('<i class="fas fa-angle-left"></i>');
			$('.pagination').find('li:contains("Next")').html('<i class="fas fa-angle-right"></i>');
			$('.pagination').find('li:contains("Last")').html('<i class="fas fa-angle-double-right"></i>');
	    }
	});

	var sessionData = getSessionData();

	loadTopAiringAnime(sessionData.loginUser);

	if(sessionData.loginUser!=null &&
		sessionData.loginSubStatus!=null){
		if(sessionData.loginSubStatus!='Premium' && sessionData.Status!='Active')
			$('.google_ads').css('display','flex');
	}
	else{
		$('.google_ads').css('display','flex');
	}

	// function followToggle(x){
	// 	if (sessionData.loginUser != null) {

	// 	}
	// 	if($(x).attr('class') == 'followed'){
			
	// 	}
	// }
});

function loadAnimeLatestUpdate() {
	$.ajax({
		url :'homepage/getAnimeLatestUpdate',
		dataType : 'json',
		type : 'POST',
		success : function(data){
			var container = $('.latest_update_wrapper');

			$.each(data,function(key,val){
				container.append(`<div class="animeThumb" onclick="location.href='anime/streaming?anime=`+val.AnimeID+`&episode=`+val.EpisodeID+`'" title="`+val.AnimeTitle+`" 
									   style="background-image: url(`+val.Thumbnail+`)">
								  </div>`);
			});

			for (var i = 0; i < 4-data.length%4; i++) {
				container.append(`<div></div>`);
			}

			$.each(data,function(key,val){
				container.append(`<span class="episode">Episode `+val.LatestEpisode+`</span>`);
			});

			for (var i = 0; i < 4-data.length%4; i++) {
				container.append(`<span></span>`);
			}
		}, 
	  	async: false
	});
}

function loadTopAiringAnime(InUser){
	var param = {
		user : InUser
	}
	$.ajax({
		url :'homepage/getTopAiringAnime',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container = $('.top_airing_wrapper');

			$.each(data,function(key,val){
				container.append(`<div class="animeThumb" onclick="location.href='anime/animepage?anime=`+val.AnimeID+`'" title="`+val.AnimeTitle+`" style="background-image: url(`+val.Thumbnail+`)">
									<span class="numbering">`+(key+1)+`</span>
								  </div>`);
			});

			$.each(data,function(key,val){
				if(val.FollowStatus != null)
					container.append(`<button class="followed" onclick="followToggle(this)">Follow</button>`);
				else
					container.append(`<button class="unfollowed" onclick="followToggle(this)">Follow</button>`);
			});
		}, 
	  	async: false
	});
}

function loadNewsLatestUpdate(){
	$.ajax({
		url :'homepage/getNewsLatestUpdate',
		dataType : 'json',
		type : 'POST',
		success : function(data){
			var container = $('.latest_news_wrapper');

			$.each(data,function(key,val){
				container.append(`<span onclick="location.href='news/news?news=`+val.NewsID+`'" style="background-image: url(`+val.NewsThumbnail+`)"></span>`);
				container.append(`<div>
									<div onclick="location.href='news/news?news=`+val.NewsID+`'" class="news_title">`+val.NewsTitle+`</div>
										<div class="news_content">
											`+val.Headline+`
									</div>
									<a href="#">Read More &gt;&gt;</a>
								  </div>`);
			});
		}, 
	  	async: false
	});
}