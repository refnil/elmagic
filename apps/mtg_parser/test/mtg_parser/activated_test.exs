defmodule MtgParser.Activated.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Activated

  parse_test "Activated abilities", activated do
    [
      {"{W}: tap target creature",{["W"],{"tap",[filter: nil]}}},
      "{T}: tap target white creature",
      "{2}, {T}: tap target white and blue creature",
    ]
  end
end
