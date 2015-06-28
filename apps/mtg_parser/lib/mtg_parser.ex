defmodule MtgParser do
  import ExParsec.Helpers
  import ExParsec.Base

  defmparser target do
    zero
  end

  defmparser caracteristic do
    zero
  end

  defmparser object do
    zero
  end

  def replace_name_token(text) do
    IO.puts "Hello"
  end

end
