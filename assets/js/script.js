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