defmodule MtgParserTest do
  use ExUnit.Case
  @moduletag :long

  setup context do
    MTGJson.start
    :ok
  end

  @card_name [
    "Aerie Bowmasters",
    "Aven Sunstriker",
    "Dragon's Eye Sentry",
    "Dromoka Dunecaster",
    "Dragon-Scarred Bear",
  ]

  defp filter_name(%{"name" => name}) do
      Enum.member?(@card_name, name)
  end

  test "Parse DTK" do
    {:ok, response} = MTGJson.get("DTK")

    card_list = response.body["cards"] |> Enum.filter &filter_name/1

    for %{"name" => name, "text" => text} <- card_list do
      result = ExParsec.parse_value(text, MtgParser.parse_text)
      assert(Enum.at(result |> Tuple.to_list,0) == :ok,
        "Name: " <> name <> "\n" <>
        "Text: " <> text <> "\n" <>
        "Received: " <> inspect(result)
      )
      IO.inspect(result)
    end
  end
end
