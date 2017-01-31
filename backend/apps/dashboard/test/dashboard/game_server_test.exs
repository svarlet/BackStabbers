defmodule Dashboard.GameServerTest do
  use ExUnit.Case, async: true

  import TestHelper

  alias Dashboard.GameServer
  alias Dashboard.Game

  describe "Starting a game server" do
    test "Starting the server" do
      assert {:ok, _pid} = GameServer.start_link(new_id)
    end

    test "Server state is initialized to a new Game" do
      {:ok, pid} = GameServer.start_link(new_id)
      %Game{} = GameServer.get_state(pid)
    end
  end

  defp start_game_server(_context) do
    {:ok, pid} = GameServer.start_link(new_id)
    [pid: pid]
  end

  describe "Setting up the game" do
    setup :start_game_server

    test "Adding a player", context do
      %Game{players: players} = GameServer.add_player(context.pid, "Charlie")
      assert Enum.any? players, fn p -> p.name == "Charlie" end
    end

  end

end
