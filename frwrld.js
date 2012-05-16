var express = require('express'),
    app     = express.createServer(express.logger())

app.configure(function() {
  app.set('views', __dirname + '/view')
  app.set('view options', { layout: false })
  app.set('view engine', 'jade')
  app.use(express.cookieParser())
  app.use(express.static(__dirname + '/static'))
  app.use(express.bodyParser())
  app.use(app.router)
})

var port = process.env.PORT || 3000
app.listen(port, function() {
  console.log("Listening on " + port)
})

app.get('/', function(req, res) {
  res.render('index')
})

// vim:ts=2 sw=2: