defmodule MTGJson.Supervisor do
  use Supervisor

  def start_link(cache_name) do
    Supervisor.start_link(__MODULE__, {:ok,cache_name})
  end

  
  def init({:ok,cache_name}) do
    children = [
      worker(ConCache, [[ttl: 3600],[name: cache_name]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
