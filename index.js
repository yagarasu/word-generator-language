var parser = require('./wglParser');

var rules = `define list V [ "a", "e", "i", "o", "u" ];
define list C [ "b", "p", "t", "d", "k",
"g", "m", "n", "r", "l", "s" ];

define seq Voc: V;
define seq Simple: C, V;
define seq Doub: Simple, Simple;

define list Word [ Voc, Simple, Doub ];

output Word;`;

console.log(rules);

var list = [];

var r;
for (var i = 0; i < 10; i++) {
  r = parser.parse(rules);
  list.push(r);
}

console.log(list);
