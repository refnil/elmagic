defmodule MtgParser do
  import ExParsec.Helpers
  import ExParsec.Base
  import ExParsec.Text

  defmparser mana_symbol do
    between(char("{"), one_of("WURBG"), char("}"))
  end

  defmparser target do
    zero
  end

  defmparser caracteristic do
    zero
  end

  defmparser object do
    zero
  end

  defmparser int do
    zero
  end

  defmparser mana_cost do
    zero
  end
end
