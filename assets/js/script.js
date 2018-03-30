//document.getElementById("notification_wrapper").style.display = "none";
//document.getElementById('notification_wrapper').style.display = 'none'; 
//alert(document.getElementById('notification_wrapper').style.display);

function open_navigation(x){
	var obj = document.getElementById(x);
	//alert(obj.style.display);
	if(obj.style.display == "block"){
		obj.style.display = "none";
	} else{
		obj.style.display = "block";
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

	if(x == 0){
		for(var i = 0; i < alen; ++i){
			anime[i].style.display = "block";
		}
		for(var i = 0; i < nlen; ++i){
			news[i].style.display = "none";
		}
	} else{
		for(var i = 0; i < alen; ++i){
			anime[i].style.display = "none";
		}
		for(var i = 0; i < nlen; ++i){
			news[i].style.display = "block";
		}
	}
}

function cancel_propagation(e){
	if (!e) var e = window.event;
    e.cancelBubble = true;
    if (e.stopPropagation) e.stopPropagation();
}

function submit_filter(){
	var obj = document.getElementById('filter_content_wrapper');

	obj.submit();
	obj.parentElement.style.display = "none";
}