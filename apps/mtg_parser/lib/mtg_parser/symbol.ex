defmodule MtgParser.Symbol do
  import ExParsec.Helpers
  import ExParsec.Base
  import ExParsec.Text

  import Helpers.ExParsec.Text

  defmparser mana_symbol do
    between_braces(one_of("WURBGSP"))
  end

  defmparser tap_symbol do
    between_braces(char("T"))
  end

  defmparser untap_symbol do
    between_braces(char("Q"))
  end

  defmparser chaos_symbol do
    between_braces(char("C"))
  end

  defmparser mana_colorless do
    between_braces(either(char("X"),int))
  end

  defmparser between_braces(parser) do
    between(char("{"),parser, char("}"))
  end

  defmparser mana_hybrid do
    between_braces(hybrid_parser)
  end

  defmparser hybrid_parser do
    Enum.map(
      mana_list ++ [{"2","WUBRG"},{"WUBRG","P"}], 
      fn {x,y} -> pair_both(
        pair_left(one_of(x),char("/")),
        one_of(y))
      end
      ) |> choice
  end

  def mana_list do
    for i <- 0..4 do
      {String.at("WUBRG",i),String.at("WUBRG",rem((i+1),5))<>String.at("WUBRG",rem((i+2),5))}  
    end
  end

  defmparser mana_cost do
    many1(
      choice([mana_symbol,mana_colorless,mana_hybrid])
    )
  end
end
