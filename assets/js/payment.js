$(document).ready(function(){
	loadBankDetail();

	$('#formClass').submit(function(){
		var param;

		param = {
			paymentStatus : $('input[name="paymentType"]:checked').val(),
			paymentPlan : $('input[name="paymentDuration"]:checked').val(),
			paymentMethod : $('input[name="paymentMethod"]:checked').val()

		}

		if($('input[name="paymentMethod"]:checked').val() == 'TransferBank'){
			param.BankID = $('#selectBank').val();
			param.AccountNum = $('input[name="AccountNum"]').val();
			param.AccountName = $('input[name="AccountName"]').val();
		}
		else{
			param.cardNum = $('input[name="CardNum"]').val();
			param.cardName = $('input[name="CardName"]').val();
			param.cardExpDate = $('input[name="CardExp"]').val();
		}

		$.ajax({
			url :'payment/payment/doPayment',
			dataType : 'json',
			type : 'POST',
			data : param,
			complete : function(data){
				console.log(data);
				window.location.href = 'Success';
			},
			async : false
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
		$('input[name="AccountNum"]').attr('required',true);
		$('input[name="AccountName"]').attr('required',true);
		$('input[name="CardNum"]').attr('required',false);
		$('input[name="CardName"]').attr('required',false);
		$('input[name="CardExp"]').attr('required',false);
		$('.creditCard').hide();
	} else{
		$('.creditCard').show();
		$('input[name="AccountNum"]').attr('required',false);
		$('input[name="AccountName"]').attr('required',false);
		$('input[name="CardNum"]').attr('required',true);
		$('input[name="CardName"]').attr('required',true);
		$('input[name="CardExp"]').attr('required',true);
		$('.transferBank').hide();
	}
}