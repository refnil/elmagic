defmodule Helpers.ExParsec.Text do
  import ExParsec.Text
  import ExParsec.Base
  import ExParsec.Helpers

  defparser char_i(codepoint) in p do
    down = char(String.downcase(codepoint))
    up = char(String.upcase(codepoint))
    map(either(down, up),&String.downcase/1).(p)
  end

  defparser string_i(string) in p do
    codepoints = String.codepoints(string)
    parser_list = codepoints |> Enum.map &char_i/1
    join = 
      fn codepoints ->
        Enum.join(codepoints,"")
      end
    pipe(parser_list, join).(p)
  end
end
