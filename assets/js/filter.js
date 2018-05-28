$(document).ready(function(){
	loadDuration();
	loadGenre();
	loadTags();
	var dest = document.getElementById('filter_duration').querySelector('#label_container');
	for(var i = 0; i < filter_duration_object.length; ++i){
		add_filter(dest, filter_duration_object[i]);
	}

	$('.custom_input_container [name="duration"]')[0].checked=true

	dest = document.getElementById('filter_genre').getElementsByClassName('label_container');
	for(var j = 0; j < 3; ++j){
		for(var i = 0; i < 4; ++i){
			add_filter(dest[j], filter_genre_object[4*j+i]);
		}
	}

	dest = document.getElementById('filter_tag').getElementsByClassName('label_container');
	for(var j = 0; j < 3; ++j){
		for(var i = 0; i < 4 && 4*j+i < filter_tag_object.length; ++i){
			add_filter(dest[j], filter_tag_object[4*j+i]);
		}
	}
});

//INI CLASS BKN FUNCTION, DECLARE PAKE VAR = NEW FILTER_OBJECT(ARGS[]);
function filter_object(text, type, name, value) {
	this.text = text;
    this.type = type;
    this.name = name;
    this.value = value;
    this.checked = false;
}

function add_filter(obj, filter){ obj.innerHTML += "<label class='custom_input_container'> " + filter.text + "<input type='" + filter.type + "' name='" + filter.name + "' value='" + filter.value + "'> <span class='custom_" + filter.type + "'></span></label>"; }

var filter_duration_object = new Array();
var filter_genre_object = new Array();
var filter_tag_object = new Array();

function loadDuration(){
	$.ajax({
		url :'homepage/getDuration',
		dataType : 'json',
		type : 'POST',
		success : function(data){
			filter_duration_object.push(new filter_object("All", "radio", "duration", "0"));
				$.each(data,function(key,val){
					filter_duration_object.push(new filter_object(val.Duration, "radio", "duration", val.DurationID));
				});
		}, 
  		async: false
	});
}

function loadGenre(){
	$.ajax({
		url :'homepage/getGenre',
		dataType : 'json',
		type : 'POST',
		success : function(data){
				$.each(data,function(key,val){
					filter_genre_object.push(new filter_object(val.Genre, "checkbox", "genre", val.Genre));
				});
		}, 
  		async: false
	});
}

function loadTags(){
	$.ajax({
		url :'homepage/getTags',
		dataType : 'json',
		type : 'POST',
		success : function(data){
				$.each(data,function(key,val){
					filter_tag_object.push(new filter_object(val.Tag, "checkbox", "tags", val.Tag));
				});
		}, 
  		async: false
	});	
}

function change_filter(x){
	var obj = document.getElementById('filter_type').getElementsByTagName('div');

	obj[x].setAttribute("id", "active");
	obj[(x+1)%2].removeAttribute("id");

	var anime = document.getElementsByClassName('filter_anime');
	var alen = anime.length;
	var news = document.getElementsByClassName('filter_news');
	var nlen = news.length;

	var anime_input;
	var anime_input_len;
	var news_input;
	var news_input_len;

	if(x == 0){
		for(var i = 0; i < alen; ++i){
			anime[i].style.display = "block";

			anime_input = anime[i].querySelectorAll("input");
			anime_input_len = anime_input.length;
			for(var j = 0; j < anime_input_len; ++j){
				anime_input[j].removeAttribute("disabled");
			}
		}
		for(var i = 0; i < nlen; ++i){
			news[i].style.display = "none";

			news_input = news[i].querySelectorAll("input");
			news_input_len = news_input.length;
			for(var j = 0; j < news_input_len; ++j){
				news_input[j].setAttribute("disabled", "");
			}
		}
	} else{
		for(var i = 0; i < alen; ++i){
			anime[i].style.display = "none";

			anime_input = anime[i].querySelectorAll("input");
			anime_input_len = anime_input.length;
			for(var j = 0; j < anime_input_len; ++j){
				anime_input[j].setAttribute("disabled", "");
			}
		}
		for(var i = 0; i < nlen; ++i){
			news[i].style.display = "block";

			news_input = news[i].querySelectorAll("input");
			news_input_len = news_input.length;
			for(var j = 0; j < news_input_len; ++j){
				news_input[j].removeAttribute("disabled");
			}
		}
	}
}

function submit_filter(){
	var obj = document.getElementById('filter_content_wrapper');
	// obj.submit();
	obj.parentElement.style.display = "none";
	var durVals = $('input[name="duration"]:checked').val()
	var genreVals = [];
	$('input[name="genre"]:checked').each(function(){
		genreVals.push($(this).val());
	});

	localStorage.setItem("duration", JSON.stringify(durVals));
	localStorage.setItem("genre", JSON.stringify(genreVals));
}