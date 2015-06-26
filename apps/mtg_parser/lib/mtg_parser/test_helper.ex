defmodule Mtg_parser.Test_helper do
  
  def symbol_test(list) do 
    list |> Enum.map &({"{" <> &1 <> "}", &1})
  end
end
