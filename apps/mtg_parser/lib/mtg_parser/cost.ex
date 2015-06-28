defmodule MtgParser.Cost do
  import ExParsec.Helpers
  import ExParsec.Base
  import ExParsec.Text

  import MtgParser.Symbol
  import Helpers.ExParsec.Text

  defmparser mana_tap do
    m <- mana_cost
    char(",")
    space
    t <- tap_symbol
    return m ++ [t]
  end

  def cost do
    choice([mana_tap,mana_cost,tap_symbol])
  end

  def mana_cost do
    many1(
      choice([mana_symbol,mana_colorless,mana_hybrid])
    )
  end

  def cost do
    zero
  end


end
