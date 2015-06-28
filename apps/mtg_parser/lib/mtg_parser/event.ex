defmodule MtgParser.Event do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text

  defmparser event do
    zero
  end
end
