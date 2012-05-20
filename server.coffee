express  = require 'express'
mongoose = require 'mongoose'
app      = express.createServer express.logger()
register = require './register.coffee'
config   = require './config.coffee'

##############################################################################
# config
try
  local = require './local.coffee'
  config.import local
catch e
  console.log e

register.initSmtp config.smtp

if ! config.db
  console.error 'no database connection defined'
  process.exit 1

config.expand()

##############################################################################
# setup
# dbConn = mongoose.createConnection config.db
# dbConn.on 'open', () -> console.log "database connected: #{config.db}"
mongoose.connect config.db
mongoose.connection.on 'open', () -> console.log "database connected: #{config.db}"

app.configure () ->
  app.set 'views', __dirname + '/view'
  app.set 'view options', layout: false
  app.set 'view engine', 'jade'
  app.use express.cookieParser()
  app.use express.static(__dirname + '/static')
  app.use express.bodyParser()
  app.use app.router

app.listen config.port, () -> console.log 'Listening on ' + config.port

##############################################################################
# routing
app.get '/', (req, res) -> res.render 'index'

app.post '/register', (req, res) -> register.newUser(req, res)

# vim:ts=2 sw=2:
