# TODO: check if logged in
$(document).ready () ->

registered = (msg) ->
  $(
    '<div/>',
    class: 'registered',
    text: 'Thanks for registering, please check your e-mail.'
  ).appendTo($('#register .content').html(''))

failed = (xhr, text) ->
  msg = xhr.responseText
  # TODO: better error display
  switch msg
    when "duplicate"
      alert "Accoult already exists."
    when "db", "mail"
      alert "Server failure please try later."
    else
      alert "Unknown error, please try later."

frwrld.register = () ->
  $form = $('#register form')
  passHash = CryptoJS.SHA1($form.find('[name=password]').val()).toString()
  $.post(
    '/register',
    email: $form.find('[name=email]').val(),
    password: passHash)
    .done(registered).error(failed)
  false

frwrld.registerEmailCredentials = () ->
  toFade$ = $("#ui >div, #toolbox >div").not '#toolbox,#user'
  toFade$.animate opacity: 0.3

  $('#register .header').text 'Login'

  form = $('#register form')
  form.find('input[name=email]').val frwrld.get.email
  form.find('input[type=submit]').val 'Login'

  pass = form.find('input[name=password]')
    .attr('placeholder', 'Enter your password')
    .focus()

  tooltip = new frwrld.Tooltip pass,
    "Please enter your password to confirm registration."

  # TODO: capture login then remove registration toolbox

# vim:ts=2 sw=2:
