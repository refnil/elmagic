defmodule MTGJson.Application do
  use Application
  import MTGJson

  @cache_name :MTGJsonCache

  def start(_type, _args) do
    MTGJson.Supervisor.start_link @cache_name
  end

  def get(key) do
    {
      :ok, 
      ConCache.get_or_store(@cache_name, key, fn () -> MTGJson.get! key end),
    }
  end
end
