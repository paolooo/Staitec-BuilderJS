(function() {
  var app, connect, http;

  connect = require('connect');

  http = require('http');

  app = connect().use(connect.favicon()).use(connect.logger()).use(connect["static"](__dirname + '/public')).use(connect.directory(__dirname + '/public')).use(connect.cookieParser()).use(connect.session({
    secret: 'playerfm@20130510@'
  })).use(function(req, res) {
    return res.end("<h1>404 Not Found</h1>\n");
  });

  http.createServer(app).listen(3000);

}).call(this);
