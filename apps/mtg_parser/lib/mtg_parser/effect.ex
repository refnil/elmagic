defmodule MtgParser.Effect do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text

  import Helpers.ExParsec.Text

  import MtgParser.Target
  import MtgParser.Event
  import MtgParser.Cost
  import MtgParser.PowerToughness

  import MtgParser.Effect.Helper

  defp addDelay(s,nil) do
    s
  end
  defp addDelay(s,d) do
    s ++ [delay: d]
  end

  defmparser effect do
    {n,s} <- effect_list_parser(effect_list)
    delay <- option(pair_right(space,event))
    char(".")
    return {n,addDelay(s,delay)}
  end

  def effect_list do
    [
      ["sacrifice", target],
      ["tap", target],
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

