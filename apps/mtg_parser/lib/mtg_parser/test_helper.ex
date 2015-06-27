defmodule Mtg_parser.Test_helper do
  
  def symbol_test(list) do 
    list |> Enum.map &({"{" <> &1 <> "}", &1})
  end

  def symbol_test_tuple(list) do
    list |> Enum.map &({"{" <> &1 <> "}", {String.first(&1),String.last(&1)}})
  end
end
