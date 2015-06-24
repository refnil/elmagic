defmodule ParserTestMacro do
  import MtgParser

  defmacro parse_test(testName, list) do
    quote do
      test unquote(testName) do
        for {value,result} <- unquote(list) do
          received = parse(result)
          assert(received == result, value <> " could not be parsed.\nReceived: " <> inspect(received))
        end
      end
    end
  end
end

defmodule ParserTest do
  use ExUnit.Case
  import MtgParser
  import ParserTestMacro

  
  @text """
  At the beginning of your upkeep, choose target opponent.
  This turn, that player can't cast spells or activate
  abilities and plays with his or her hand revealed.
  You may play cards from that player's hand this turn.
  """

  test "Lexing sentences" do
      result = @text |> parse!
      assert( Enum.count(result) == test + 1)
  end

  parse_test "Symbol",[{"{G}","G"}]
end
