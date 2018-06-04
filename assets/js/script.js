function showMore(x){
	if($(x).attr('class') == ''){
	   $(x).prev().css("max-height","none");
	   $(x).attr('class','open');
	   $(x).html('<i class="fas fa-chevron-up"></i> Show Less');
	}
	else{
		$(x).prev().css("max-height","15vw");
		$(x).attr('class','');
		$(x).html('<i class="fas fa-chevron-down"></i> Show 10 More');
	}
}

function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

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

function close_popup(x){
	$(x).parent().parent().parent().hide();
}
