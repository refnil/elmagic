defmodule MtgParser.Effect.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Effect

  parse_test "Effect", effect do
    [
      "tap target creature.",
    ]
  end

end
