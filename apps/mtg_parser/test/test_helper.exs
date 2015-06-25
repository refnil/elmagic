ExUnit.start

defmodule ParserTestMacro do
  import ExUnit.Assertions

  def parse_test_fun(parser, list) do
    for element <- list do
      {value, result} = case element do
        {c,r}   -> {c,r}
        e       -> flunk("Wrong format in element list. " <> inspect(e))
      end
        
      received = ExParsec.parse_value(value,parser)
      assert(received == {:ok,nil,result}, 
        value <> " could not be parsed.\n" <> 
        "Received: " <> inspect(received) <> "\n" <>
        "Instead of: " <> inspect(result)
      )
    end
  end

  defmacro parse_test(testName, parser, clause) do
    list_value = Keyword.get(clause, :do, clause)

    quote do
      test unquote(testName) do
        parse_test_fun(unquote(parser), unquote(list_value))
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
