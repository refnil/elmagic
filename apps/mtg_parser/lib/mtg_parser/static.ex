defmodule MtgParser.Static do
  import ExParsec.Helpers
  import ExParsec.Text
  
  import MtgParser.Target

  defmparser static do
    object <- reference
    time <- string(" enters the battlefield ")
    modified <- string("tapped")
    char(".")

    return {object,time,modified}
  end
end
