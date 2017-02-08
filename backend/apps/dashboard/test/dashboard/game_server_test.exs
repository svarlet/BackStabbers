defmodule Dashboard.GameServerTest do
  use ExUnit.Case, async: true

  import TestHelper

  alias Dashboard.GameServer
  alias Dashboard.Game

  test "Starting a game server with an id already in use" do
    assert {:ok, pid} = GameServer.start_link("foobar")
    assert {:ok, ^pid} = GameServer.start_link("foobar")
  end

  describe "Setting up a game server" do
    setup [:generate_game_id, :start_game_server]

    test "Server state is initialized to a new Game", context do
      {:ok, %Game{}} = GameServer.get_state({:global, context.game_id})
    end

    test "Adding a player updates the game and returns the player's id", context do
      {:ok, {player_id, %Game{players: players}}} =
      {:global, context.game_id}
      |> GameServer.add_player("Charlie")
      charlie = Enum.find(players, fn p -> p.name == "Charlie" end)
      assert charlie.id == player_id
    end
  end

  defp generate_game_id(_context) do
    [game_id: new_id() |> to_string()]
  end

  defp start_game_server(context) do
    GameServer.start_link(context.game_id)
    :ok
  end
end
