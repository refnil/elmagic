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

  defmparser int do
    either(
      both(one_of("123456789"),many(digit()),&(Enum.join(List.insert_at(&2,0,&1),""))),
      digit())
  end

  defparser listify(parser) in p do
    flatify = 
    fn
      {list,last} -> list ++ [last]
      single -> [single]
    end
    single = parser
    last = pair_right(string(" and "), parser)
    more = pair_both(sep_by1(parser, string(", ")),last)
    map(either(more,single),flatify).(p)
  end
end
