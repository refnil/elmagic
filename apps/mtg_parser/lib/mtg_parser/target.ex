defmodule MtgParser.Target do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text

  import MtgParser.Keyword
  import Helpers.ExParsec.Text

  defmparser target do
    string_i("target")
    space
    target_creature
  end

  defmparser keyword_as_list do
    listify(keyword_name)
  end

  defmparser target_creature do
    with <- option(listify(creature_adjective))
    skip(space)
    string_i("creature")
    skip(space)
    keyword <- option(pair_both(either(string("with "),string("without ")),keyword_as_list))
    return([color: with, keyword: keyword])
  end

  def creature_adjective do
    [
      "red",
      "blue",
      "green",
      "black",
      "white"
    ] |> Enum.map(&string_i/1) |> choice
  end
end
