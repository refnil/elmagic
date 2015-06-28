defmodule MtgParser.Activated.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Activated

  parse_test "Activated abilities", activated do
    [
      {"{W}: tap target creature.",{["W"],{"tap",[color: nil, keyword: nil], nil}}},
      "{T}: tap target white creature.",
      "{2}, {T}: tap target white and blue creature.",
      "{1}{W}, {T}: Tap target creature without flying.",
    ]
  end
end
