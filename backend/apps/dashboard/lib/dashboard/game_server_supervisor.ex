defmodule Dashboard.GameServerSupervisor do
  use Supervisor

  @name GameServerSupervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: @name)
  end

  def start_game_server(id) do
    Supervisor.start_child(@name, [id])
  end

  def init(_) do
    children = [
      worker(Dashboard.GameServer, [], restart: :transient)
    ]
    supervise(children, strategy: :simple_one_for_one)
  end
end
