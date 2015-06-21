defmodule MTGjsonTest do
    use ExUnit.Case


    def true_if_get_sucessfull(page) do
        MTGjson.start
        MTGjson.get!(page)
        true
    end

    test "Get a set" do
        assert(true_if_get_sucessfull("RTR"))
    end 
end
