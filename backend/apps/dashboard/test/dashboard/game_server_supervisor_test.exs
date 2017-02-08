defmodule Dashboard.GameServerSupervisorTest do
  use ExUnit.Case, async: true

  import TestHelper

  alias Dashboard.GameServerSupervisor

  test "Create a game server" do
    {:ok, pid} = GameServerSupervisor.start_game_server(new_id() |> to_string())
    assert is_pid(pid)
  end
end
