defmodule MtgParser do

  def parse!(text) do
    {:ok,result} = parse(text)
    result
  end

  def parse(text) when is_list text do
    case text |> :mtg_lexer.string do
      {:ok,tokens,_} -> :mtg_parser.parse(tokens)
      error -> error
    end
  end

  def parse(text) when is_binary text do
    text |> to_char_list |> parse
  end

  defmacro test, do: 2
end
