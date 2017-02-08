defmodule GameIdTest do
  use ExUnit.Case, async: true

  test "It starts the GenGameId server" do
    assert is_pid(:global.whereis_name(GameId.GenGameId))
  end

end
