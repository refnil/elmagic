defmodule Helpers.ExParsec.Text do
  import ExParsec.Text
  import ExParsec.Base
  import ExParsec.Helpers

  defparser char_i(codepoint) in p do
    down = char(String.downcase(codepoint))
    up = char(String.upcase(codepoint))
    either(down, up).(p)
  end

  defparser string_i(string) in p do
    codepoints = String.codepoints(string)
    parser_list = codepoints |> Enum.map &char_i/1
    join_and_lower = 
    fn codepoints ->
      Enum.join(codepoints,"") |> String.downcase
    end
    pipe(parser_list, join_and_lower).(p)
  end
end
