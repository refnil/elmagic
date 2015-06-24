Definitions.

PUNCTUATION = [.,{}()/]
LETTER = [a-zA-Z]
WORD = [a-zA-Z']{2,}
INT  = [0-9]+
SPACE = \w+ 

Rules.
{INT} : {token, {int, TokenLine, to_int(TokenChars)}}.
{PUNCTUATION} : {token,{to_atom(TokenChars), TokenLine}}.
{LETTER} : {token,{to_atom(TokenChars),TokenLine}}.
{WORD}  : {token,{TokenChars,TokenLine}}.
{SPACE} : skip_token.

Erlang code.
to_atom(Chars) -> list_to_atom(Chars).
to_int(Chars) -> list_to_integer(Chars).
