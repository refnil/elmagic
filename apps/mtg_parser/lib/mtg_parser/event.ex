defmodule MtgParser.Event do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text
 
  import Helpers.ExParsec.Text
  import MtgParser.Target

  defmparser event do
    choice([event_when,event_at])
  end

  defmparser event_when do
    time <- string_i("When")
    space 
    who <- reference
    skip(space)
    found <- listify(choice(Enum.map(event_list, fn(x) -> string_i(x) end))," or ")
    return {time,who,found}
  end

  defmparser event_at do
    event_list |> Enum.map(&at_parser/1) |> choice
  end

  defmparser at_parser(action) do
    time <- string_i("at")
    space
    found <- string_i(action)
    return {time,found}
  end

  def event_list do
    [
      "attacks",
      "blocks", 
      "end of combat", 
    ]
  end
end
