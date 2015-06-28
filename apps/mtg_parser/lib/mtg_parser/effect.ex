defmodule MtgParser.Effect do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text

  import Helpers.ExParsec.Text

  import MtgParser.Target

  defmparser effect do
    effect_list |> Enum.map(&effect_parser/1) |> choice 
  end

  defmparser effect_parser({action, parser}) do
    found <- string_i(action)
    space
    parsed <- parser
    return {found,parsed}
  end

  def effect_list do
    [
      {"tap", target}
    ]
  end
end
