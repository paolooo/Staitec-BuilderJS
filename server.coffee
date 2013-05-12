connect = require 'connect'
http = require 'http'
https = require 'https'
url = require 'url'

app = connect()
  .use(connect.favicon())
  .use(connect.logger())
  .use(connect.static(__dirname + '/public'))
  .use(connect.directory(__dirname + '/public'))
  .use(connect.cookieParser())
  .use(connect.session(
    secret: 'nodejspaolo'
  ))
  .use (req, res) ->
    console.log req

    if req._parsedUrl.pathname is "/js/getJson.js"
      _url = url.parse req._parsedUrl.query
      console.log _url
      options =
        host: _url.host
        port: 443
        path: _url.path
        method: 'GET'

      options.agent = new https.Agent options

      req = https.request options, (response) ->
        #console.log 'STATUS: ' + response.statusCode
        #console.log 'HEADERS: ' + JSON.stringify response.headers
        response.setEncoding 'utf8'
        response.on 'data', (data) ->
          #console.log 'BODY: ' + chunk
          res.end data

      req.on 'error', (e) ->
        console.log 'problem with request: ' + e.message

      req.end()
    else
      return res.end "<h1>404 Not Found</h1>\n"

http.createServer(app).listen(3000)
