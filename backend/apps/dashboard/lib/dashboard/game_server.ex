defmodule Dashboard.GameServer do
  use GenServer

  alias Dashboard.Game

  #
  # PUBLIC API
  #
  def start_link(id) do
    case GenServer.start_link(__MODULE__, [], name: {:global, id}) do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, pid}} -> {:ok, pid}
    end
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  def add_player(pid, name) do
    GenServer.call(pid, {:add_player, name})
  end

  #
  # SERVER API
  #
  def init(_) do
    {:ok, %Game{}}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:add_player, name}, _from, game) do
    updated_game = %Game{game | players: [name | game.players]}
    {:reply, updated_game, updated_game}
  end
end
