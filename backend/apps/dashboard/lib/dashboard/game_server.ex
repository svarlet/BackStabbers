defmodule Dashboard.GameServer do
  use GenServer

  alias Dashboard.Game

  #
  # PUBLIC API
  #
  def start_link(game_id) when is_binary(game_id) do
    case GenServer.start_link(__MODULE__, [], name: {:global, game_id}) do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, pid}} -> {:ok, pid}
    end
  end

  def get_state(server) do
    GenServer.call(server, :get_state)
  end

  def add_player(server, name) do
    GenServer.call(server, {:add_player, name})
  end

  #
  # SERVER API
  #
  def init(_) do
    {:ok, %Game{}}
  end

  def handle_call(:get_state, _from, game) do
    {:reply, {:ok, game}, game}
  end

  def handle_call({:add_player, name}, _from, game) do
    {:ok, {player_id, updated_game}} = Game.add_player(game, name)
    {:reply, {:ok, {player_id, updated_game}}, updated_game}
  end
end
