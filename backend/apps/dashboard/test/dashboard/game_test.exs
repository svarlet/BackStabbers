defmodule Dashboard.GameTest do
  use ExUnit.Case, async: true

  alias Dashboard.Game

  describe "Initializing a game" do
    test "A new game doesn't have any players" do
      new_game = %Game{}
      assert [] == new_game.players
    end

    test "The next player to be added will have an id of 0" do
      new_game = %Game{}
      assert 0 == new_game.next_player_id
    end

    test "Every player has a unique id" do
      new_game = %Game{}
      |> Game.add_player("Foo")
      |> Game.add_player("Bar")
      assert 2 == new_game.next_player_id
    end
  end

  describe "A game between Bob and Charlie" do
    setup [:create_game, :add_bob_and_charlie]

    test "Bob is a player", context do
      [maybe_bob] = context.game
      |> Game.find_players_by_name("Bob")
      assert maybe_bob.name == "Bob"
    end

  end

  defp create_game(_context) do
    [game: %Game{}]
  end

  defp add_bob_and_charlie(context) do
    game_with_players = context.game
    |> Game.add_player("Bob")
    |> Game.add_player("Charlie")
    %{context | game: game_with_players}
  end

end
