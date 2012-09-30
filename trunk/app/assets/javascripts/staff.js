$(document).ready(function() {
	//$('#new_staff_member_link').click(function(){
	//	event.preventDefault();
	//});
$('#modal-window').modal('show')   ;
$('.modal-body').html('<%= escape_javascript(render :partial => "new", :object => @staff) %>');

});