$(document).ready ->
  # ==========================================================================
  #     forms
  #     ==========================================================================
	# sel = $( "#user_role" ).val()
	# $('#user_role').change(->
	# 	console.log($( "#user_role" ).val())
	# 	if sel == 2
	# 		console.log('222')
	# 	if sel == 2
	# 		console.log('333')
	# ).change()
	$('#user_role').on 'change', ->
	  if $(this).val() == 'customer'
	    $('.role-customer').show()
	    $('.avatar').show()
	    $('.role-admin').hide()
	    console.log($(this).val())
	    console.log('222')
	  else if $(this).val() == 'admin'
	    $('.role-admin').show()
	    $('.avatar').show()
	    $('.role-customer').hide()
	    console.log($(this).val())
	    console.log('333')
	  else
	    $('.avatar').hide()
	    $('.role-admin').hide()
	    $('.role-customer').hide()
	    console.log($(this).val())
	    console.log('111')
