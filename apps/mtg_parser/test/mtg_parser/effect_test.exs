defmodule MtgParser.Effect.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Effect

  # Don't forget to add the ending dot for the tests.
  parse_list "Effect", effect do
    [
      {"tap target creature.",{["tap",[target: "creature"]],nil}},
      "sacrifice it.",
      "destroy target artifact.",
      "add {W} to your mana pool.",
      "fateseal 2.",
      "draw a card.",
      "draw two cards.",
    ]
  end

end
