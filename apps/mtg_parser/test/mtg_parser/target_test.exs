defmodule MtgParser.Target.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Target

  parse_test "Target", target do
    [
      "it",
    ]
  end

  parse_test "Target creature", target_creature do
    [
      "another creature",
      "another red creature",
      "creature",
      "red creature",
      "red creature with flying",
      "red creature without defender",
    ]
  end

end
