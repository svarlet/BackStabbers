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
      {:ok, {_player_1_id, game}} = Game.add_player(%Game{}, "Foo")
      {:ok, {_player_2_id, game}} = Game.add_player(game, "Bar")
      assert 2 == game.next_player_id
    end
  end

  describe "A game between Bob and Charlie" do
    setup [:create_game, :add_bob, :add_charlie]

    test "Bob is playing", context do
      [maybe_bob] = Game.find_players_by_name(context.game, "Bob")
      assert maybe_bob.name == "Bob"
    end

    test "Charlie is playing", context do
      [maybe_charlie] = Game.find_players_by_name(context.game, "Charlie")
      assert maybe_charlie.name == "Charlie"
    end
  end

  #
  # TEST SETUP UTILS
  #

  defp create_game(_context) do
    [game: %Game{}]
  end

  defp add_bob(context) do
    {:ok, {_bob_id, game}} = Game.add_player(context.game, "Bob")
    %{context | game: game}
  end

  defp add_charlie(context) do
    {:ok, {_charlie_id, game}} = Game.add_player(context.game, "Charlie")
    %{context | game: game}
  end

  describe "A game with 2 players having the same name" do
    setup [:create_game, :add_bob, :add_bob]

    test "2 players with the same name can enter the game", context do
      [bob1, bob2] =
        context.game
        |> Game.find_players_by_name("Bob")
      assert bob1.name == "Bob"
      assert bob2.name == "Bob"
    end

    test "2 players with the same name will have different ids", context do
      [bob1, bob2] = context.game
      |> Game.find_players_by_name("Bob")
      assert bob1.id != bob2.id
    end
  end

  describe "Game capacity" do
    setup :create_game

    test "A game can have up to 6 players", context do
      update_game_with_player = fn p, game ->
        {:ok, {_player_id, game}} = Game.add_player(game, p)
        game
      end
      game_with_6_players =
        ~w{p1 p2 p3 p4 p5 p6}
        |> Enum.reduce(context.game, update_game_with_player)
      assert {:error, "A game can have up to 6 players"} == Game.add_player(game_with_6_players, "p7")
    end
  end

end
