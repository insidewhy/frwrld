mailer = require 'mailer'

exports.newUser = (req, res) ->
  # mailer.send(
  # TODO: mail user
  res.send 'ok', 'Content-Type': 'text/plain', 200

# vim:ts=2 sw=2:
