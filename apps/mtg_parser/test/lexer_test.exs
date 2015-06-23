defmodule LexerTest do
    use ExUnit.Case
    
    @text """
    At the beginning of your upkeep, choose target opponent.
    This turn, that player can't cast spells or activate
    abilities and plays with his or her hand revealed.
    You may play cards from that player's hand this turn.
    """

    test "Lexing description" do
        {:ok, tokens, _} = @text |> to_char_list |> :description_lexer.string
        {:ok, result} = :description_parser.parse(tokens)
        IO.puts Enum.count(result)
    end
end
