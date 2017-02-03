defmodule Gateway.GameChannelTest do
  use Gateway.ChannelCase
  alias Gateway.GameChannel
  alias Dashboard.Game
  import TestHelper

  @username "Marylin"

  describe "Interacting with a game server via a channel" do
    setup [:join_channel]

    test "Create a game on join", %{id: id} do
      assert is_pid(:global.whereis_name(id))
    end

    test "Add the player to the game on join", _context do
      assert_broadcast "new_player", %Game{players: players}
      assert Enum.any?(players, fn p -> p.name == @username end)
    end
  end

  defp join_channel(_) do
    id = new_id()
    {:ok, _, socket} =
      socket("user_id", %{})
      |> subscribe_and_join(GameChannel, "game:#{id}", %{"username": @username})

    {:ok, socket: socket, id: id}
  end

end
