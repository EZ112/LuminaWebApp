function checkLogin(form){
	var InStaffName = form.querySelector("input[type='text']").value;
	var InStaffPass = form.querySelector("input[type='password']").value;

	var param = {
		staffName : InStaffName,
		staffPass : InStaffPass
	}

	var x = $(form).find('input[type="password"]')[0];

	$.ajax({
		url :'backendLogin/loginStaff',
		dataType : 'json',
		type : 'POST',
		data : param,
		success : function(data){
			console.log(data);
			if(data[0].Status != 0)
				x.setCustomValidity('Username already been taken');
			else
				x.setCustomValidity('');
		},
		async : false
	});

	return false;
}