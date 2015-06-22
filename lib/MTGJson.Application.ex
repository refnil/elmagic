defmodule MTGJson.Application do
  use Application

  def start(_type, _args) do
    MTGJson.Supervisor.start_link
  end
end
