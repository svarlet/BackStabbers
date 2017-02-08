defmodule Gateway.GameChannelTest do
  use Gateway.ChannelCase

  alias Gateway.GameChannel
  alias Dashboard.Game
  alias GameId.GenGameId

  @username "Marylin"

  describe "Joining a game" do
    setup [:generate_game_id, :start_game_server, :join_channel]

    test "Add the player to the game on join", _context do
      assert_broadcast "new_player", %Game{players: players}
      assert Enum.any?(players, fn p -> p.name == @username end)
    end
  end

  defp generate_game_id(_context) do
    [game_id: GenGameId.generate()]
  end

  defp start_game_server(context) do
    Dashboard.start_game_server context.game_id
    :ok
  end

  defp join_channel(%{game_id: game_id}) do
    topic = "game:#{game_id}"
    payload = %{"username": @username}
    {:ok, _, _socket} =
      socket("user_id", %{})
      |> subscribe_and_join(GameChannel, topic, payload)
    :ok
  end

end
