defmodule MtgParser do
  import ExParsec.Helpers
  import ExParsec.Base
  import ExParsec.Text

  defmparser mana_symbol do
    between_braces(one_of("WURBGSTQCP"))
  end

  defmparser mana_colorless do
    between_braces(either(char("X"),int))
  end

  defmparser between_braces(parser) do
    between(char("{"),parser, char("}"))
  end

  defmparser int do
    either(
      both(one_of("123456789"),many(digit()),&(Enum.join(List.insert_at(&2,0,&1),""))),
      digit())
  end

  defmparser mana_dual do
    pair_both(
      between(char("{"),one_of("WURBG"),char("/")),
      pair_left(one_of("WURGB"),char("}"))
      ) 
  end
end
