//INI CLASS BKN FUNCTION, DECLARE PAKE VAR = NEW FILTER_OBJECT(ARGS[]);
function filter_object(text, type, name, value) {
	this.text = text;
    this.type = type;
    this.name = name;
    this.value = value;
    this.checked = false;
}

function add_filter(obj, filter){ obj.innerHTML += "<label class='custom_input_container'> " + filter.text + "<input type='" + filter.type + "' name='" + filter.name + "' value='" + filter.value + "'> <span class='custom_" + filter.type + "'></span></label>"; }

var filter_duration_object = [
	new filter_object("All", "radio", "duration", "1"),
	new filter_object("Short", "radio", "duration", "2"),
	new filter_object("24min Series", "radio", "duration", "3"),
	new filter_object("Movie", "radio", "duration", "4")
];

var filter_genre_object = [
	new filter_object("Action", "checkbox", "genre", "action"),
	new filter_object("Adventure", "checkbox", "genre", "adventure"),
	new filter_object("Comedy", "checkbox", "genre", "comedy"),
	new filter_object("Drama", "checkbox", "genre", "drama"),
	new filter_object("Fantasy", "checkbox", "genre", "fantasy"),
	new filter_object("Horror", "checkbox", "genre", "horror"),
	new filter_object("Magic", "checkbox", "genre", "magic"),
	new filter_object("Mystery", "checkbox", "genre", "mystery"),
	new filter_object("Psychological", "checkbox", "genre", "psychological"),
	new filter_object("Romance", "checkbox", "genre", "romance"),
	new filter_object("Sci-Fi", "checkbox", "genre", "sci_fi"),
	new filter_object("Slice of Life", "checkbox", "genre", "slice_of_life")
];

var filter_subgenre_object = [
	new filter_object("Cyberpunk", "checkbox", "subgenre", "cyberpunk"),
	new filter_object("Demon", "checkbox", "subgenre", "demon"),
	new filter_object("Ecchi", "checkbox", "subgenre", "ecchi"),
	new filter_object("Game", "checkbox", "subgenre", "game"),
	new filter_object("Harem", "checkbox", "subgenre", "harem"),
	new filter_object("Historical", "checkbox", "subgenre", "historical"),
	new filter_object("Isekai", "checkbox", "subgenre", "isekai"),
	new filter_object("Josei", "checkbox", "subgenre", "josei"),
	new filter_object("Martial Arts", "checkbox", "subgenre", "martial_arts"),
	new filter_object("Mecha", "checkbox", "subgenre", "mecha"),
	new filter_object("Military", "checkbox", "subgenre", "military"),
	new filter_object("Music", "checkbox", "subgenre", "music"),
	new filter_object("Parody", "checkbox", "subgenre", "parody"),
	new filter_object("Post-Apocalyptic", "checkbox", "subgenre", "post_apocalyptic"),
	new filter_object("Reverse Harem", "checkbox", "subgenre", "reverse_harem"),
	new filter_object("School", "checkbox", "subgenre", "school"),
	new filter_object("Seinen", "checkbox", "subgenre", "seinen"),
	new filter_object("Shoujo", "checkbox", "subgenre", "shoujo"),
	new filter_object("Shounen", "checkbox", "subgenre", "shounen"),
	new filter_object("Super Power", "checkbox", "subgenre", "super_power"),
];

var filter_tag_object = [
	new filter_object("Anime", "checkbox", "tags", "anime"),
	new filter_object("Culinary", "checkbox", "tags", "culinary"),
	new filter_object("Events", "checkbox", "tags", "events"),
	new filter_object("Hobby", "checkbox", "tags", "hobby"),
	new filter_object("Japanese Culture", "checkbox", "tags", "japanese_culture"),
	new filter_object("Light Novel", "checkbox", "tags", "light_novel"),
	new filter_object("Manga", "checkbox", "tags", "manga"),
	new filter_object("Movie", "checkbox", "tags", "movie"),
	new filter_object("Music", "checkbox", "tags", "music"),
	new filter_object("Place & Travel", "checkbox", "tags", "place_travel"),
	new filter_object("Vocaloid", "checkbox", "tags", "vocaloid"),
];

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