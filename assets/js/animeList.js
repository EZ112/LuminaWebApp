function showMenu(x){
	var dropdown = x.getElementsByClassName("dropdown")[0];

	if(dropdown.style.display == "block"){
		dropdown.style.display = "none";
	} else{
		dropdown.style.display = "block";
	}
}

function changeTo(x){
	var str = x.innerHTML;
	x.parentElement.parentElement.getElementsByClassName("current")[0].innerHTML = str;
}
