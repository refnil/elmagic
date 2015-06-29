defmodule MtgParser.Effect.Helper do
  import ExParsec.Helpers
  import ExParsec.Base
  import ExParsec.Text

  import Helpers.ExParsec.Text

  def create_effect_parser(list) do
    converter = fn
      e when is_bitstring(e) -> string_i e
      e -> e
    end
    parsers = Enum.map(list,converter)
    parsers = Enum.intersperse(parsers,skip(space))
    parsers = pipe(parsers,fn list -> Enum.filter(list, &(!is_nil(&1))) end)
    map(parsers, fn [h|t] -> {h,t} end)
  end

  def effect_list_parser(list) do
    list |> Enum.map(&create_effect_parser/1) |> choice 
  end
end
