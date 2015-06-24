defmodule ParserTestMacro do
  import MtgParser
  import ExUnit.Assertions

  def parse_test_fun(list) do
      for element <- list do
        {value, result, f} = case element do
          {c,r}   -> {c,r,&(&1 == &2)}
          {c,r,f} -> {c,r,f}
          e       -> flunk("Wrong format in element list. " <> inspect(e))
        end
          
        received = parse(value)
        assert(f.(received,result), value <> " could not be parsed.\nReceived: " <> inspect(received))
      end
  end

  defmacro parse_test(testName, clause) do
    list_value = Keyword.get(clause, :do, clause)

    quote do
      test unquote(testName) do
        parse_test_fun(unquote(list_value))
      end
    end
  end

  def parse_test_file_fun (filename) do
     case File.read("test/" <> filename) do
       {:ok,content} -> content
       _ -> flunk("Couldn't read " <> filename <> ".")
     end |>
     String.split("\n") |>
     Enum.chunk(2) |>
     Enum.map &List.to_tuple/1
  end

  defmacro parse_test_file(testName, file) do
    quote do
      parse_test unquote(testName) do
        file_to_test(unquote(file))
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

  test "Does parse_test work" do
    assert_raise(ExUnit.AssertionError, fn -> parse_test_fun([{"{G}","G"}]) end)
    assert_raise(ExUnit.AssertionError, fn -> parse_test_fun(["{G}"]) end)
  end
end
