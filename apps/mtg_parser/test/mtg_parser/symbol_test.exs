defmodule MtgParser.Symbol.Test do
  use ExUnit.Case
  import ParserTestMacro 
  import MtgParser.Symbol
  import Mtg_parser.Test_helper


  parse_test "Mana symbols", mana_symbol do
    ["W","U","R","B","G"] |> symbol_test
  end

  parse_test "Mana Colorless", mana_colorless do
    ["X","0","1","2","10","25","152"] |> symbol_test
  end

  parse_test "Hybrid Mana", mana_hybrid do
    ["W/P","R/P","G/P","B/P","U/P","2/W","2/R","2/G","2/B","2/U","W/U","U/B","B/R","R/G","G/W","W/B","U/R","B/G","R/W","G/U"] |> symbol_test_tuple
  end

  test "list test" do
    mana = mana_list
    assert(Enum.count(mana) == 5)
  end
end
