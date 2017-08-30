var parser = require('./wglParser');

var rules = `define list V [ "a", "e", "i", "o", "u", "y" ];
define list C [ "b", "p", "t", "d", "k", "g", "m", "mm", "n", "r", "l", "s",
"sh", "th", "gh" ];
define list E [ "eth" , "el" , "eus", "os" ];

define seq Simple: C, V;
define seq Doub: Simple, Simple;
define seq Tri: Simple, Doub;

define list Word [ Tri, Tri, Tri, Simple, Doub ];

define seq Name: Word, E;

output Name;`;

var r;
for (var i = 0; i < 20; i++) {
  r = parser.parse(rules);
  console.log('\t- ' + r);
}
