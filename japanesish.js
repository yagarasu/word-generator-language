var parser = require('./wglParser');

var rules = `define list V [ "a", "i", "u", "e", "o" ];
define list W [ "ei", "ou" ];
define list C [ "b", "p", "pp", "t", "tt", "d", "k", "kk", "g", "m", "n", "r", "s", "z" ];

define seq Single: V;
define seq Simple: C, V;
define seq Simple2: C, W;
define seq SimpleN: C, V, "n";

define list Syl [ Single, Simple, Simple2, SimpleN ];

define seq Ichi: Syl;
define seq Ni: Syl, Syl;
define seq San: Syl, Syl, Syl;

define list Word [ Ichi, Ni, San ];

output Word;`;

var r;
for (var i = 0; i < 20; i++) {
  r = parser.parse(rules);
  console.log('\t- ' + r);
}
