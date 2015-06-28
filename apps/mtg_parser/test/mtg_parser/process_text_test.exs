defmodule ProcessTextTest do
  use ExUnit.Case
  import ProcessText
  
  test "Replace name by token" do
    t = replace_name_token(
    {"Geist-Honored Monk","Vigilance Geist-Honored Monk's power and toughness are each equal to the number of creatures you control. When Geist-Honored Monk enters the battlefield, put two 1/1 white Spirit creature tokens with flying onto the battlefield."})
    assert( t == 
    "Vigilance **This**'s power and toughness are each equal to the number of creatures you control. When **This** enters the battlefield, put two 1/1 white Spirit creature tokens with flying onto the battlefield.")
  end

end
