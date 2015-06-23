Terminals word ',' '.' enter.
Nonterminals list sentence elem.
Rootsymbol list.

list -> list sentence : '$1' ++ ['$2'].
list -> sentence : ['$1'].
sentence -> elem sentence : '$1' ++ '$2'.
sentence -> '.' : ".".
elem -> word : extract_token('$1').
elem -> ',' : ",".

Erlang code.
extract_token({_Token, _Line, Value}) -> Value.
