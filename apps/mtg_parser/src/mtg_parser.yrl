Terminals '{' '}' 'X' 'S' 'P' int 'W' 'U' 'B' 'R' 'G' '/'.
Nonterminals color symbol cost.
Rootsymbol cost.

activatedAbility -> cost ':' effect : [{cost, '$1'},{effect, '$3'}].

cost -> cost cost : '$1' ++ '$2'.
cost -> symbol : ['$1'].

symbol -> '{' color '}' : ['$2'].
symbol -> '{' 'X' '}' : [x].
symbol -> '{' 'S' '}' : [s].
symbol -> '{' 'P' '}' : [p].
symbol -> '{' int '}' : [value_as_int('$2')].
symbol -> '{' color '/' color '}' : ['$2','$4'].
symbol -> '{' int '/' color '}' : [value_as_int('$2'),'$4'].
symbol -> '{' color '/' 'P' '}' : ['$2',p].

color -> 'W' : w.
color -> 'U' : u.
color -> 'B' : b.
color -> 'R' : r.
color -> 'G' : g.

keyword -> "flying" : flying.
keyword -> "haste" : haste.
keyword -> "deathtouch" : deathtouch.
keyword -> "defender" : defender.
keyword -> "double" "strike" : doubleStrike.
keyword -> "equip" cost : {equip, '$2'}.
keyword -> "enchant" : {enchant}.

Erlang code.
value_as_int({Token,Line,Value}) -> Value.
