defmodule MtgParser.Target.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Target

  parse_test "Referemce simple", reference_simple do
    [
      "it",
      "**This**",
      "you",
    ]
  end

  parse_list "Reference permanent", reference_permanent do
    [
      "another creature",
      "another red creature",
      "creature",
      "red creature",
      "red creature with flying",
      "red creature without defender",
      "artifact",
      "dragon",
      "dragon you control",
      "enchantment",
    ]
  end

  parse_list "Reference counted", reference_counted do
    [
      "a dragon you control",
    ]
  end

end
