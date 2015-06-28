defmodule MtgParser.Triggered.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Triggered
  
  parse_list "Triggered abilities", triggered do
    [
      "When **This** attacks, sacrifice it at end of combat.",
      "When **This** attacks, sacrifice it.",
      "When **This** attacks or blocks, sacrifice it.",
      "When **This** attacks or blocks, sacrifice it at end of combat.",
      "When a dragon you control attacks, sacrifice it.", 
      "When **This** enters the battlefield, you gain 1 life.",
    ]
  end

  test "Full triggered" do
    name = "Mardu Blazebringer"
    text = "When Mardu Blazebringer attacks or blocks, sacrifice it at end of combat."
    assert({:ok,_s,_p} = MtgParser.parse(name,text))
  end

end

