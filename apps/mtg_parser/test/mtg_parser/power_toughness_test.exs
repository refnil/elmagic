defmodule MtgParser.PowerToughness.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.PowerToughness

  parse_list "Power Toughness", powertoughness do
    [ "2/5",
      "+0/+1",
      "-1/-1",
      "+4/-2",
    ]
  end
end
