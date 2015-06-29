defmodule MtgParser.Effect.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Effect

  # Don't forget to add the ending dot for the tests.
  parse_test "Effect", effect do
    [
      {"tap target creature.",{"tap",[[target: "creature"]]}},
      "sacrifice it.",
      "destroy target artifact.",
      "add {W} to your mana pool.",
      "fateseal 2.",
      "draw a card.",
      "draw two cards.",
      "you gain 1 life.",
      "it deals 3 damage to target creature.",
      "discards a card.",
      "discard a card.",
      "**This** gets +1/+2.",
    ]
  end

end
