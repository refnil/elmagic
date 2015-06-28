defmodule MtgParser.Static.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Static

  parse_list "Static", static do
    [
      "**This** enters the battlefield tapped.",
    ]
  end
end
