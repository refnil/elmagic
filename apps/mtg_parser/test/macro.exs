defmodule ParserTestMacro do
  import ExUnit.Assertions

  import ExParsec.Base
  import ExParsec.Text

  defp parse_test_message(value,received,result \\ nil) do
      message = value <> " could not be parsed.\n" <> 
      "Received: " <> inspect(received) <> "\n"
      if result != nil do
        message = message <>
          "Instead of: " <> inspect(result)
      end
      message
  end

  def parse_test_fun(parser, {value,result,fun}) do
    received = ExParsec.parse_value(value,parser)
    assert(
      fun.(result,received),
      parse_test_message(value,received)
    )
  end
  def parse_test_fun(parser, {value,result}) do
    received = ExParsec.parse_value(value,parser)
    assert(
      received == {:ok,nil,result}, 
      parse_test_message(value,received,result)
    )
  end
  def parse_test_fun(parser,single_value) do
    received = ExParsec.parse_value(single_value,parser)
    assert(
      {:ok,_a,_b} = received, 
      parse_test_message(single_value,received)
    )
  end

  defmacro parse_test(testName, parser, clause) do
      list_quoted = Keyword.get(clause, :do, clause)
      Macro.to_string list_quoted
      {list_value,[]} = Code.eval_quoted(list_quoted,[],__CALLER__)

      for element <- list_value do
        quote do
         test unquote(testName <> " " <> inspect(element)) do
            parse_test_fun(pair_left(unquote(parser),eof()), unquote(element))
         end
      end
    end
  end

  def file_to_test (filename) do
     case File.read("test/" <> filename) do
       {:ok,content} -> content
       _ -> flunk("Couldn't read " <> filename <> ".")
     end |>
     String.split("\n") |>
     Enum.chunk(2) |>
     Enum.map &List.to_tuple/1
  end

  defmacro parse_test_file(testName, parser, file) do
    quote do
      parse_test unquote(parser), unquote(testName) do
        file_to_test(unquote(file))
      end
    end
  end
end
