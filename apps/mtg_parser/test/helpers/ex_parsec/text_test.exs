defmodule Helpers.ExParsec.Text.Test do
  use ExUnit.Case
  use ExCheck

  import Helpers.ExParsec.Text

  defp parse(parser, string, result) do
    assert({:ok,nil,result} == ExParsec.parse_value(string,parser))
  end

  defp p(parser,string,result) do
    {:ok,nil,result} == ExParsec.parse_value(string,parser)
  end

  test "char_i" do
    list = 
    [
      {"c","C","c"},
      {"C","C","c"},
      {"C","c","c"},
      {"c","c","c"},
    ]

    for {arg, string, result} <- list do
      parse(char_i(arg),string, result)
    end
  end

  defmacro string do
    quote do
      list(char())
    end
  end

  property :parse_downcase do
    for_all x in string do
      implies x != [] do
        s = x |> to_string
        up = String.upcase(s)
        down = String.downcase(s)
        p(string_i(s), up, down)
      end
    end
  end

end
