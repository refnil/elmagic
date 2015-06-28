defmodule MtgParserTest do
  use ExUnit.Case

  import MtgParser
  
  test "Replace name by token" do
    assert(replace_name_token(
    {"Geist-Honored Monk","vigilance geist-honored monk's power and toughness are each equal to the number of creatures you control. when geist-honored monk enters the battlefield, put two 1/1 white spirit creature tokens with flying onto the battlefield."}) == 
    "Vigilance **This**'s power and toughness are each equal to the number of creatures you control. When **This** enters the battlefield, put two 1/1 white Spirit creature tokens with flying onto the battlefield.")
  end

end
