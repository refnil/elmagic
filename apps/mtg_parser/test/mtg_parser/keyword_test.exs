defmodule Keyword_Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Keyword


  parse_test "Keyword", keywords_parser do
    [
      "flying",
      "Flying",
      "defender",
      "SoulshIft 3",
      "Equip {W}",
      "Frenzy 0",
    ]
  end

end
