(function() {
  var app, connect, http, https, url;

  connect = require('connect');

  http = require('http');

  https = require('https');

  url = require('url');

  app = connect().use(connect.favicon()).use(connect.logger()).use(connect["static"](__dirname + '/public')).use(connect.directory(__dirname + '/public')).use(connect.cookieParser()).use(connect.session({
    secret: 'nodejspaolo'
  })).use(function(req, res) {
    var options, _url;

    console.log(req);
    if (req._parsedUrl.pathname === "/js/getJson.js") {
      _url = url.parse(req._parsedUrl.query);
      console.log(_url);
      options = {
        host: _url.host,
        port: 443,
        path: _url.path,
        method: 'GET'
      };
      options.agent = new https.Agent(options);
      req = https.request(options, function(response) {
        response.setEncoding('utf8');
        return response.on('data', function(data) {
          return res.end(data);
        });
      });
      req.on('error', function(e) {
        return console.log('problem with request: ' + e.message);
      });
      return req.end();
    } else {
      return res.end("<h1>404 Not Found</h1>\n");
    }
  });

  http.createServer(app).listen(3000);

}).call(this);
