$(document).ready(function(){
	var lsdur = JSON.parse(localStorage.getItem("duration"));
	var lsgen = JSON.parse(localStorage.getItem("genre"));	
});


function searchAnime(inDuration, inGenre){
	var param = {
		duration : inDuration,
		genre : inGenre
	};

	$.ajax({
		url :'anime/animeSearch/getAnime',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			
		}, 
	  	async: false
	});
}

