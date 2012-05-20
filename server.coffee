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

if ! config.db
  console.error 'no database connection defined'
  process.exit 1

config.expand()

register.initSmtp config.smtp

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
# trigger registration e-mail
app.post '/register', (req, res) -> register.newUser(req, res)
# user following registration e-mail
app.get '/register', (req, res) -> res.render 'index'

# vim:ts=2 sw=2:
