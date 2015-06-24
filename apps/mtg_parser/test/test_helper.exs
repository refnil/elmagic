ExUnit.start

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
        assert(f.(received,{:ok, result}), 
          value <> " could not be parsed.\n" <> 
          "Received: " <> inspect(received) <> "\n" <>
          "Instead of: " <> inspect(result)
        )
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

  def file_to_test (filename) do
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
