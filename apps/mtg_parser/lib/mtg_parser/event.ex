defmodule MtgParser.Event do
  import ExParsec.Base
  import ExParsec.Helpers
  import ExParsec.Text
 
  import Helpers.ExParsec.Text
  import MtgParser.Target

  defmparser event do
    choice([event_when,event_at,event_until])
  end

  defmparser event_when do
    time <- choice([string_i("As"),string_i("Whenever"),string_i("When"),])
    space 
    who <- reference
    skip(space)
    found <- listify(choice(Enum.map(event_list, fn(x) -> string_i(x) end))," or ")
    return {time,who,found}
  end

  defmparser event_at do
    event_list |> Enum.map(&(timed_parser("at",&1))) |> choice
  end

  def event_until do
    event_list |> 
    Enum.map(&(timed_parser("until", &1))) |>
    choice
  end

  defmparser timed_parser(word, action) do
    time <- string_i(word)
    space
    found <- string_i(action)
    return {time,found}
  end

  def event_list do
    [
      "attacks",
      "blocks", 
      "end of combat", 
      "dies", 
      "enters the battlefield", 
      "is turned face up",
      "end of combat", 
      "leaves the battlefield", 
      "is put into a graveyard from the battlefield", 
      "becomes tapped", 
      "becomes uptapped", 
      "the beginning of your upkeep",
      "until end of turn",
    ]
  end
end
