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


end
