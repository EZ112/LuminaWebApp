function showMenu(x){
	var curr = x.getElementsByClassName("dropdown")[0];

	var dropdown = document.getElementsByClassName("dropdown");
	for(var i = 0; i < dropdown.length; ++i){ if(dropdown[i] != curr) dropdown[i].style.display = "none"; }

	if(curr.style.display == "block"){
		curr.style.display = "none";
	} else{
		curr.style.display = "block";
	}
}

function changeTo(x){
	var str = x.innerHTML;
	x.parentElement.parentElement.getElementsByClassName("current")[0].innerHTML = str;
}