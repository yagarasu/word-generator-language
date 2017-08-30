var parser = require('./wglParser');

var script = '';

process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('error', function (err) {
  if (err.code === 'EPIPE') return process.exit(1);
  process.emit('error', err);
});
process.stdin.on('data', function (chunk) {
  script += chunk;
});
process.stdin.on('end', function () {
  // Process
  script = script.trim();
  console.log('Script:\n' + script + '\n\nOutputs:');
  var r;
  for (var i = 0; i < 10; i++) {
    r = parser.parse(script);
    console.log('\t- ' + r);
  }
  process.exit(0);
});
