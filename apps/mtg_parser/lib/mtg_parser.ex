defmodule MtgParser do
  import ExParsec.Helpers
  import ExParsec.Base
  import ExParsec.Text

  import MtgParser.Keyword
  import MtgParser.Activated
  import MtgParser.Triggered
  import MtgParser.Effect
  import MtgParser.Static
  import MtgParser.ProcessText

  defmparser many_flat(parser) do
    map(many(parser),&List.flatten/1)
  end

  def parse(name, text) do
    text_updated = replace_name_token({name, text})
    ExParsec.parse_value(text_updated,parse_text)
  end

  defp text_part do
    pair_left(
      choice(
        [
          keyword_line,
          activated,
          triggered,
          effect,
          static
        ]
      ),
      spaces
    )
  end

  defmparser parse_text do
    part <- many_flat(prefix(text_part))
    eof
    return part
  end

end
