@show_alert = (style_class, message) ->
  $('#custom_alert').removeClass 'alert-danger'
  $('#custom_alert').removeClass 'alert-success'

  $('html, body').animate { scrollTop: 0 }, 'slow'
  $('#custom_alert').alert()
  $('#custom_alert').addClass style_class
  $('#message').html message
  $('#custom_alert').fadeTo(2000, 500).slideUp 500, ->
    $('#custom_alert').hide()
