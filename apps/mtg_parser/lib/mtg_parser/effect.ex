defmodule MtgParser.Effect do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text

  import Helpers.ExParsec.Text

  import MtgParser.Target
  import MtgParser.Event

  defmparser effect do
    effect_list |> Enum.map(&effect_parser/1) |> choice 
  end

  defmparser effect_parser({action, parser}) do
    found <- string_i(action)
    space
    parsed <- parser
    delay <- option(pair_right(space,event))
    char(".")
    return {found,parsed,delay}
  end

  def effect_list do
    [
      {"tap", target},
      {"sacrifice", target},
    ]
  end
end
