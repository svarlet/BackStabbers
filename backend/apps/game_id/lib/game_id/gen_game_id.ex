defmodule GameId.GenGameId do
  use GenServer

  @name {:global, __MODULE__}

  #
  # CLIENT API
  #

  def start_link(salt) when is_binary(salt) do
    state = Hashids.new salt: salt, min_len: 5
    case GenServer.start_link(__MODULE__, state, name: @name) do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, pid}} -> {:ok, pid}
    end
  end

  def generate do
    GenServer.call(@name, :generate)
  end

  #
  # SERVER API
  #

  def init(hashid_config) do
    {:ok, hashid_config}
  end

  def handle_call(:generate, _from, hashid_config) do
    time_now = abs System.monotonic_time(:microsecond)
    game_id = Hashids.encode(hashid_config, time_now)
    {:reply, game_id, hashid_config}
  end
end
