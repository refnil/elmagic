defmodule LexerTest do
    use ExUnit.Case
    
    @text """
    At the beginning of your upkeep, choose target opponent.
    This turn, that player can't cast spells or activate
    abilities and plays with his or her hand revealed.
    You may play cards from that player's hand this turn.
    """

    test "Lexing sentences" do
        result = @text |> parse
        assert( Enum.count(result) == 3)
    end

    defp parse(text) when is_list text do
      {:ok, tokens, _} = text |> :mtg_lexer.string
      {:ok, result} = :mtg_parser.parse(tokens)
      result
    end

    defp parse(text) when is_binary text do
      text |> to_char_list |> parse
    end
end
