defmodule MTGjson do
	use HTTPoison.Base

	def set_codes do get!("SetCodes") end
	def set_list do get!("SetList") end
	def version do get!("version") end
	def all_sets do get!("AllSets") end
	def all_cards do get!("AllCards") end

	def process_url(url) do
		"http://mtgjson.com/json/" <> url <> ".json"
	end

	def process_response_body(body) do
		body  |>
		Poison.decode!
	end
end
