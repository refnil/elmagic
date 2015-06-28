defmodule MtgParserTest do
  use ExUnit.Case
  @moduletag :long

  setup do
    MTGJson.start
    :ok
  end

  @card_name [
    "Aerie Bowmasters",
    "Aven Sunstriker",
    "Dragon's Eye Sentry",
    "Dromoka Dunecaster",
    "Mardu Blazebringer",
    "Shatter",
    "Erase",
    "Monastery Swiftspear",
    "Sandsteppe Citadel",
    "Scoured Barrens",
  ]

  @set [
    "DTK",
    "KTK",
  ]

  defp filter_name(%{"name" => name}) do
      Enum.member?(@card_name, name)
  end

  defp get_cards(set) do
    {:ok, response} = MTGJson.get(set)
    response.body["cards"] |> Enum.filter &filter_name/1
  end

  test "Parse DTK" do

    card_list = @set |> Enum.map(&get_cards/1) |> Enum.concat

    for %{"name" => name, "text" => text} <- card_list do
      result = MtgParser.parse(name, text)
      assert(Enum.at(result |> Tuple.to_list,0) == :ok,
        "Name: " <> name <> "\n" <>
        "Text: " <> text <> "\n" <>
        "Received: " <> inspect(result)
      )
      IO.inspect(result)
    end
  end
end
