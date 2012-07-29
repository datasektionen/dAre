$(document).ready(function() {
	$('#new_post_link').click(function(){
		$('#new_post_block').slideToggle();
		e.preventDefault();
	});

	$('#new_post').bind('ajax:success', function() {
		$('#posts').prepend('<%= escape_javascript(render(@post)) %>');
		$('#posts > li').first().effect('highlight', {color: 'cyan', mode: 'show'}, 2000);
		$('#new_post > form')[0].reset();
	});

	$('#new_post').bind('ajax:error', function() {
		$('#<%= dom_id(@post) %>').effect('highlight', {color: 'green', mode: 'hide'}, 1200);
	});
});