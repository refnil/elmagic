defmodule MtgParser.Activated.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Activated

  parse_test "Activated abilities", activated do
    [
      {"{W}: tap target creature.",{["W"],{["tap",[target: "creature"]], nil}}},
      "{T}: tap target white creature.",
      "{2}, {T}: tap target white and blue creature.",
      "{1}{W}, {T}: Tap target creature without flying.",
      "{T}: Add {W}, {B}, or {G} to your mana pool.",
    ]
  end
end
