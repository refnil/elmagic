defmodule MtgParser.Cost.Test do
  use ExUnit.Case

  import ParserTestMacro 
  import MtgParser.Cost
  import Mtg_parser.Test_helper

  parse_list "Cost", cost do
    [
      "{B}{G}{U}, {T}, Sacrifice **This**",
    ]
  end
end
