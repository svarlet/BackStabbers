defmodule Dashboard.GameServerSupervisorTest do
  use ExUnit.Case, async: true

  import TestHelper

  alias Dashboard.GameServerSupervisor

  describe "Creating game servers" do
    test "Create a nonexistent game server" do
      GameServerSupervisor.start_game_server(new_id)
    end

    test "Starting a game server with an id already in use" do
      assert {:ok, pid} = GameServerSupervisor.start_game_server(:some_id)
      assert {:ok, ^pid} = GameServerSupervisor.start_game_server(:some_id)
    end
  end
end
