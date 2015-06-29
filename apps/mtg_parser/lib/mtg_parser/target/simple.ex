defmodule MtgParser.Target.Simple do
  import ExParsec.Base
  import ExParsec.Text
  import Helpers.ExParsec.Text

  def reference do
    reference_simple
  end

  def reference_simple do
    choice([
      string("it"),
      string("**This**"),
      string("you")
    ])
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
end
