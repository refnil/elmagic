defmodule MtgParser.Triggered.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Triggered
  
  parse_test "Triggered abilities", triggered do
    [
      "When Mardu Blazebringer attacks or blocks, sacrifice it at end of combat."
    ]
  end

end

