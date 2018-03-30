function open_navigation(x){
	var obj = document.getElementById(x);

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