/*var fly = document.getElementById("fly");

var sW = window.innerWidth;
var sH = window.innerHeight;
var bW = 0.04*sW;
var bH = 0.04*sH;

var flypos = {x:0, y:0};
var mouse = {x:0, y:0};

document.addEventListener("mousemove", getMouse); 
setInterval(followMouse, 50);

function getMouse(e){
	mouse.x = e.pageX - 0.5*sW;
	mouse.y = e.pageY - 0.5*sH;
}

function followMouse(){
	//1. Get the mouse position relative to the screen width in percent
	var mouseXp = mouse.x / sW;
	var mouseYp = mouse.y / sH;

	//2. Calculate the expected position of fly
	var flyXr = mouseXp * bW;
	var flyYr = mouseYp * bH;

	//3. Calculate distance between expected and current position
	var distX = flyXr - flypos.x;
	var distY = flyYr - flypos.y;

	flypos.x += distX/10;
	flypos.y += distY/10;
	
	fly.style.left = flypos.x + "px";
	fly.style.top = flypos.y + "px";
}*/