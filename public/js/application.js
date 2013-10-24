$(document).ready(function() {
	$('#new_button').click(function(event){
		event.preventDefault();
		$(this).hide();

		$.get('/newevent_from_button', function(form){
			$('.container').append(form);
		});
	});

	$('.container').on('submit', '#neweventform', function(event){
		event.preventDefault();
		// alert("form submit");
		var url = $(this).attr('action');
		var data = $(this).serialize();
	$.post(url, data, function(){
		$('tr').append(response);
	});	
	$('h1').remove();
	$(this).remove();
	$('#new_button').show();
});
});