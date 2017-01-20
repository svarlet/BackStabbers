defmodule Dashboard.GameServerTest do
  use ExUnit.Case, async: true

  import TestHelper

  alias Dashboard.GameServer
  alias Dashboard.Game

  test "Starting the server" do
    assert {:ok, _pid} = GameServer.start_link(new_id)
  end

  test "Server state is initialized to a new Game" do
    {:ok, pid} = GameServer.start_link(new_id)
    %Game{} = GameServer.get_state(pid)
  end
end
