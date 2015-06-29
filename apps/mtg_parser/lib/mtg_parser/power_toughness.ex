defmodule MtgParser.PowerToughness do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text
 
  import Helpers.ExParsec.Text

  defmparser powertoughness do
    s <- option(one_of("+-"))
    power <- int
    char("/")
    s1 <- option(one_of("+-"))
    toughness <- int
    return {s,power,s1,toughness}
  end
end 
