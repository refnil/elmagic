defmodule ProcessText do
  import String

  def replace_name_token({name,text}) do
    replace(text,name,"**This**")
  end
end
