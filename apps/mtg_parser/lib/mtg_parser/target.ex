defmodule MtgParser.Target do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text

  import Helpers.ExParsec.Text

  defmparser target do
    string_i("target")
    space
    target_creature
  end

  defmparser target_creature do
    attr <- option(listify(creature_adjective))
    skip(space)
    string_i("creature")
    return(filter: attr)
  end

  def creature_adjective do
    [
      "red",
      "blue",
      "green",
      "black",
      "white"
    ] |> Enum.map(&string_i/1) |> choice
  end
end
