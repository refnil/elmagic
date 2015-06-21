Definitions.

WORD = [a-zA-Z']+
COMMA = ,
DOT = \.
INT  = [0-9]+
SPACE = [\s\t]+
ENTER = [\n\r]+

Rules.
{COMMA} : {token,{',', TokenLine}}.
{DOT} : {token,{'.', TokenLine}}.
{WORD}  : {token,{word,TokenLine,TokenChars}}.
{ENTER} : skip_token.
{ENTER} : {token,{enter,TokenLine}}.
{SPACE} : skip_token.

Erlang code.


