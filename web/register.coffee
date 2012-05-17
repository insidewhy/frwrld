# TODO: check if logged in
$(document).ready () ->

registered = (msg) ->
  # TODO: indicate to user

failed = (xhr, text) ->
  msg = xhr.responseText
  # TODO: raise error on form

frwrld.register = () ->
  $form = $('#register form')
  $.post(
    '/register',
    email: $form.find('[name=email]').val(),
    password: $form.find('[name=password]').val())
    .done(registered).error(failed)
  false

# vim:ts=2 sw=2:
