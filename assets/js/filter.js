var dest = document.getElementById('filter_duration').querySelector('#label_container');
for(var i = 0; i < filter_duration_object.length; ++i){
	add_filter(dest, filter_duration_object[i]);
}

dest = document.getElementById('filter_genre').getElementsByClassName('label_container');
for(var j = 0; j < 3; ++j){
	for(var i = 0; i < 4; ++i){
		add_filter(dest[j], filter_genre_object[4*j+i]);
	}
}

dest = document.getElementById('filter_subgenre').getElementsByClassName('label_container');
for(var j = 0; j < 5; ++j){
	for(var i = 0; i < 4; ++i){
		add_filter(dest[j], filter_subgenre_object[4*j+i]);
	}
}

dest = document.getElementById('filter_tag').getElementsByClassName('label_container');
for(var j = 0; j < 3; ++j){
	for(var i = 0; i < 4 && 4*j+i < filter_tag_object.length; ++i){
		add_filter(dest[j], filter_tag_object[4*j+i]);
	}
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

	obj.submit();
	obj.parentElement.style.display = "none";
}