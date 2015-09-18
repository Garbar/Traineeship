$(document).ready ->
  # ==========================================================================
  #     forms
  #     ==========================================================================
	$('#user_role').on 'change', ->
	  if $(this).val() == 'customer'
	    $('.role-customer').show()
	    $('.avatar').show()
	    $('.role-admin').hide()
	    $( "div.demo-container" )
	  else if $(this).val() == 'admin'
	    $('.role-admin').show()
	    $('.avatar').show()
	    $('.role-customer').hide()
	  else
	    $('.avatar').hide()
	    $('.role-admin').hide()
	    $('.role-customer').hide()
