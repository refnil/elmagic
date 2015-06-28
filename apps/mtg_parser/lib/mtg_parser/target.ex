defmodule MtgParser.Target do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text

  import MtgParser.Keyword
  import Helpers.ExParsec.Text
  import Helpers.ExParsec.Dict

  defmparser target do
    either(target_it,target_rest)
  end

  defmparser target_it do
    string("it")
  end

  defmparser target_rest do
    string_i("target")
    space
    target_creature
  end

  defmparser keyword_as_list do
    listify(keyword_name)
  end

  defmparser target_creature do
    another <- option(string_i("another"))
    skip(space)
    colors <- option(listify(creature_adjective))
    skip(space)
    string_i("creature")
    skip(space)
    keyword <- option(pair_both(either(string("with "),string("without ")),keyword_as_list))
    return_f([target: "creature", color: colors, keyword: keyword, another: another])
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
