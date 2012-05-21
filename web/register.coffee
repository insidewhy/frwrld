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
  $.post('/register',email: $form.find('[name=email]').val())
    .done(registered)
    .error(failed)
  false

frwrld.registerEmailCredentials = () ->
  toFade$ = $("#ui >div, #toolbox >div").not '#toolbox,#user'
  toFade$.animate opacity: 0.3

  $('#register .header').text 'Login'

  form = $('#register form')
  emailInput = form.find('input[name=email]')
    .val(frwrld.get.email)
    .attr('readonly', true)
  form.find('input[type=submit]').val 'Login'

  pass = $('<input/>', { type: 'password', name: 'password' })
    .attr('placeholder', 'Choose a password')
    .insertAfter(emailInput)
    .focus()

  tooltip = new frwrld.Tooltip pass,
    "Please choose a password to confirm registration."

  # passHash = CryptoJS.SHA1($form.find('[name=password]').val()).toString()
  # TODO: capture login then remove registration toolbox

# vim:ts=2 sw=2:
