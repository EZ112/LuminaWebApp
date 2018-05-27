function deleteTableObject(x){
	x.parentElement.removeChild(x);

	var objectCount = document.getElementsByClassName("tableObject").length;
	if(objectCount == 0) document.getElementById("empty").style.display = "block";
}

function switchNav(x){
	var obj = document.querySelectorAll(".content div");
	var headTitle = document.querySelector(".head_title .title");

	if(x.innerHTML == "Master"){
		obj[0].style.display = "block";
		obj[1].style.display = "none";
	} else{
		obj[0].style.display = "none";
		obj[1].style.display = "block";
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

	if(flag == true){ x.parentElement.submit(); } 
	else{ 
		document.getElementById("warning").style.display = "inline-block";
		var select = document.getElementById("selectMaster");
		document.querySelector("#warning span").innerHTML = select.options[select.selectedIndex].innerHTML;
	}
}

function switchForm(x){
	var obj = x.options[x.selectedIndex].innerHTML;
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
}