defmodule MtgParser.Target.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Target

  parse_test "Target simple", target_simple do
    [
      "it",
      "**This**",
    ]
  end

  parse_test "Target creature", target_creature do
    [
      "creature",
      "red creature",
      "red creature with flying",
      "red creature without defender",
    ]
  end

end
