defmodule Keyword_Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Keyword


  parse_test "Keyword", keyword do
    [
      "flying",
      "Flying",
      "defender",
      "SoulshIft 3",
      "Equip {W}",
      "Frenzy 0",
    ]
  end

  parse_test "Keyword line", keyword_line do
    [
      "flying, reach",
      "Megamorph {5}{B}{B} (You may cast this card face down as a 2/2 creature for {3}. Turn it face up any time for its megamorph cost and put a +1/+1 counter on it.)",
      "Frenzy 0",
    ]
  end

  parse_test "Remainder text", remainder_text do
    [
      "(Test test)",
      " (Test test)",
      " (Do stuff)",
    ]
  end

end
