#!/usr/bin/env node

var q = require('q'),
    exec = require('child_process').exec;

function run(cmd) {
  var defer = q.defer(),
      child;

  child = exec(cmd, function(error, stdout, stderr) {
    if (error) {
      defer.reject(error);
    } else {
      defer.resolve(stdout);
    }
  });
  child.on('data', function(data) {
    process.stdout.write(data);
  });
  child.stdout.pipe(process.stdout);
  child.stderr.pipe(process.stderr);

  return defer.promise;
};

run('bower install')
  .then(function(msg){
    run('grunt build');
  }, function(error) {
    console.log(error);
    process.exit(1);
  });
