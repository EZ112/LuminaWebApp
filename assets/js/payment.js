$(document).ready(function(){
	loadBankDetail();

	$('#formClass').submit(function(){
		var param;
		if($('input[name="paymentType"]:checked').val() == 'Basic'){
			param = {
				paymentStatus : $('input[name="paymentType"]:checked').val(),
				paymentPlan : $('input[name="paymentDuration"]:checked').val(),
				bankID : $('#selectBank').val(),
				accountNum : $('input[name="AccountName"]').val()
			}
		}
		else{
			param = {
				paymentStatus : $('input[name="paymentType"]:checked').val(),
				paymentPlan : $('input[name="paymentDuration"]:checked').val(),
				bankID : $('#selectBank').val(),
				accountNum : $('input[name="AccountName"]').val()
			}
		}

		

		$.ajax({
			url :'payment/payment/getBankDetail',
			dataType : 'json',
			type : 'POST',
			success : function(data){
			}
		});
	});


});

function changePaymentPlan(str){
	var label = document.getElementsByClassName("label");
	var value = document.querySelectorAll("label input");

	if(str == 'basic'){
		label[2].innerHTML = "Rp 50k Monthly";
		value[2].setAttribute("value", "Monthly");
		label[3].innerHTML = "Rp 550k Annually";
		value[3].setAttribute("value", "Annually");
	} else{
		label[2].innerHTML = "Rp 100k Monthly";
		value[2].setAttribute("value", "Monthly");
		label[3].innerHTML = "Rp 1000k Annually";
		value[3].setAttribute("value", "Annually");
	}
}

function loadBankDetail(){
	$.ajax({
		url :'payment/payment/getBankDetail',
		dataType : 'json',
		type : 'POST',
		success : function(data){
			var container = $('#selectBank');
			$.each(data,function(key,val){
				container.append(`<option value="`+val.BankID+`">`+val.BankName
+`</option>`);
			});
		}
	});
}

function changePaymentMet(str){
	if(str == 'Transfer'){
		$('.transferBank').show();
		$('.creditCard').hide();
	} else{
		$('.creditCard').show();
		$('.transferBank').hide();
	}
}