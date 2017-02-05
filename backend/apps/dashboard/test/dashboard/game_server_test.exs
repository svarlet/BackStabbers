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
      {:ok, %Game{}} = GameServer.get_state(pid)
    end
  end

  defp start_game_server(_context) do
    {:ok, pid} = GameServer.start_link(new_id)
    [pid: pid]
  end

  describe "Setting up the game" do
    setup :start_game_server

    test "Adding a player updates the game and returns the player's id", context do
      {:ok, {player_id, %Game{players: players}}} = GameServer.add_player(context.pid, "Charlie")
      charlie = Enum.find(players, fn p -> p.name == "Charlie" end)
      assert charlie.id == player_id
    end

  end

end
