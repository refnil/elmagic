defmodule MtgParser.Effect do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text

  import Helpers.ExParsec.Text

  import MtgParser.Target
  import MtgParser.Event
  import MtgParser.Symbol

  defmparser effect do
    eff <- effect_list_parser
    delay <- option(pair_right(space,event))
    char(".")
    return {eff,delay}
  end

  def create_effect_parser(list) do
    converter = fn
      e when is_bitstring(e) -> string_i e
      e -> e
    end
    parsers = Enum.map(list,converter)
    parsers = Enum.intersperse(parsers,skip(space))
    pipe(parsers,fn list -> Enum.filter(list, &(!is_nil(&1))) end)
  end

  def effect_list_parser do
    effect_list |> Enum.map(&create_effect_parser/1) |> choice 
  end

  def effect_list do
    [
      ["tap", target],
      ["sacrifice", target],
      ["bolster", int],
      ["destroy", target],
      ["scry", int],
      ["fateseal", int],
      ["add", mana_cost, "to your mana pool"]
    ]
  end
end
