$(document).ready(function(){
	loadDuration();
	loadGenre();
	loadTags();
	var lsdur = parseInt(JSON.parse(localStorage.getItem("duration")));
	var lsgen = JSON.parse(localStorage.getItem("genre"));	

	if(isNaN(lsdur) && !lsgen){
		var lsdur = 0;
		var lsgen = [];
		localStorage.setItem("duration", JSON.stringify(lsdur));
		localStorage.setItem("genre", JSON.stringify(lsgen));
	}

	var dest = document.getElementById('filter_duration').querySelector('#label_container');
	for(var i = 0; i < filter_duration_object.length; ++i){
		add_filter(dest, filter_duration_object[i]);
	}

	$('.custom_input_container [name="duration"]')[lsdur].checked=true;


	dest = document.getElementById('filter_genre').getElementsByClassName('label_container');
	for(var j = 0; j < 6; ++j){
		for(var i = 0; i < 5; ++i){
			add_filter(dest[j], filter_genre_object[5*j+i]);
		}
	}

	for (var i = 0; i < lsgen.length; i++) {
		$('.custom_input_container :input[value="'+lsgen[i]+'"]').prop('checked', true);
	}


	dest = document.getElementById('filter_tag').getElementsByClassName('label_container');
	for(var j = 0; j < 3; ++j){
		for(var i = 0; i < 4 && 4*j+i < filter_tag_object.length; ++i){
			add_filter(dest[j], filter_tag_object[4*j+i]);
		}
	}

	var sessionData = getSessionData();

	if(sessionData.loginUser!=null &&
		sessionData.loginSubStatus!=null){
		getFollowing(sessionData.loginUser);
		$('#widget_notification').css('visibility','visible');
		$('#Logged').append(sessionData.loginUser);
		$('#Logged').show();
	}
	else{
		$('#notLogged').show();
		getMostPopular();
	}


	$('#manageAccount .register .form').submit(function(){

		var inuser = $(this).find('input[name="rname"]').val();
		var inemail = $(this).find('input[name="remail"]').val();
		var inpass = $(this).find('input[name="rpass"]').val();
		var inconpass = $(this).find('input[name="rconpass"]').val();
		var ingender = $(this).find('input[name="gender"]').val();

		var param = {
			user : inuser,
			email : inemail,
			pass : inpass,
			gender : ingender
		}

		$.ajax({
			url :'homepage/registerAccount',
			type : 'POST',
			data : param,
			complete : function(data){
				console.log(data.responseText);
			},
			async: false
		});

		var param = {
			user : inuser,
			pass : inpass
		}

		$.ajax({
			url :'homepage/loginAccount',
			dataType : 'json',
			type : 'POST',
			data : param,
			complete : function(data){
				console.log(data.responseText);
				localStorage.setItem("username", JSON.stringify(inuser));
			}
		});
	});

	$('#manageAccount .login .form').submit(function(){

		var inuser = $(this).find('input[name="lname"]').val();
		var inpass = $(this).find('input[name="lpass"]').val();

		var param = {
			user : inuser,
			pass : inpass
		}

		$.ajax({
			url :'homepage/loginAccount',
			dataType : 'json',
			type : 'POST',
			data : param,
			complete : function(data){
				console.log(data.responseText);
				localStorage.setItem("username", JSON.stringify(inuser));	
			}
		});
	});



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
	obj.parentElement.style.display = "none";
	var durVals = $('input[name="duration"]:checked').val();
	var genreVals = [];
	$('input[name="genre"]:checked').each(function(){
		genreVals.push($(this).val());
	});

	localStorage.setItem("duration", JSON.stringify(durVals));
	localStorage.setItem("genre", JSON.stringify(genreVals));
}

function checkUser(x){
	var param = {
		user : x.value
	}
	$.ajax({
		url :'homepage/checkUser',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			if(data[0].Status != 0)
				x.setCustomValidity('Username already been taken');
			else
				x.setCustomValidity('');
		}
	});
}

function checkMatchPass(x){
	var inpass = $('#manageAccount .register .form input[name="rpass"]').val();
	var inconpass = x.value;
	if(inpass!=inconpass){
		x.setCustomValidity('Confirm Password doesn\'t match');
	}
	else{
		x.setCustomValidity('');
	}
}

function loginCheck(x){
	var param = {
		user : $('#manageAccount .login .form input[name="lname"]').val(),
		pass : x.value
	}
	$.ajax({
		url :'homepage/loginCheck',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			if(data[0].Status == 0)
				x.setCustomValidity('Incorrect Username or Password');
			else
				x.setCustomValidity('');
		}
	});
}

function getSessionData(){
	var sessionData;

	var param = {
		user : JSON.parse(localStorage.getItem("username"))
	}

	$.ajax({
		url :'homepage/getSessionData',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			sessionData = data;
		},
		async : false
	});
	return sessionData;
}

function getFollowing(Inuser){
	var param = {
		user : Inuser
	}

	$.ajax({
		url :'homepage/getFollowing',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			$('.nav_title').eq(1).next().empty();
			$('.nav_title').eq(1).next().removeClass();
			$('.nav_title').eq(1).next().addClass('following');
			var container = $('.following');
			container.prev().text('FOLLOWING');
			$.each(data,function(key,val){
				container.append(`<a href="anime/animePage?anime=`+val.AnimeID+`" class="nav_subcontent">`+val.AnimeTitle+`</a>`);
			});
			if (data.length>6) 
				container.parent().append(`<a id="show_more" onclick="showMore(this)" class=""><i class="fas fa-chevron-down"></i> Show `+data.length+` More</a>`);
		}
	});
}

function getMostPopular(){
	$.ajax({
		url :'homepage/getMostPopular',
		dataType : 'json',
		type : 'POST',
		success : function(data){
			$('.nav_title').eq(1).next().empty();
			$('.nav_title').eq(1).next().removeClass();
			$('.nav_title').eq(1).next().addClass('mostpopular');
			var container = $('.mostpopular');
			container.prev().text('MOST POPULAR');
			$.each(data,function(key,val){
				container.append(`<a href="anime/animePage?anime=`+val.AnimeID+`" class="nav_subcontent">`+val.AnimeTitle+`</a>`);
			});
			if (data.length>6) 
				container.parent().append(`<a id="show_more" onclick="showMore(this)" class=""><i class="fas fa-chevron-down"></i> Show `+data.length+` More</a>`);
		}
	});
}

function logout(){
	$.ajax({
		url :'homepage/logout',
		type : 'POST',
		complete : function(data){
			console.log(data.responseText);
		}
	});
	localStorage.removeItem("username")
	location.reload();
}