defmodule MtgParser.Activated do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text

  import MtgParser.Symbol
  import MtgParser.Effect

  require ExParsec.Monad.Parse
  alias ExParsec.Monad.Parse

  def activated do
    mana_tap = sequence([mana_cost,ignore(char(",")),ignore(space),tap_symbol])
    cost = choice([mana_tap,mana_cost,tap_symbol])
    
    Parse.m do
      c <- cost
      char(":")
      space
      e <- effect
      return {c,e}
    end
  end
end
