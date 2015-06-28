defmodule MtgParser do
  import ExParsec.Helpers
  import ExParsec.Base
  import ExParsec.Text

  import MtgParser.Keyword

  defmparser parse_text do
    keywords <- many(pair_left(keywords_parser,spaces))
    eof
    return keywords
  end

end
