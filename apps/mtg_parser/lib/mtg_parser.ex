defmodule MtgParser do
  import ExParsec.Helpers
  import ExParsec.Base
  import ExParsec.Text

  import MtgParser.Keyword
  import MtgParser.Activated

  defmparser many_flat(parser) do
    map(many(parser),&List.flatten/1)
  end

  defmparser parse_text do
    keywords <- many_flat(keyword_line)
    activated <- many(activated)
    eof
    return {keywords,activated}
  end

end
