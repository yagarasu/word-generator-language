ws "white space"              = [ \t\n\r]*;
sted "statement end"          = ";";
ident "identifier"            = id:[a-zA-Z0-9]+
{
  return {
    type: 'ident',
    value: id.join('')
  };
};
literal "literal"             = "\"" str:[^\"]* "\""
{
  return {
    type: 'literal',
    value: str.join('')
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
  return {
    type: 'list',
    id: id.value,
    list: list
  }
};
defSeq "sequence definition"  = "define seq" ws id:ident ws ":" ws list:list ws sted
{
  return {
    type: 'seq',
    id: id.value,
    list: list
  }
};

rule "rule"                   = defList / defSeq

output "output"               = "output" ws id:ident ws sted
{
  return id.value;
};

spec "specification"          = rules:(rule ws)* out:output
{
  var r = [];
  for (var i = 0; i < rules.length; i++) {
    r.push(rules[i][0]);
  }
  return { rules: r, output: out };
};
