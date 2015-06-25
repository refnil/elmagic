defmodule MtgParser do
  import ExParsec.Helpers
  import ExParsec.Base
  import ExParsec.Text

  defmparser mana_symbol do
    between(char("{"), one_of("WURBG"), char("}"))
  end

end
