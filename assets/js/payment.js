function changeDurationTo(str){
	var label = document.getElementsByClassName("label");
	var value = document.querySelectorAll("label input");

	if(str == 'basic'){
		label[2].innerHTML = "Rp 50k Monthly";
		value[2].setAttribute("value", "b1");
		label[3].innerHTML = "Rp 550k Annually";
		value[3].setAttribute("value", "b2");
	} else{
		label[2].innerHTML = "Rp 100k Monthly";
		value[2].setAttribute("value", "p1");
		label[3].innerHTML = "Rp 1000k Annually";
		value[3].setAttribute("value", "p2");
	}
}

function proceed(x){
	window.location.href = 'success.html'; 
	return false;
}