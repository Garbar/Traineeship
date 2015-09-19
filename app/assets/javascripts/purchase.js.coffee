$(document).ready ->
	$(".purchase-link")
		.on "ajax:success", (evt, data, status, xhr) ->
	    	# console.log(data)
	    	$('#add_success .modal-title').html(data.title)
	    	$('#text_message').html(data.mess)
	    	$('#add_success').modal({show:true})
		    # setTimeout (->
		    # 	$('#add_success').modal 'hide'
		    #  ), 3000


