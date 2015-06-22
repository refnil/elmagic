defmodule MTGjson do
	use HTTPoison.Base

	def set_codes do get!("SetCodes") end
	def set_list do get!("SetList") end
	def version do get!("version") end
	def all_sets do get!("AllSets") end
	def all_cards do get!("AllCards") end

    @nozip ["SetCodes","SetList","version","version-full","changelog"]

	def process_url(url,force_zip \\ false) do
		fullurl = "http://mtgjson.com/json/" <> url <> ".json"
        case Enum.find(@nozip, :notfound, &(url == &1)) do
            :notfound -> if force_zip do ".zip" else "" end
            _ -> ""
        end
		IO.puts fullurl
	    fullurl	
	end

	def process_response_body(body) do
        case :zip.unzip(body,[:memory]) do
            {:ok,[{_name,content}]} -> content
            {:error,_} -> body
        end |>
		Poison.decode!
	end
end
