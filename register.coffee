config = require './config.coffee'
ssmtp  = require 'simplesmtp'
MailComposer = require('mailcomposer').MailComposer

exports.initSmtp = (cfg) ->
  @smtpPool = ssmtp.createClientPool cfg.port, cfg.host,
    auth:
      user: cfg.username
      pass: cfg.password

exports.newUser = (req, res) ->
  # TODO: generate token, store DB, send e-mail
  cmp = new MailComposer
  cmp.setMessageOption
    from: 'registration@frwrld.com'
    to: req.body.email
    subject: 'frwrld registration'
    body: 'sorry frwrld is not ready yet'

  # @smtpPool.sendMail cmp, (err, resp) ->
  #   if err
  #     res.send 'failed', 'Content-Type': 'text/plain', 403
  #   else
  #     res.send 'ok', 'Content-Type': 'text/plain', 200

# vim:ts=2 sw=2:
