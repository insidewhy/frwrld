_ = require 'underscore'

_.extend exports,
  db: "",
  smtp: process.env.SMTP || 'smtp://localhost',
  port: process.env.PORT || 3000,
  import: (args) =>
    @port = args.port if args.port
    @db = args.db if args.db
    @smtp = args.smtp if args.smtp
