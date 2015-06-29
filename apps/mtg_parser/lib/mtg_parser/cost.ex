defmodule MtgParser.Cost do
  import ExParsec.Helpers
  import ExParsec.Base
  import ExParsec.Text

  import MtgParser.Symbol
  import MtgParser.Effect.Costable

  def mana_cost do
    many1(
      choice([mana_symbol,mana_colorless,mana_hybrid])
    )
  end

  def cost do
    option = choice([mana_cost,tap_symbol,effect])
    list = sep_by1(option,string(", "))
    map(list,&List.flatten/1)
  end
end
