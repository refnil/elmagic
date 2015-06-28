defmodule Helpers.ExParsec.Dict do
  import ExParsec.Base

  def return_f(dic) do
    return(dic |> filter_nil)
  end

  defp filter_nil(dic) do
    dic |> Enum.filter(fn {k,v} -> v != nil end)
  end
end
