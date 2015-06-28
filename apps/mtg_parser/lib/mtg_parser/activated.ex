defmodule MtgParser.Activated do
  import ExParsec.Helpers
  import ExParsec.Text

  import MtgParser.Cost
  import MtgParser.Effect

  defmparser activated do
    c <- cost
    char(":")
    space
    e <- effect
    return {c,e}
  end
end
