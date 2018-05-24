function open_faq(x){
	var ans = x.parentElement.querySelector("#answer");
	if(x.innerHTML == "+"){
		x.innerHTML = "-";
		ans.style.display = "block";
	} else{
		x.innerHTML = "+";
		ans.style.display = "none";
	}
}