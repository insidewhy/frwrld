_ = require 'underscore'

_.extend exports,
  db: process.env.DB || "mongodb://localhost/frwrld"
  smtp:
    host: process.env.SMTP || 'localhost'
    port: 25
  port: process.env.PORT || 3000
  host: process.env.HOST || "localhost:3000"
  import: (args) ->
    @port = args.port if args.port
    @db = args.db if args.db
    @host = args.host if args.host
    if args.smtp
      mailReg = /smtp:\/\/(?:([^:@]+)(?::([^@]+))?@)?([\w\.]+)(?::(\d+))?/
      match = mailReg.exec args.smtp
      if match
        @smtp.username = match[1] if match[1]
        @smtp.password = match[2] if match[2]
        @smtp.host = match[3]
        @smtp.port = match[4] if match[4]
        console.log "smtp:", @smtp
      else
        console.warn "invalid smtp string: #{args.smtp}"
    # process mail

# vim:ts=2 sw=2:
