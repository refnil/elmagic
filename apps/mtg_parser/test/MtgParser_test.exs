defmodule MtgParserTest do
  use ExUnit.Case
  import ParserTestMacro 
  import MtgParser
  import Mtg_parser.Test_helper


  parse_test "Mana symbols", mana_symbol do
    ["W","U","R","B","G"] |> symbol_test
  end

  parse_test "Mana Colorless", mana_colorless do
    ["X","0","1","2","10","25","152"] |> symbol_test
  end

  parse_test "Dual Mana", mana_dual do
    ["W/B","R/U","G/G"] |> symbol_test_tuple
  end

  parse_test "Mana alt", mana_alt do
    ["W/P","R/P","G/P","B/P","U/P","2/W","2/R","2/G","2/B","2/U","2/P"] |> symbol_test_tuple
  end

end
