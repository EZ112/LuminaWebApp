var tab = document.getElementsByClassName("tab");
var content = document.getElementsByClassName("content");
var sort

tab[0].setAttribute("class", "tab tab_active");
tab[1].setAttribute("class", "tab tab_inactive");
content[0].style.display = "block";
content[1].style.display = "none";

function change_tab(x){
	tab[x].setAttribute("class", "tab tab_active");
	tab[(x+1)%2].setAttribute("class", "tab tab_inactive");

	content[x].style.display = "block";
	content[(x+1)%2].style.display = "none";

	if(x == 0){
		document.getElementsByClassName("sort")[0].style.display = "block";
	} else{
		document.getElementsByClassName("sort")[0].style.display = "none";
	}
}


var rated = document.getElementsByClassName("rated");
var fill = document.getElementsByClassName("fill");
var score = [];
var sum = 0;

for(var i = 0; i < 5; ++i){
	var temp = rated[i].innerHTML;
	var len = temp.length;
	var curr = temp.slice(1, -1);
	score.push(parseInt(curr));
	sum += score[i];
}

for(var i = 0; i < 5; ++i){
	fill[i].style.width = score[i]/sum*100 + "%";
}

