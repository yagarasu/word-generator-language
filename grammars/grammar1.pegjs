ws "white space"              = [ \t\n\r]*;
sted "statement end"          = ";";
ident "identifier"            = id:[a-zA-Z0-9]+;
literal "literal"             = "\"" str:[^\"]* "\"";

option "list option"          = literal
                              / ident;

list "list"                   = head:option rest:(ws "," ws option)*;

defList "list definition"     = "define list" ws ident ws "[" ws list ws "]" ws sted;
defSeq "sequence definition"  = "define seq" ws ident ws ":" ws list ws sted;

rule "rule"                   = defList / defSeq

output "output"               = "output" ws ident ws sted;

spec "specification"          = rules:(rule ws)* out:output;
