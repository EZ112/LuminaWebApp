$(document).ready(function(){
    $('#show_more').click(function() {
    	if($(this).attr('class') == ''){
    		$(this).prev().css("max-height","none");
    		$(this).attr('class','open');
    		$(this).html('<i class="fas fa-chevron-up"></i> Show Less');
    	}
    	else{
    		$(this).prev().css("max-height","15vw");
    		$(this).attr('class','');
    		$(this).html('<i class="fas fa-chevron-down"></i> Show 10 More');
    	}
    });
});

function open_navigation(x){
	var obj = document.getElementById(x);
	//alert(obj.style.display);
	if(obj.style.display == "block"){
		obj.style.display = "none";
	} else{
		obj.style.display = "block";
	}
}

function cancel_propagation(e){
	if (!e) var e = window.event;
    e.cancelBubble = true;
    if (e.stopPropagation) e.stopPropagation();
}

function anime_object(title, filter, img_src){
	this.title = title;
	this.filter = filter.split(",");
	this.img = img_src;

	/*this.change_title = function (title){
		this.title = title;
	}
	this.add_filter = function (filter_name){
		this.filter.push(filter_name);
	}
	this.remove_filter = function (filter_name){
		var len = this.filter.length;
		var temp = this.filter[len - 1];
		for(var i = 0; i < len; ++i){
			if(this.filter[i] == filter_name){
				this.filter[i] = temp;
				break;
			}
		}
		this.filter.pop();
	}*/
}

function show_more(x){
	x.style.maxHeight = "none";
}

function search_anime(x){
	window.location.href = 'animesearch.html'; 
	return false;
}

function close_popup(x){
	$(x).parent().parent().parent().hide();
}



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