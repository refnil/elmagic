defmodule ParserTest do
  use ExUnit.Case
  import ParserTestMacro
  import Enum
  import String

  parse_test "Symbols" do
    base_symbols = [:w,:u,:r,:b,:g]
    solo_symbols = base_symbols ++ [:s,:x,:p] ++ to_list(1..10)
      |> map &([&1])

    fun = fn s -> Enum.map base_symbols, &([s,&1]) end

    dual = Enum.flat_map base_symbols, fun 
    psymbols = fun.(:p) |> map fn [p1,p2] -> [p2,p1] end
    symbols2 = fun.(2)


    str = 
    fn
      val when is_atom(val) -> val |> to_string |> upcase
      val -> val |> to_string
    end

    stringify = 
    fn
      [a,b] -> "{" <> str.(a) <> "/" <> str.(b) <> "}"
      [val] -> "{" <> str.(val) <> "}"
    end

    solo_symbols ++ dual ++ psymbols ++ symbols2
    |> map &({stringify.(&1),[&1]})
  end

  test "Does parse_test work" do
    assert_raise(ExUnit.AssertionError, fn -> parse_test_fun(["{G}"]) end)
  end
end
