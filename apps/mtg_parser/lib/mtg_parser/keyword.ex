defmodule MtgParser.Keyword do
  import ExParsec.Base
  import ExParsec.Text
  import ExParsec.Helpers

  import MtgParser.Cost
  import MtgParser.Target.Simple

  import Helpers.ExParsec.Text

  defparser keyword_parser({name,parser}) in p do
    ignore_2 = 
      fn [name, _spaces, content] -> 
        {name,content} 
      end
    pipe([keyword_parser(name), many1(space), parser], ignore_2).(p)
  end
  defparser keyword_parser(keyword) in p do
    string_i(keyword).(p)
  end

  defmparser remainder_text do
    spaces()
    char("(")
    content <- many(none_of(")"))
    char(")")
    return(content)
  end

  defparser keyword in p do
    list = keyword_list |> Enum.map (&keyword_parser/1)
    choice(list).(p)
  end

  defparser keyword_line in p do
    keyword_list = sep_by1(keyword, sequence([char(","),space()]))
    keyword_with_remainder = pair_left(keyword,remainder_text)
    pair_left(either(keyword_with_remainder,keyword_list),skip(newline)).(p)
  end

  defparser keyword_name in p do
    name = fn 
      {n,_p} -> string_i(n)
      n -> string_i(n)
    end

    r = keyword_list |> Enum.map(name) |> choice
    r.(p)
  end

  def prefix(parser) do
    either(pair_both(ability_word,parser),parser)
  end

  defmparser ability_word do
    ability_word <- many(alphanumeric)
    space
    char("-")
    space
    return(ability_word)
  end

  def keyword_list do
  [
    "deathtouch",
    "defender",
    "double strike",
    {"Equip", mana_cost},
    {"Enchant", permanent_parser},
    "first strike",
    "flash",
    "flying",
    "haste",
    "hexproof",
    "indestructible",
    "intimidate",
    "lifelink",
    #{"protection from", caracteristic},
    "reach",
    "shroud",
    "trample",
    "vigilance",
    "banding",
    {"rampage", int},
    {"cumulative upkeep", mana_cost},
    "flanking",
    "phasing",
    {"buyback", mana_cost},
    "shadow",
    {"echo", mana_cost},
    "horsemanship",
    "fading",
    {"kicker", mana_cost},
    {"madness", mana_cost},
    "fear",
    {"morph", mana_cost},
    {"megamorph", mana_cost},
    {"amplify", int},
    "provoke",
    "storm",
    {"affinity for" ,reference},
    {"entwine", mana_cost},
    {"modular", int},
    "sunburst",
    {"bushido", int},
    {"soulshift", int},
    {"ninjutsu", mana_cost},
    "epic",
    "convoke",
    {"dredge", int},
    {"transmute", int},
    {"bloodthirst", int},
    "haunt",
    {"replicate", mana_cost},
    {"graft", int},
    {"recover", mana_cost},
    {"ripple", int},
    "split second",
    {"vanishing", int},
    {"absorb", int},
    {"aura swap", mana_cost},
    "delve",
    {"fortify", mana_cost},
    {"frenzy", int},
    "gravestrom",
    {"poisonous", int},
    {"transfigure", mana_cost},
    #{"champion an", object},
    "changeling",
    {"Evoke", mana_cost},
    "hideaway",
    {"prowl", mana_cost},
    "conspire",
    "persist",
    "wither",
    "retrace",
    {"devour",int},
    "exalted",
    {"unearth", mana_cost},
    "cascade",
    {"annihilator", int},
    {"level up", mana_cost},
    "rebound",
    "totem armor",
    "infect",
    "battle cry",
    "living weapon",
    "undying",
    {"miracle" ,mana_cost},
    "soulbond",
    {"overload", mana_cost},
    {"scavenge", mana_cost},
    "unleash",
    "cipher",
    "evolve",
    "extort",
    "fuse",
    {"bestow", mana_cost},
    {"tribute", int},
    "dethrone",
    "hidden agenda",
    {"outlast", mana_cost},
    "prowess",
    {"dash", mana_cost},
  ]
  # reinforce
  # Suspend
  # Landwalk
  # Cycling
  # multi kicker
  # {"splice onto", subtype, mana_cost},
  # offering
  # forecast
  end
end
