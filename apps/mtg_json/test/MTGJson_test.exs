defmodule MTGjsonTest do
    use ExUnit.Case
    import MTGJson.Application, only: [get: 1]

    def true_if_get_sucessfull(page) do
        get(page)
        true
    end

    test "Get a set" do
        assert(true_if_get_sucessfull("RTR"))
        assert(true_if_get_sucessfull("RTR"))
    end 
end
