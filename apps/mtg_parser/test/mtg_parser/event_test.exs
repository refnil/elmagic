defmodule MtgParser.Event.Test do
  use ExUnit.Case

  import ParserTestMacro
  import MtgParser.Event

  parse_list "Event", event do
    [
      "When **This** attacks or blocks",
      "When **This** dies",
      "When **This** enters the battlefield",
      "When **This** enters the battlefield",
      "As **This** enters the battlefield",
      "Whenever **This** attacks",
      #"Whenever a Permanent you control attacks",
    ]
  end

end
