config = require './config.coffee'
require './schema/user.coffee'

ssmtp  = require 'simplesmtp'
mongoose  = require 'mongoose'
MailComposer = require('mailcomposer').MailComposer

userModel = mongoose.model('user')

exports.initSmtp = (cfg) ->
  @smtpPool = ssmtp.createClientPool cfg.port, cfg.host,
    auth:
      user: cfg.username
      pass: cfg.password

randomToken = () ->
  toks = new Array
  toks.length = 20
  for idx in [0...toks.length]
    toks[idx] = String.fromCharCode(
      Math.floor(Math.random() * (122 - 97 + 1)) + 97)
  toks.join ''

exports.newUser = (req, res) ->
  fail = (msg) ->
    res.send msg, 'Content-Type': 'text/plain', 403

  user = new userModel
  user.handle = user.email = req.body.email
  # URGENT: hash this
  user.password = req.body.password
  user.token = randomToken()

  user.save (err) =>
    if err
      console.log "Failed to save user #{err}"
      if err.code is 11000
        fail 'duplicate'
      else
        fail 'db'
      return

    console.log "Saved user"

    cmp = new MailComposer
    cmp.setMessageOption
      from: 'registration@frwrld.com'
      to: req.body.email
      subject: 'frwrld registration'
      body: "Please go to
             http://#{config.host}/register/?email=#{req.body.email}&code=#{user.token}
             to complete registration"

    @smtpPool.sendMail cmp, (err, resp) ->
      if err
        console.log 'error sending mail:', err
        fail 'mail'
      else
        res.send 'ok', 'Content-Type': 'text/plain', 200

# vim:ts=2 sw=2:
