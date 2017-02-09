defmodule Gateway.GameChannelTest do
  use Gateway.ChannelCase

  alias Gateway.GameChannel
  alias Dashboard.Game
  alias GameId.GenGameId

  describe "Joining a game" do
    setup [:generate_game_id, :start_game_server, :sign_payload, :join_channel]

    test "Reply with the player id", context do
      assert %{player_id: _} = context.join_reply
    end

    test "Add the player to the game on join", context do
      assert_broadcast "new_player", %Game{players: players}
      assert Enum.any?(players, fn p -> p.name == context.username end)
    end
  end

  describe "Deny channel authentication" do
    setup [:generate_game_id, :start_game_server]

    test "Deny authentication when payload doesn't contain a username", context do
      topic = "game:#{context.game_id}"
      payload = %{}
      assert {:error, :missing_username} = socket("user_id", %{}) |> subscribe_and_join(GameChannel, topic, payload)
    end
  end

  defp generate_game_id(_context) do
    [game_id: GenGameId.generate()]
  end

  defp start_game_server(context) do
    Dashboard.start_game_server context.game_id
    :ok
  end

  defp sign_payload(context) do
    [username: "Marylin"]
  end

  defp join_channel(%{game_id: game_id, username: username}) do
    topic = "game:#{game_id}"
    payload = %{"username": username}
    {:ok, reply, socket} =
      socket("user_id", %{})
      |> subscribe_and_join(GameChannel, topic, payload)
    [socket: socket, join_reply: reply]
  end

end
