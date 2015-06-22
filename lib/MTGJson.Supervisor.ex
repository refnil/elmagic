defmodule MTGJson.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  @cache_name :MTGJsonCache
  
  def init(:ok) do
    children = [
      worker(ConCache, [[], [name: @cache_name]]),
      worker(MTGJson.Server,[@cache_name])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
