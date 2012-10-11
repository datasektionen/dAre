$(document).ready(function() {
	$('#filter_payed_registration').click(function() {
		var checked = $(this).attr('checked');

		var filter;
		if(checked) {
			filter = 'registration';
		}
		else {
			filter = 'f';
		}

		$.ajax( {
			type: 'GET',
			url: '/projects/1/registrations/?filter_fee=' + filter,
			dataType: 'json',
			error: function(jqXHR, textStatus, errorThrown) {
				alert('error... ' + errorThrown);
			},
			success: function(data, textStatus, jqXHR) {
				alert(data);
			}
		});

		return false;
	})  
});