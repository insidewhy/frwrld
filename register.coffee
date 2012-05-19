mailer = require 'mailer'
config = require './config.coffee'

exports.newUser = (req, res) ->
  # mailer.send(
  # TODO: mail user
  opts =
    host: config.smtp.host
    port: config.smtp.port
    ssl: true
    domain: 'localhost'
    to: req.body.email
    from: 'registration@frwrld.com'
    subject: 'frwrld registration'
    body: 'still testing sorry'
    authentication: 'plain'
    username: config.smtp.username
    password: config.smtp.password

  mailer.send opts, (err, res) ->
    console.log err, res

  res.send 'ok', 'Content-Type': 'text/plain', 200

# vim:ts=2 sw=2:
