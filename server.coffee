express  = require 'express'
mongoose = require 'mongoose'
app      = express.createServer express.logger()
register = require './register.coffee'
port = db = smtp = null # config

app.configure () ->
  app.set 'views', __dirname + '/view'
  app.set 'view options', layout: false
  app.set 'view engine', 'jade'
  app.use express.cookieParser()
  app.use express.static(__dirname + '/static')
  app.use express.bodyParser()
  app.use app.router

try
  ctxt = require './local.coffee'
  port = ctxt.port
  db = ctxt.db
  smtp = ctxt.smtp
catch e
  "nothing"

port = port || process.env.PORT || 3000
db = db || process.env.DB
smtp = smtp || process.env.SMTP

if ! db
  console.error 'no database connection defined'
  process.exit 1

dbConn = mongoose.createConnection db
dbConn.on 'open', () -> console.log 'database connected'

app.listen port, () -> console.log('Listening on ' + port)

app.get '/', (req, res) -> res.render 'index'

app.post '/register', (req, res) -> register.newUser(req, res)

# vim:ts=2 sw=2:
