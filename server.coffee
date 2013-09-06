'use strict'

connect = require 'connect'
http = require 'http'
https = require 'https'
url = require 'url'

pkg = require __dirname + '/package.json'

app = connect()
  .use(connect.favicon())
  .use(connect.logger())
  .use(connect.static __dirname + '/' + pkg.config.path.dest)
  .use(connect.directory __dirname + '/' + pkg.config.path.dest)
  .use(connect.cookieParser())
  .use(connect.session(
    secret: 'nodejspaolo'
  ))
  .use (req, res) ->
    req.end()

http.createServer(app).listen pkg.config.server.port
