$(document).ready(function(){
	$('input[name="paymentMethod"]').change(function(){
		console.log('qwe');
	});
});

function changePaymentPlan(str){
	var label = document.getElementsByClassName("label");
	var value = document.querySelectorAll("label input");

	if(str == 'basic'){
		label[2].innerHTML = "Rp 50k Monthly";
		value[2].setAttribute("value", "basicMonthly");
		label[3].innerHTML = "Rp 550k Annually";
		value[3].setAttribute("value", "basicAnnually");
	} else{
		label[2].innerHTML = "Rp 100k Monthly";
		value[2].setAttribute("value", "primaryMonthly");
		label[3].innerHTML = "Rp 1000k Annually";
		value[3].setAttribute("value", "primaryAnnually");
	}
}

// function changePaymentPlan(str){
// 	var label = document.getElementsByClassName("label");
// 	var value = document.querySelectorAll("label input");

// 	if(str == 'basic'){
// 		label[2].innerHTML = "Rp 50k Monthly";
// 		value[2].setAttribute("value", "basicMonthly");
// 		label[3].innerHTML = "Rp 550k Annually";
// 		value[3].setAttribute("value", "basicAnnually");
// 	} else{
// 		label[2].innerHTML = "Rp 100k Monthly";
// 		value[2].setAttribute("value", "primaryMonthly");
// 		label[3].innerHTML = "Rp 1000k Annually";
// 		value[3].setAttribute("value", "primaryAnnually");
// 	}
// }

// function proceed(x){
// 	x.
// }