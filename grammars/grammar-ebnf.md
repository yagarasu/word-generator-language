# Grammar (Extended Backus-Naur Form)

```
ws        = ? White space characters ?
sted      = ";" ;
ident     = ? Regex: /\w+/ ? ;
literal   = ? Regex: /\”[^\”]*\”/ ? ;

option    = literal
          | ident ;
list      = option , { ",", option } ;

defList   = "define list", ident, "[", list, "]", sted;
defSeq    = "define seq", ident, ":", list, sted;

rule      = defList
          | defSeq ;

output    = "output", ws, ident, sted ;

spec      = { rule, ws }, output ;
```
