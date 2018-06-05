$(document).ready(function(){
	loadNewsDetail();
	loadLatestNews();
});


function loadNewsDetail() {
	var param = {
		newsID : getParameterByName("news")
	};

	$.ajax({
		url : 'news/news/getNewsDetail',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var container = $('.news_content');
			var readNow = $('.readNow');
			$.each(data,function(key,val){
				container.append(`<div class="img_container" style='`+val.NewsImage+`'></div>
									<div class="tags">`+val.Tag+`</div>
									<div class="title">`+val.NewsTitle+`</div>
									<div class="date">`+val.writer+` • Published `+val.PublishDate+`</div> 
									<div class="content">
										`+val.NewsContent+`
									</div>`);
				readNow.append(`<div class="date">`+val.PublishDate+`</div>
								<div class="list_content">
									`+val.NewsTitle+`
								</div>`);
			});
		}
	});
}

function loadLatestNews(){
	var param = {
		newsID : getParameterByName("news")
	};

	$.ajax({
		url : 'news/news/getLatestNews',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			var latestNews = $('.latestNews');
			$.each(data, function(key, val){
				latestNews.append(`<a href="news/news?news=`+val.NewsID+`">
									<div class="date">`+val.PublishDate+`</div>
									<div class="list_content">`+val.NewsTitle+`</div>
								</a>`);
			});
		}
	});
}