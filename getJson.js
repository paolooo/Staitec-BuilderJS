var https = require("https");

var options = {
  host: 'graph.facebook.com',
  port: 443,
  path: '/517267866/?fields=picture',
  method: 'GET'
};
options.agent = new https.Agent(options);

var req = https.request(options, function(res) {
  console.log('STATUS: ' + res.statusCode);
  console.log('HEADERS: ' + JSON.stringify(res.headers));
  res.setEncoding('utf8');
  res.on('data', function (chunk) {
    console.log('BODY: ' + chunk);
  });
});

req.on('error', function(e) {
  console.log('problem with request: ' + e.message);
});

// write data to request body
req.write('data\n');
req.write('data\n');
req.end();
