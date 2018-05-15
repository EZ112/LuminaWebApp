Element.prototype.remove = function() {
    this.parentElement.removeChild(this);
}

var videoContainer = document.getElementsByClassName("videoContainer");
var videoContainerLength = videoContainer.length;

function removeElement(x) {
	x.remove();
	videoContainerLength--;
	if(videoContainerLength == 0){
		document.getElementById("removeAll").remove();
	}
}

function removeAll(x){
	for (var i = 0; i < videoContainerLength; i++) {
		//console.log(videoContainer[i].innerHTML);
		videoContainer[0].remove();
	}
	x.remove();
}