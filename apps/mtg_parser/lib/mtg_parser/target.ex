defmodule MtgParser.Target do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text

  import MtgParser.Keyword
  import MtgParser.Subtype
  import Helpers.ExParsec.Text
  import Helpers.ExParsec.Dict

  def target_or_reference do
    either(target_real,reference)
  end

  def reference do
    either(reference_counted,reference_simple)
  end

  defmparser reference_counted do
    count <- string("a")
    space
    permanent <- reference_permanent
    return {count, permanent}
  end

  defmparser reference_simple do
    either(
      string("it"),
      string("**This**"))
  end

  def target do
    either(target_real,reference_simple)
  end

  defmparser target_real do
    string_i("target")
    space
    reference_permanent
  end

  defmparser keyword_as_list do
    listify(keyword_name)
  end

  defmparser reference_permanent do
    another <- option(string_i("another"))
    skip(space)
    colors <- option(listify(color_adjective))
    skip(space)
    permanent <- either(permanent_parser, creature_subtype_parser) 
    skip(space)
    controller <- option(string_i("you control"))
    skip(space)
    keyword <- option(pair_both(either(string("with "),string("without ")),keyword_as_list))
    return_f([target: permanent, color: colors, keyword: keyword, another: another, controller: controller])
  end

  def permanent_parser do
    permanent_type |> Enum.map(&string_i/1) |> choice
  end

  def permanent_type do
    [
      "artifact",
      "creature",
      "enchantment",
      "land",
      "planeswalker",
    ] 
  end

  def creature_subtype_parser do
    creature_subtypes |> Enum.map(&string_i/1) |> choice
  end

  def color_adjective do
    [
      "red",
      "blue",
      "green",
      "black",
      "white"
    ] |> Enum.map(&string_i/1) |> choice
  end
end
