_ = require 'underscore'

_.extend exports,
  db: process.env.DB || "mongodb://localhost/frwrld"
  smtp: process.env.SMTP || 'smtp://localhost'
  port: process.env.PORT || 3000
  host: process.env.HOST || "localhost:3000"
  import: (args) ->
    @port = args.port if args.port
    @db = args.db if args.db
    @host = args.host if args.host
    @smtp = args.smtp if args.smtp
  expand: ->
    mailReg = /^smtp:\/\/(?:([^:@]+)(?::([^@]+))?@)?([\w\.]+)(?::(\d+))?/
    match = mailReg.exec @smtp
    if match
      @smtp = {}
      @smtp.username = match[1] if match[1]
      @smtp.password = match[2] if match[2]
      @smtp.host = match[3]
      @smtp.port = match[4] if match[4]
    else
      console.warn "invalid smtp string: #{@smtp}, setting to localhost"
      @smtp = { host: 'localhost' }
    console.log "smtp:", @smtp

    # process mail

# vim:ts=2 sw=2:
