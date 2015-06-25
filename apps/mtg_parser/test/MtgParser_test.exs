defmodule MtgParserTest do
  use ExUnit.Case
  import ParserTestMacro 
  import MtgParser


  parse_test "Mana symbols", mana_symbol do
    ["W","U","R","B","G"] |>
    Enum.map &({"{" <> &1 <> "}",&1})
  end

end
