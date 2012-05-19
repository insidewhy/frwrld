express  = require 'express'
mongoose = require 'mongoose'
app      = express.createServer express.logger()
register = require './register.coffee'
config   = require './config.coffee'

app.configure () ->
  app.set 'views', __dirname + '/view'
  app.set 'view options', layout: false
  app.set 'view engine', 'jade'
  app.use express.cookieParser()
  app.use express.static(__dirname + '/static')
  app.use express.bodyParser()
  app.use app.router

try
  local = require './local.coffee'
  config.import local
catch e
  console.log e

if ! config.db
  console.error 'no database connection defined'
  process.exit 1

dbConn = mongoose.createConnection config.db
dbConn.on 'open', () -> console.log 'database connected'

app.listen config.port, () -> console.log 'Listening on ' + config.port

app.get '/', (req, res) -> res.render 'index'

app.post '/register', (req, res) -> register.newUser(req, res)

# vim:ts=2 sw=2:
