var showReplyObject = document.getElementsByClassName("showReply");
var showReplyObjectLength = showReplyObject.length;
var subCommentsLength = [];

var subscribeButton = document.getElementsByClassName("button");
var subscribeButtonLength = subscribeButton.length;

for(var i = 0; i < showReplyObjectLength; ++i){
	subCommentsLength[i] = showReplyObject[i].parentElement.querySelectorAll(".replyContainer").length;
	if(subCommentsLength[i] == 0){ showReplyObject[i].style.display = "none"; }
	else{ showReplyObject[i].style.display = "block"; }
}

for(var i = 0; i < subscribeButtonLength; ++i){
	subscribeButton[i].setAttribute("onclick", "subscribe(this);");
}

function activate(x){
	var active = true;
	var isCurr = false;
	var inactiveLine = "#bbcbdb";
	var inactiveColor = "#888";

	if(x.parentElement.getAttribute("name") == "curr"){ isCurr = true; } 
	else{ isCurr = false; }

	if(isCurr){
		if(x.style.borderBottom != "2px solid rgb(66, 190, 255)"){ active = false; }
		x.parentElement.querySelector("#dislikes").style.borderBottom = "2px solid " + inactiveLine;
		x.parentElement.querySelector("#likes").style.borderBottom = "2px solid " + inactiveLine;
		if(!active){ x.style.borderBottom = "2px solid #42beff"; }
	} else{
		if(x.style.color != "rgb(66, 190, 255)"){ active = false; }
		x.parentElement.querySelector("#dislikes").style.color = inactiveColor;
		x.parentElement.querySelector("#likes").style.color = inactiveColor;
		if(!active){ x.style.color = "#42beff"; }
	}
}

function showReply(x){
	var container = x.parentElement.querySelectorAll(".replyContainer");
	var length = container.length;

	if(x.innerHTML == "Show Replies +"){
		x.innerHTML = "Hide Replies -";
		for(var i = 0; i < length; ++i){ container[i].style.display = "block"; }
	} else{
		x.innerHTML = "Show Replies +";
		for(var i = 0; i < length; ++i){ container[i].style.display = "none"; }
	}
}

function subscribe(x){
	var active = "button subscribed";
	var inactive = "button";
	if(x.getAttribute("class") == inactive){
		x.setAttribute("class", active);
	} else{
		x.setAttribute("class", inactive);
	}
}
