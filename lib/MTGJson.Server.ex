defmodule MTGJson.Server do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(cache) do
    {:ok,cache}
  end

  def get(server, key) do
    GenServer.call(server,{:get,key})
  end

  def handle_call({:get,key},_from,cache) do
    {
      :reply, 
      ConCache.get_or_store(cache, key, &MTGJson.get!/1),
      cache
    }
  end
end
