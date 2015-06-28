defmodule MtgParser.Target.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Target


  parse_test "Target creature", target_creature do
    [
      "creature",
      "red creature",
    ]
  end

end
