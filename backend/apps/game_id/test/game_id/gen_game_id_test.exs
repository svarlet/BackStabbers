defmodule GameId.GenGameIdTest do
  use ExUnit.Case, async: true

  alias GameId.GenGameId

  setup do
    GenGameId.start_link("Fourty two")
    :ok
  end

  test "Generating a game id", _context do
    game_id = GenGameId.generate
    assert is_binary(game_id)
    assert "" != game_id
    assert nil != game_id
  end

  test "Game ids are unique", _context do
    assert 10_000 =
      1..10_000
      |> Enum.map(fn _ -> GenGameId.generate end)
      |> Enum.uniq
      |> Enum.count
  end
end
