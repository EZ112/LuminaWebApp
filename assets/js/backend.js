function changeInsertEpisodeStatus(){
	var status = document.getElementById("status");
	var curr = parseInt(document.getElementById("currEpisode").innerHTML);
	var total = parseInt(document.getElementById("totalEpisode").innerHTML);

	if(curr < total){ status.value = "On Going"; }
	else{ status.value = "Completed"; }
}

function deleteTableObject(x){
	x.parentElement.removeChild(x);

	var objectCount = document.getElementsByClassName("tableObject").length;
	if(objectCount == 0) document.getElementById("empty").style.display = "block";
}

// Insert -> Anime -> Genre [STATIC]
function insertGenre(){
	var genreContainer = document.getElementById("genreContainer");

	for(var i = 0; i < 12; ++i){
		var next = "<label class='custom_input_container'> " + filter_genre_object[i].text + "<input type='checkbox' name='genre' + value=" + filter_genre_object[i].value + "> <span class='custom_checkbox'></span></label>"; 
		genreContainer.innerHTML += next;
	}
}

function switchNav(x){
	var master = document.querySelector("#master");
	var insert = document.querySelector("#insert");
	var headTitle = document.querySelector(".head_title .title");

	if(x.innerHTML == "Master"){
		master.style.display = "block";
		insert.style.display = "none";
	} else{
		master.style.display = "none";
		insert.style.display = "block";
	}
	headTitle.innerHTML = x.innerHTML;
}

function submitForm(x){ 
	var input = document.querySelector("#formMaster input").value;
	var tableObject = document.getElementsByClassName("tableObject");
	var tableObjectTitle = document.querySelectorAll(".tableObject .title");
	var flag = true;

	for(var i = 0; i < tableObject.length; ++i){
		if(tableObjectTitle[i].innerHTML == input){
			flag = false;
			break;
		}
	}

	if(flag == true){ x.submit(); return true; } 
	else{ 
		document.getElementById("warning").style.display = "inline-block";
		var select = document.getElementById("selectMaster");
		document.querySelector("#warning span").innerHTML = select.options[select.selectedIndex].innerHTML;
		return false;
	}
}

function switchForm(x){
	var active = document.querySelector(".head_title .title").innerHTML;
	var obj = x.options[x.selectedIndex].innerHTML;

	if(active == "Master"){
		var form = document.getElementById("formMaster");
		var label = document.querySelector("#formMaster #label");
		var tableHeading = document.querySelector("#table #tableHeading");
		
		label.innerHTML = obj;
		tableHeading.innerHTML = obj;

		var action;
		if(obj == "Series"){ action = "#"; }
		else if(obj == "Studio"){ action = "#"; }
		else{ action = "#"; }

		form.setAttribute("action", action);
	} else{
		var anime = document.querySelector(".anime");
		var episode = document.querySelector(".episode");
		var news = document.querySelector(".news");
		
		anime.style.display = "none"; 
		episode.style.display = "none";
		news.style.display = "none";

		if(obj == "Anime"){
			anime.style.display = "block";
		} else if(obj == "Episode"){
			episode.style.display = "block";
			changeInsertEpisodeStatus();
		} else{
			news.style.display = "block";
		}
	}
}

function main(){
	insertGenre();
}

main();