defmodule MtgParser.Triggered do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text
  
  import MtgParser.Event
  import MtgParser.Effect

  defmparser triggered do
    ev <- event
    char(",")
    space
    ef <- effect
    return {ev,ef}
  end
end
