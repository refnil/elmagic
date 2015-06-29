defmodule MtgParser.Effect.Costable do
  import MtgParser.Effect.Helper

  import MtgParser.Target.Simple

  def effect do
    effect_list_parser(effect_list)
  end
    
  def effect_list do
    [
      ["sacrifice", reference_simple],
    ]
  end
end
