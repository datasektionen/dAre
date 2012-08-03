$(document).ready(function() {
	$('#new_post_link').click(function(){
		$('#new_post_block').slideToggle();
		e.preventDefault();
	});

	var toggleLoading = function() {  };

	$('#new_post')
    .bind('ajax:loading',  toggleLoading)
    .bind('ajax:complete', toggleLoading)
    .bind('ajax:success', function(status, data, xhr) {
		$('#posts').prepend(data);
		$('#posts > li').first().effect('highlight', {color: 'cyan', mode: 'show'}, 2000);
		$('#new_post').each(function(){
            this.reset();
        });
        $('#new_post_block').slideToggle();
    })
    .bind('ajax:error', function(xhr, status, error) {
    	alert(status.responseText);
     	alert(error);
    });

    $('.btn, .btn-danger').bind('ajax:error', function(status, data, xhr) {
    	$(this).parent('.post').effect('highlight', {color: 'green', mode: 'hide'}, 1200);
    });
});