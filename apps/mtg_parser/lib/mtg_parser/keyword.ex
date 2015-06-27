defmodule MtgParser.Keyword do
  import MtgParser
  import ExParsec.Base
  import ExParsec.Text
  import ExParsec.Helpers

  import Helpers.ExParsec.Text

  defparser keyword_parser(keyword) in p do
    ignore_2 = fn [name, _spaces, content] -> {name,content} end
    case keyword do
      {name, parser} -> pipe([keyword_parser(name), many1(spaces), parser], ignore_2).(p)
      _ -> string_i(keyword).(p)
    end
  end

  defparser keywords_parser in p do
    list = keyword |> Enum.map (&keyword_parser/1)
    choice(list).(p)
  end

  def keyword do
  [
    "deathtouch",
    "defender",
    "double strike",
    {"Equip", mana_symbol},
    {"Enchant", target},
    "first strike",
    "flash",
    "flying",
    "haste",
    "hexproof",
    "indestructible",
    "intimidate",
    "lifelink",
    {"protection from", caracteristic},
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
    {"amplify", int},
    "provoke",
    "storm",
    {"affinity for" ,target},
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
    {"champion an", object},
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
