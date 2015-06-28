defmodule MtgParser.Triggered.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Triggered
  
  parse_list "Triggered abilities", triggered do
    [
      "When **This** attacks, sacrifice it at end of combat.",
      "When **This** attacks, sacrifice it.",
      "When **This** attacks or blocks, sacrifice it.",
    ]
  end

end

