var express  = require('express'),
    mongoose = require('mongoose'),
    app      = express.createServer(express.logger()),
    register = require('./register.js'),
    port, db, smtp // config

app.configure(function() {
  app.set('views', __dirname + '/view')
  app.set('view options', { layout: false })
  app.set('view engine', 'jade')
  app.use(express.cookieParser())
  app.use(express.static(__dirname + '/static'))
  app.use(express.bodyParser())
  app.use(app.router)
})

try {
    var ctxt = require('./local.js')
    port = ctxt.port
    db = ctxt.db
    smtp = ctxt.smtp
} catch (e) {}

port = port || process.env.PORT || 3000
db = db || process.env.DB
smtp = smtp || process.env.SMTP

if (! db) {
  console.error('no database connection defined')
  process.exit(1)
}

var dbConn = mongoose.createConnection(db)
dbConn.on('open', function() {
  console.log('database connected')
})

app.listen(port, function() {
  console.log('Listening on ' + port)
})

app.get('/', function(req, res) {
  res.render('index')
})

app.post('/register', function(req, res) {
  register.newUser(req, res)
})

// vim:ts=2 sw=2:
