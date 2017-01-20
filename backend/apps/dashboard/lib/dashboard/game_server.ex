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

  #
  # SERVER API
  #
  def init(_) do
    {:ok, %Game{}}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
end
