defmodule Dashboard.Class do
  defstruct name: "None"
end

defmodule Dashboard.Race do
  defstruct name: "Human"
end

defmodule Dashboard.PlayerStats do
  defstruct level: 1,
    force: 0
end

defmodule Dashboard.Player do
  defstruct name: "",
    id: -1,
    gender: nil,
    class: %Dashboard.Class{},
    race: %Dashboard.Race{},
    stats: %Dashboard.PlayerStats{}
end

defmodule Dashboard.Game do
  alias Dashboard.{Game, Player}

  @capacity 6

  defstruct players: [],
    next_player_id: 0

  def find_players_by_name(game, name) do
    game.players
    |> Enum.filter(fn p -> p.name == name end)
  end

  def add_player(%Game{players: players} = game, name) when length(players) < @capacity do
    new_player = %Player{name: name, id: game.next_player_id}
    updated_game = %Dashboard.Game{game |
                                   players: [new_player | game.players],
                                   next_player_id: game.next_player_id + 1}
    {:ok, {new_player.id, updated_game}}
  end

  def add_player(_, _) do
    {:error, "A game can have up to 6 players"}
  end
end
