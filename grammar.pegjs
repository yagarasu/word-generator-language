{
  var _rules = {};

  var _literal = function (value) { return function () {
    return value;
  }}
  var _ident = function (id) { return function () {
    if (!_rules[id]) throw new Error('Identifier not set.');
    return _rules[id]();
  }}
  var _list = function (list) { return function () {
    var ridx = Math.round(Math.random() * (list.length - 1));
    return list[ridx].eval();
  }}
  var _seq = function (list) { return function () {
    var res = '';
    for (var i = 0; i < list.length; i++) {
      res += list[i].eval();
    }
    return res;
  }}
}

ws "white space"              = [ \t\n\r]*;
sted "statement end"          = ";";
ident "identifier"            = id:[a-zA-Z0-9]+
{
  return {
    type: 'ident',
    value: id.join(''),
    eval: _ident(id.join(''))
  };
};
literal "literal"             = "\"" str:[^\"]* "\""
{
  return {
    type: 'literal',
    value: str.join(''),
    eval: _literal(str.join(''))
  };
};

option "list option"          = literal
                              / ident;

list "list"                   = head:option rest:(ws "," ws option)*
{
  var res = [head];
  for (var i = 0; i < rest.length; i++) {
    res.push(rest[i][3]);
  }
  return res;
};

defList "list definition"     = "define list" ws id:ident ws "[" ws list:list ws "]" ws sted
{
  _rules[id.value] = _list(list);
  return {
    type: 'list',
    id: id.value,
    list: list
  }
};
defSeq "sequence definition"  = "define seq" ws id:ident ws ":" ws list:list ws sted
{
  _rules[id.value] = _seq(list);
  return {
    type: 'seq',
    id: id.value,
    list: list
  }
};

rule "rule"                   = defList / defSeq

output "output"               = "output" ws id:ident ws sted
{
  return id.eval();
};

spec "specification"          = rules:(rule ws)* out:output
{
  return out;
};
