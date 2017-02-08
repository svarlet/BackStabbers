defmodule DashboardTest do
  use ExUnit.Case

  import TestHelper

  test "Starting a new game server" do
    assert {:ok, _pid} = Dashboard.start_game_server(new_id())
  end
end
