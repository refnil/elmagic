defmodule MtgParser.Effect do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text

  import Helpers.ExParsec.Text

  import MtgParser.Target
  import MtgParser.Event
  import MtgParser.Cost
  import MtgParser.PowerToughness

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
      ["draw", quantity, string_plurial("card")],
      [string_plurial("discard"), quantity, string_plurial("card")],
      ["exile", target],
      ["refenerate", target],
      ["add", listify(mana_cost," or "), "to your mana pool"],
      [option(target),"deals",int,"damage to", target],
      [option(target),"gain",int,"life"],
      [reference,"gets",powertoughness],
    ]
  end
end
